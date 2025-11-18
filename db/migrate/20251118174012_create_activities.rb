class CreateActivities < ActiveRecord::Migration[8.1]
  def change
    create_table :activities do |t|
      t.string :record_type
      t.bigint :record_id
      add_index :activities, [:record_type, :record_id]
      t.string :action

      t.timestamps
    end
  end
end
