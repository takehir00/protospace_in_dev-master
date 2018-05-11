class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :body, null:false
      t.references :user, foreign_key: true
      t.references :prototype, foreign_key: true

      t.timestamps null: false
    end
  end
end
