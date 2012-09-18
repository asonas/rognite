class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer :project_id
      t.integer :user_id
      t.text :body

      t.timestamps
    end
  end
end
