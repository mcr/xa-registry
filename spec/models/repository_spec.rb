require 'rails_helper'

RSpec.describe Repository, type: :model do
  include Randomness
  
  it 'should have many rules' do
    repositories = rand_times.map { create(:repository) }
    ids = rand_times.map do
      repo = rand_one(repositories)
      rule = create(:rule, repository: repo)

      { rule_id: rule.id, repo_id: repo.id }
    end

    ids.each do |o|
      expect(Repository.find(o[:repo_id]).rules).to include(Rule.find(o[:rule_id]))
    end
  end
end
