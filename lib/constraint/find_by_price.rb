module Constraint
  class FindByPrice
    def matches?(request)
      request.params.key?(:min_price) || request.params.key?(:max_price)
    end
  end
end
