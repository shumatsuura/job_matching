class CreatePostIndustries < ActiveRecord::Migration[5.2]
  def change
    create_table :post_industries do |t|
      t.integer :post_id
      t.integer :industry_id

      t.timestamps
    end
  end
end
