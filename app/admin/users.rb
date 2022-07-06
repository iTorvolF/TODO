ActiveAdmin.register User do
  menu priority: 1, label: proc { I18n.t('active_admin.users') }
  permit_params :email, :name, :active, :role_id, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column I18n.t('active_admin.resources.user.email').capitalize, &:email
    column I18n.t('active_admin.resources.user.name').capitalize, &:name
    column I18n.t('active_admin.resources.user.active').capitalize, &:active
    column I18n.t('active_admin.resources.user.role').capitalize, &:role
    actions
  end

  csv do
    column :id
    column :name
    column :email
    column(:role) { |user| user.role.code }
  end

  filter :email 
  filter :name
  filter :active
  filter :role

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :email
      f.input :name
      f.input :active
      f.input :role
      if f.object.new_record?
        f.input :password
        f.input :password_confirmation
      end
    end
    f.actions do
      f.action :submit, label: 'Отправить', as: :button
    end
  end
end
