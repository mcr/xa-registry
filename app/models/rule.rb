class Rule < ActiveRecord::Base
  belongs_to :repository

  def document
    RuleDocument.where(_id: doc_id).first
  end
end
