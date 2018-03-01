class AddSubProviderToSocialAccount < ActiveRecord::Migration[5.1]
  def change
    add_column :social_accounts, :sub_provider, :string
  end
end
