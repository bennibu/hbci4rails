class RemovePinAndPassphraseFromBankAccount < ActiveRecord::Migration
  def self.up
    remove_column :bank_accounts, :pin, :passphrase
  end

  def self.down
  end
end
