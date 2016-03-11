require 'rails_helper'

describe Api::V1::RepositoriesController, type: :controller do
  include Randomness
  
  def response_json
    MultiJson.decode(response.body)
  end

  it 'will create a new repository' do
    rand_times.map do
      { url: Faker::Internet.url }
    end.each do |vals|
      post(:create, repository: vals)
      
      expect(response).to be_success
      expect(response).to have_http_status(200)

      repo = Repository.find_by(url: vals[:url])
      expect(repo.url).to eql(vals[:url])
      expect(response_json.fetch('public_id')).to eql(repo.public_id)
    end
  end

  it 'will update an existing repository' do
    rand_times.map do
      create(:repository)
    end.each do |repo|
      url = Faker::Internet.url

      @request.headers['Content-Type'] = 'application/json'
      put(:update, id: repo.public_id, repository: { url: url})      

      expect(response).to be_success
      expect(response).to have_http_status(200)

      repo = Repository.find(repo.id)
      expect(repo.url).to eql(url)
    end
  end

  it 'should not update a non-existant repo' do
    rand_times.map do
      { id: UUID.generate, url: Faker::Internet.url }
    end.each do |vals|
      put(:update, id: vals[:id], repository: vals.except(:id))

      expect(response).to_not be_success
      expect(response).to have_http_status(404)
    end
  end

  it 'should delete existing repos' do
    rand_times.map do
      create(:repository)
    end.each do |repo|
      delete(:destroy, id: repo.public_id)

      expect(response).to be_success
      expect(response).to have_http_status(200)

      expect(Repository.find_by_id(repo.id)).to be_nil
    end
  end

  it 'should not delete existing repos' do
    rand_times.map do
      UUID.generate
    end.each do |id|

      delete(:destroy, id: id)

      expect(response).to_not be_success
      expect(response).to have_http_status(404)
    end
  end
end
  
