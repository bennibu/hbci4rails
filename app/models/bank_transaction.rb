# == Schema Information
#
# Table name: bank_transactions
#
#  date           :date
#  from_name      :string
#  from_number    :string
#  from_bank_code :string
#  note           :text
#  amount         :decimal(, )
#

# Transform hbci4java result into simple rails objects
# More infos about original data: http://hbci4java.kapott.org/javadoc/org/kapott/hbci/GV_Result/GVRKUms.UmsLine.html

class BankTransaction < ActiveRecord::Base
  def self.columns() @columns ||= []; end

  def self.column(name, sql_type = nil, default = nil, null = true)
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type.to_s, null)
  end

  column :date, :date
  column :from_name, :string
  column :from_number, :string
  column :from_bank_code, :string
  column :note, :text
  column :amount, :decimal

  def from_umsline(umsline)
    self.date = Date.parse(umsline.bdate.to_s)
    unless umsline.other.nil?
      self.from_name = umsline.other.name
      self.from_number = umsline.other.number
      self.from_bank_code = umsline.other.blz
    end
    self.note = umsline.usage.join("\n")
    self.amount = umsline.value.getDoubleValue
    self
  end
  
end

