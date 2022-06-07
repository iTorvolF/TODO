module Entities
  class User < Grape::Entity
    root 'users', 'user'

    expose :id,
           :name,
           :role

    def role
      object.role.code
    end
  end
end