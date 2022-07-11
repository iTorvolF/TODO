ActiveAdmin.register Role do
  menu priority: 3, label: proc { I18n.t('active_admin.roles') }
  permit_params %i[name code]

  filter :name, as: :select, collection: -> { Role.pluck(:name) }
  filter :code, as: :select, collection: -> { Role.pluck(:code) }
end