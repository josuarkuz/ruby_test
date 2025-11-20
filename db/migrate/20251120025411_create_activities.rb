class CreateActivities < ActiveRecord::Migration[8.1]
  def change
    create_table :activities do |t|
      t.string :record_type
      t.integer :record_id
      t.string :action
      t.integer :actor_id
      t.jsonb :metadata

      t.timestamps
    end
  end
end
