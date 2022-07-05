module ActiveAdmin
  class ApplicationPolicy
    attr_reader :user, :record

    def initialize(user, record)
      @user = user
      @record = record
    end

    def report?
      user.admin?
    end

    def download?
      user.admin?
    end

    def upload?
      user.admin?
    end
    
    def index?
      user.admin?
    end

    def show?
      user.admin?
    end

    def read?
      user.admin?
    end

    def show?
      user.admin?
    end

    def create?
      user.admin?
    end

    def update?
      user.admin?
    end

    def destroy?
      user.admin?
    end

    class Scope
      def initialize(user, scope)
        @user = user
        @scope = scope
      end

      def resolve
        scope.all
      end

      private

      attr_reader :user, :scope
    end
  end
end