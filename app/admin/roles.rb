ActiveAdmin.register Role do
  menu priority: 3, label: 'Роли'
  permit_params %i[name code]

  filter :name, as: :select, collection: -> { Role.pluck(:name) }
  filter :code, as: :select, collection: -> { Role.pluck(:code) }
end