# frozen_string_literal: true

class AddUsersSettings < ActiveRecord::Migration[7.0]
  def change
    add_column :users,
               :settings,
               :jsonb,
               default: {},
               comment: 'Индивидуальные параметры пользователя'
  end
end
