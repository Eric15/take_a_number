class CreateServiceProviders < ActiveRecord::Migration
  def change
    create_table :service_providers do |t|
      t.string  :first_name
      t.string  :last_name
      t.integer :enqueued_event_id
      t.integer :started_event_id
      t.integer :location_id
      t.integer :tenant_id
      t.timestamps
    end
  end
end
