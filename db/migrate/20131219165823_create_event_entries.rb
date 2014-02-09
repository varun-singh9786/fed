class CreateEventEntries < ActiveRecord::Migration
  def change
    create_table :event_entries do |t|
      t.text :event_description
      t.integer :event_timestamp
      t.integer :event_rating
      t.references :user, index: true

      t.timestamps
    end
  end
end
