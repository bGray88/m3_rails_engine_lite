module Constraints
  class FindByPrice
    def matches?(request)
      (request.params.key?(:min_price) || request.params.key?(:max_price)) && !request.params.key?(:name)
    end
  end
end
