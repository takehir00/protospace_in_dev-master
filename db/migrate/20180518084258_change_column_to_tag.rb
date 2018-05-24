class ChangeColumnToTag < ActiveRecord::Migration
  def change
    def down
      change_column :tags, null: true
    end

    def up
      change_column :tags, null: false
    end
  end
end
