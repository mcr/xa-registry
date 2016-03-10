module Api
  module V1
    class RulesController < ActionController::Base
      before_filter :maybe_find_rule_by_version, only: [:by_version]
      before_filter :maybe_find_rule, only: [:update]
      before_filter :maybe_find_rules, only: [:show]

      def update
        if @rule
          @rule.update_attributes(version: Time.now.utc.to_i)
          render(json: { version: @rule.version })
        elsif params.key?('id')
          @rule = Rule.create(name: params['id'], version: Time.now.utc.to_i)
          render(json: { version: @rule.version })
        end
      end
      
      def by_version
        if @rule
          render(json: {})
        else
          render(nothing: true, status: :not_found)
        end
      end

      def show
        if @rules && @rules.any?
          render(json: { versions: @rules.map { |rule| rule.version }})
        else
          render(nothing: true, status: :not_found)
        end
      end

      private

      def maybe_find_rules
        id = params.fetch('id', nil)
        @rules = Rule.where(name: id) if id
      end
      
      def maybe_find_rule_by_version
        id = params.fetch('id', nil)
        version = params.fetch('version', nil)
        @rule = Rule.find_by(name: id, version: version) if id && version
      end

      def maybe_find_rule
        id = params.fetch('id', nil)
        @rule = Rule.find_by(name: id) if id
      end
    end
  end
end
