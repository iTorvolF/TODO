# frozen_string_literal: true

class AddUsersState < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :state, :integer, comment: 'Статусная модель пользователя'
  end
end
