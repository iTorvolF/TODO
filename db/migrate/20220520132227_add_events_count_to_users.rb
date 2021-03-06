# frozen_string_literal: true

class AddEventsCountToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :events_count, :integer
  end
end
