class CreateTrafficLights < ActiveRecord::Migration[7.0]
  def change
    create_table :traffic_lights, comment: 'Светофоры города' do |t|
      t.string :address, comment: 'Адрес установки светофора'

      t.timestamps
    end
  end
end
