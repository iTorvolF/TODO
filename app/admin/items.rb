ActiveAdmin.register Item do
  menu priority: 4, label: 'Подпункты'
  permit_params %i[name event_id done finished_at]

  filter :name
  filter :event_id
  filter :done
  filter :finished_at
end