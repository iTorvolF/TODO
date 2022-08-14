module Callable
  extend ActiveSupport::Concern

  class_method do
    def call(*args)
      new(*args).call
    end
  end
end
