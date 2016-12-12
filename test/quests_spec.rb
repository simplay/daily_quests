require_relative 'test_helper'

describe "service" do
  include Rack::Test::Methods

  def app
    Service
  end

  before do
    @quests = []
    @quests << Quest.create(title: "test_quest_1", due: Time.now)
    @quests << Quest.create(title: "test_quest_2", due: Time.now)
  end

  describe "GET on /api/v1/quests" do
    it "should retireve all quests" do
      get "/api/v1/quests"
      assert_equal last_response.status, 200
      attributes = JSON.parse(last_response.body)
      assert last_response.ok?

      attributes.each_with_index do |quest_attributes, idx|
        quest = @quests[idx]
        assert_equal(quest_attributes['id'], quest.id)
        assert_equal(quest_attributes['title'], quest.title)
        assert_equal(quest_attributes['description'], quest.description)
        assert_equal(quest_attributes['start'], quest.created_at.to_s)
        assert_equal(quest_attributes['due'], quest.due.to_s)
        assert_equal(quest_attributes['finished'], quest.finished)
      end
    end
  end

end
