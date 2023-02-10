module Constraints
  class FindByName
    def matches?(request)
      request.params.key?(:name) && !(request.params.key?(:min_price) || request.params.key?(:max_price))
    end
  end
end
