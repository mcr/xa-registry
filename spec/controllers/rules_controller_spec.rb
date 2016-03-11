require 'rails_helper'

describe Api::V1::RulesController, type: :controller do
  include Randomness
  
  def response_json
    MultiJson.decode(response.body)
  end
  
  describe 'GET :name/:version' do
    it 'loads the correct rule by name and version' do
      rand_times.map do
        rule = create(:rule)
        { id: rule.name, version: rule.version }
      end.each do |vals|
        get(:by_version, vals)

        expect(response).to be_success
        expect(response).to have_http_status(200)

        expect(response_json).to eql({})
      end
    end

    it 'lists all rules with versions' do
      names = rand_array(5) do
        Faker::Hipster.word
      end
      expected = rand_times(20).map do
        create(:rule, name: rand_one(names), version: Faker::Number.hexadecimal(6))
      end.inject({}) do |o, rule|
        o.merge(rule.name => o.fetch(rule.name, []) << rule.version)
      end

      get(:index)

      expect(response).to be_success
      expect(response).to have_http_status(200)
      
      response_json.each do |o|
        name = o.fetch('name', nil)
        expect(name).to_not be_nil

        expect(expected).to have_key(name)
        expect(o.fetch('versions', [])).to eql(expected[name])
      end
    end
    
    it 'delivers versions when all rules of a name are requested' do
      names = rand_times(5).map do
        Faker::Hipster.word
      end

      counts = names.inject({}) do |o, name|
        count = rand_times(10).map do |i|
          create(:rule, name: name, version: i.to_s)
        end.length
        
        o.merge(name => count)
      end

      names.each do |name|
        rules = Rule.where(name: name)
        expect(rules.length).to eql(counts[name])

        get(:show, id: name)

        expect(response).to be_success
        expect(response).to have_http_status(200)

        versions = rules.map { |rule| rule.version }
        expect(response_json.fetch('versions', [])).to eql(versions)
      end
    end

    it 'responds with a failure when versions are requested for an unknown rule' do
      rand_times(5).each do |name|
        get(:show, id: name)

        expect(response).to_not be_success
        expect(response).to have_http_status(404)
      end
    end
    
    it 'generates a failure when unknown rules or versions are requested' do
      rule0 = create(:rule)

      rand_times.map do |i|
        { id: rule0.name, version: i.to_s }
      end.each do |vals|
        get(:by_version, vals)

        expect(response).to_not be_success
        expect(response).to have_http_status(404)
      end
    end

    it 'should generate a new version of a rule when rule JSON is PUT' do
      rand_times.map do
        create(:rule)
      end.each do |rule|
        @request.headers['Content-Type'] = 'application/json'
        put(:update, id: rule.name)

        expect(response).to be_success
        expect(response).to have_http_status(200)

        version = response_json.fetch('version', nil)
        expect(version).to_not be_nil
        expect(version).to_not eql(rule.version)
        expect(version).to eql(Rule.find_by(name: rule.name).version)
      end
    end

    it 'should create rules when PUTting a non-existing rule' do
      rand_times.map do
        Faker::Hipster.word
      end.each do |name|
        @request.headers['Content-Type'] = 'application/json'
        put(:update, id: name)

        expect(response).to be_success
        expect(response).to have_http_status(200)

        version = response_json.fetch('version', nil)
        expect(version).to_not be_nil

        rule = Rule.find_by(name: name)
        expect(rule).to_not be_nil
        expect(version).to eql(rule.version)
      end      
    end
  end
end
