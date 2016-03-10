module Api
  module V1
    class RulesController < ActionController::Base
      def by_version
        render(json: {})
      end
    end
  end
end
