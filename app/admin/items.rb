ActiveAdmin.register Item do
  menu priority: 4, label: proc { I18n.t('active_admin.items') }
  permit_params %i[name event_id done finished_at]

  filter :name
  filter :event_id
  filter :done
  filter :finished_at
end