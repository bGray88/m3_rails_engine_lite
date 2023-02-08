module Constraint
  class FindByName
    def matches?(request)
      request.params.key?(:name)
    end
  end
end
