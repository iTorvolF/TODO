# == Schema Information
#
# Table name: traffic_lights
#
#  id         :bigint           not null, primary key
#  address    :string
#  state      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class TrafficLight < ApplicationRecord
  include AASM

  enum state: {
    red: 0,
    yellow: 10,
    green: 20
  }

  aasm column: 'state', whiny_transitions: false do
    state :red, initial: true, display: I18n.t('state.red')
    state :yellow, display: I18n.t('state.yellow')
    state :green, display: I18n.t('state.green')

    event :prepare do
      transitions from: :red, to: :yellow
    end

    event :go do
      transitions from: :yellow, to: :green
    end

    event :stop do
      transitions from: :green, to: :red
    end
  end
end