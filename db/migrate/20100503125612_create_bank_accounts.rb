class CreateBankAccounts < ActiveRecord::Migration
  def self.up
    create_table :bank_accounts do |t|
      t.string :name
      t.string :number
      t.string :bank_code
      t.string :pin
      t.string :passphrase
      t.string :passport_type
      t.string :token

      t.timestamps
    end
  end

  def self.down
    drop_table :bank_accounts
  end
end
