class AddStateToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :state, :integer
    remove_column :events, :done
  end
end
