require 'test_helper'

class BankAccountTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end



# == Schema Information
#
# Table name: bank_accounts
#
#  id                         :integer         not null, primary key
#  name                       :string(255)
#  number                     :string(255)
#  bank_code                  :string(255)
#  passport_type              :string(255)
#  token                      :string(255)
#  created_at                 :datetime
#  updated_at                 :datetime
#  passport_file_file_name    :string(255)
#  passport_file_content_type :string(255)
#  passport_file_file_size    :integer(0)
#  passport_file_updated_at   :datetime
#

