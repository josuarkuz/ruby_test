class CreateTasks < ActiveRecord::Migration[8.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.string :status
      t.references :project, null: false, foreign_key: true
      t.string :assignee_type
      t.bigint :assignee_id

      t.timestamps
    end
  end
end
