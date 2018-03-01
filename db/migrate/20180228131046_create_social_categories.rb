class CreateSocialCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :social_categories do |t|
      t.string :name
      t.boolean :active, default: false
      t.integer :user_id

      t.timestamps
    end
  end
end
