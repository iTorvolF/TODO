# == Schema Information
#
# Table name: traffic_lights
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(TRUE)
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

  aasm column: 'state' do
    state :red, initial: true, display: I18n.t('state.red')
    state :yellow, display: I18n.t('state.yellow'), before_enter: :logging
    state :green, display: I18n.t('state.green'), before_enter: :logging

    after_all_transitions :log_status_change

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

  def log_status_change
    logstr = 'Изменение состояния с %s на %s (event: %s)'
    Rails.logger.info format(logstr,
                             aasm.from_state,
                             aasm.to_state,
                             aasm.current_event)
  end

  def logging
    Rails.logger.info 'Смена цвета'
  end
end
