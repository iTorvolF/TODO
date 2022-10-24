module Currency
  extend ActiveSupport::Concern

  def currency_types
    Types::String.default('RUB').enum('RUB', 'USD', 'EUR')
  end
end
