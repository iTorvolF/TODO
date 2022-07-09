class TrafficLight < ApplicationRecord
  include AASM

  enum state: {
    red: 0,
    yellow: 10,
    green: 20
  }

  aasm column: 'state' do
    state :red, initial: true, display: I18n.t('state.red')
    state :yellow, display: I18n.t('state.yellow')
    state :green, display: I18n.t('state.green')

    event :prepare, guard: LightsSwitcher do
      transitions from: :red, to: :yellow
    end

    event :go, guard: LightsSwitcher do
      transitions from: :yellow, to: :green
    end

    event :stop, guard: LightsSwitcher do
      transitions from: :green, to: :red
    end
  end
end