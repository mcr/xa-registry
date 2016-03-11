class RuleDocument
  include Mongoid::Document

  field :name, type: String
  field :version, type: String
  field :content, type: Hash
end
