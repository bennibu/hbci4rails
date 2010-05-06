# == Schema Information
#
# Table name: bank_accounts
#
#  id                         :integer(11)     not null, primary key
#  name                       :string(255)
#  number                     :string(255)
#  bank_code                  :string(255)
#  pin                        :string(255)
#  passphrase                 :string(255)
#  passport_type              :string(255)
#  token                      :string(255)
#  created_at                 :datetime
#  updated_at                 :datetime
#  passport_file_file_name    :string(255)
#  passport_file_content_type :string(255)
#  passport_file_file_size    :integer(10)
#  passport_file_updated_at   :datetime
#

class BankAccount < ActiveRecord::Base

  PASSPORT_TYPES = %w(PinTan RDHNew)

  has_attached_file :passport_file,
    :path => ":rails_root/passport_files/:id/:basename.:extension"

  validates_presence_of :number, :bank_code, :pin, :passphrase, :token

  before_validation_on_create :set_token
  
  # Umsätze von start_date bis end_date abrufen
  # * passport_type, passphrase, pin und file kommen in dieser Implementation aus der zugrunde liegenden Tabelle.
  # * Wenn passport_type = "PinTan" ist, wird die pin verwendet.
  # * Wenn passport_type = "RDHNew" ist, wird die Schlüsseldatei aus filename verwendet und mit der passphrase entschlüsselt.
  def get_transactions(start_date = 1.month.ago.to_date, end_date = Date.today)
    HBCIUtils.setParam("client.passport.#{passport_type}.filename", passport_file.path)
    HBCIUtils.setParam("client.passport.#{passport_type}.init", '1')

    passport = AbstractHBCIPassport.getInstance(passport_type, [passphrase, pin])
    handle = HBCIHandler.new(passport.getHBCIVersion, passport)
    job = handle.newJob('KUmsAll')
    my_account = passport.getAccount(number)

    job.setParam('my', my_account)
    job.setParam('startdate', JavaUtil::Date.new(start_date.year-1900, start_date.month-1, start_date.day))
    job.setParam('enddate', JavaUtil::Date.new(end_date.year-1900, end_date.month-1, end_date.day))

    job.addToQueue

    status = handle.execute

    handle.close

    if status.isOK
      result = job.getJobResult
      result.getFlatData.map { |umsline| BankTransaction.new.from_umsline(umsline) }
    else
      puts "Fehler: " + status.getErrorString
    end
  end

  private

  def set_token
    self.token = ActiveSupport::SecureRandom.base64(32).gsub("/","_").gsub(/=+$/,"")
  end
end
