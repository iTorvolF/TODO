module Services
  module Users
    module MaxEvents
      class Email
        include Callable
        extend Dry::Initializer

        param :max_count, default: proc { 3 }

        def call
          Queries::Users::MaxEvents.call(max_count).map(&:email)
        end
      end
    end
  end
end
