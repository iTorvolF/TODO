ActiveAdmin.register Event do
  menu priority: 2

  permit_params %i[id user_id name content done finished_at]

  index do
    id_column
    # column :name do |event| event.name.truncate(50) end
    # column :content do |event| event.content.truncate(50) end
    column I18n.t('active_admin.content') do |event|
      tag.strong(event.name) + tag.br + event.content.truncate(150)
    end
    column I18n.t('active_admin.done').capitalize, &:done
    column I18n.t('active_admin.user').capitalize, &:user
    actions
  end

  filter :id
  filter :name
  filter :content
  filter :done
  filter :finished_at

  show do
    attributes_table do
      row :id
      row :name
      row :content
      row :done
      row :finished_at
      row :user_id
      row :created_at
      row :updated_at
    end

    panel proc { I18n.t('active_admin.items') } do
      scope = resource.items.order(created_at: :desc)
      table_for scope do
        column 'ID', :id
        column 'Название', :name
        column 'Выполнено', :done
        column 'Срок выполнения', :finished_at
        column 'Дата создания', :created_at
        column 'Дата обновления', :updated_at
      end
    end
  end
end
