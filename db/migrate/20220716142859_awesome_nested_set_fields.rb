class AwesomeNestedSetFields < ActiveRecord::Migration[7.0]
  def change
    ActiveRecord::Base.connection.truncate(:comments)
    add_column :comments, :lft, :integer, null: false, index: true,
               comment: 'Левая граница множества в рамках гема awesome_nested_set_fields'
    add_column :comments, :rgt, :integer, null: false, index: true,
              comment: 'Правая граница множества в рамках гема awesome_nested_set_fields'
    add_column :comments, :depth, :integer, null: false, default: 0,
               comment: 'Глубина вложения узла в рамках гема awesome_nested_set_fields'
    add_column :comments, :children_count, :integer, null: false, default: 0,
               comment: 'Количество потомков в рамках гема awesome_nested_set_fields'
  end
end
