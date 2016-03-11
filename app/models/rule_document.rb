class RuleDocument
  include Mongoid::Document

  field :content, type: Hash
end
