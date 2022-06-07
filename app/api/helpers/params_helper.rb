module ParamsHelper
  extend Grape::API::Helpers

  params :filters do
    optional :all,
             type: Boolean,
             desc: 'весь список, включая завершенные'
  end
end