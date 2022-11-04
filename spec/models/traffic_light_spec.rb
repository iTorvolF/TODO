require "rails_helper"

RSpec.describe TrafficLight, type: :model do
  it do
    traffic_light = TrafficLight.create

    traffic_light.updated_at = 20.seconds.ago
    expect(traffic_light).to be_red
    expect(traffic_light.aasm.human_state).to eq "Красный сигнал"

    traffic_light.updated_at = 20.seconds.ago
    traffic_light.prepare!
    expect(traffic_light).to be_yellow
    expect(traffic_light.aasm.human_state).to eq "Желтый сигнал"

    expect { traffic_light.prepare }.to raise_error(AASM::InvalidTransition)
    expect(traffic_light.may_prepare?).to be_falsey

    traffic_light.updated_at = 20.seconds.ago
    traffic_light.go!
    expect(traffic_light).to be_green
    expect(traffic_light.aasm.human_state).to eq "Зеленый сигнал"

    traffic_light.updated_at = 20.seconds.ago
    traffic_light.stop!
    expect(traffic_light).to be_red
    expect(traffic_light.aasm.human_state).to eq "Красный сигнал"
  end
end    