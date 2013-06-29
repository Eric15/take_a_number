class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text    :body
      t.integer :customer_id
      t.integer :tenant_id
      t.timestamps
    end
  end
end
