class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :enqueued_at
      t.datetime :delayed_at
      t.datetime :started_at
      t.datetime :finished_at
      t.string   :state, default: Event::DEFAULT
      t.string   :requested, array: true, default: "{ -1 }"
      t.string   :type
      t.integer  :sort_order
      t.integer  :customer_id
      t.integer  :tenant_id
      t.timestamps
    end
  end
end
