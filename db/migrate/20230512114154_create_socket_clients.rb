class CreateSocketClients < ActiveRecord::Migration[6.1]
  def change
    create_table :socket_clients do |t|
      t.string :client_channel_id, null: false

      t.timestamps
    end
  end
end
