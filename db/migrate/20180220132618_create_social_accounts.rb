class CreateSocialAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :social_accounts do |t|
      t.integer :user_id
      t.string :uid
      t.string :provider
      t.string :token
      t.string :secret
      t.string :name
      t.string :email
      t.string :image

      t.timestamps
    end
  end
end
