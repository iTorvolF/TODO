# frozen_string_literal: true

class AddEventsCounter < ActiveRecord::Migration[7.0]
  def change
    add_column :users,
               :done_counter,
               :integer,
               default: 0,
               comment: 'Счетчик выполненных дел'
    add_column :users,
               :not_done_counter,
               :integer,
               default: 0,
               comment: 'Счетчик невыполненных дел'
  end
end
