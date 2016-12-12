require_relative 'test_helper'
class QuestSpec  < MiniTest::Spec

  def self.prepare
    Quest.create(title: "test_quest_1", due: Time.now)
    Quest.create(title: "test_quest_2", due: Time.now)
  end

  describe "service" do
    include Rack::Test::Methods
    QuestSpec.prepare

    def app
      Service
    end

    # Check a fetched quest attributes against its ground truth values.
    # 
    # @param quest [Quest] ground truth quest instance.
    # @param fetched_attributes [Hash] fetched quest attributes response.
    def check_result(quest, fetched_attributes)
      assert_equal(quest.id, fetched_attributes['id'])
      if fetched_attributes['description'].nil?
        assert_nil fetched_attributes['description']
      else
        assert_equal(quest.description, fetched_attributes['description'])
      end
      assert_equal(quest.start.to_s, fetched_attributes['start'])
      assert_equal(quest.due.to_s, fetched_attributes['due'])
      assert_equal(quest.finished, fetched_attributes['finished'])
    end

    before do
      @quests = Quest.all
    end

    describe "GET on /api/v1/quests" do
      it "should retireve all quests" do
        get "/api/v1/quests"
        assert_equal last_response.status, 200
        attributes = JSON.parse(last_response.body)
        assert last_response.ok?
        attributes.each_with_index do |quest_attributes, idx|
          check_result(@quests[idx], quest_attributes)
        end
      end

      describe "GET on /api/v1/quest/:id" do
        it "should find the quest for an existent id" do
          quest = @quests[0]
          get "/api/v1/quests/#{quest.id}"
          assert_equal(200, last_response.status)
          attributes = JSON.parse(last_response.body)
          check_result(quest, attributes)
        end

        it "should not find the quest for an inexistent id" do
          get "/api/v1/quests/#{-1}"
          assert_equal(404, last_response.status)
        end
      end
    end

    describe "POST on /api/v1/quests" do
      it "should create an Quest" do
        params = {
          :title => "dummy_3",
          :description => "dummy_description",
          :due => "2014-08-04-10-23"
        }
        post "/api/v1/quests", params
        assert_equal 201, last_response.status
        quest = Quest.last
        get "api/v1/quests/#{quest.id}"
        attributes = JSON.parse(last_response.body)
        check_result(quest, attributes)
        quest.destroy
      end

      it "should fail when not passing a title" do
        params = {
          :title => nil,
          :description => "dummy_description",
          :due => "2014-08-04-10-23"
        }
        post "/api/v1/quests", params
        assert_equal 400, last_response.status
        refute last_response.ok?
      end

      it "should fail when not passing a due date time" do
        params = {
          :title => "foobar",
          :due => nil,
          :description => "dummy_description",
        }
        post "/api/v1/quests", params
        assert_equal 400, last_response.status
        refute last_response.ok?
      end

      it "should fail when passing no args" do
        post "/api/v1/quests"
        refute last_response.ok?
      end
    end

    describe "PUT on /api/v1/quests" do
      it "should update an quest" do
        params = {
          :title => "dummy_quest",
          :description => "dummy_description",
          :due => Time.new("2014","08", "04", "10", "23")
        }
        quest = Quest.create params
        date_time = ["2015","09", "05", "12", "24"]
        new_params = {
          :title => "dummy_quest_new",
          :description => "dummy_description_new",
          :due => date_time.join("-")
        }
        put "/api/v1/quests/#{quest.id}", new_params
        quest.reload
        assert last_response.ok?

        attributes = JSON.parse(last_response.body)
        quest = Quest.find_by_id(quest.id)

        check_result(quest, attributes)
        quest.destroy
      end

      it "should fail to update an quest for invalid attributes" do
        params = {
          :title => "dummy_quest",
          :description => "dummy_description",
          :due => Time.new("2014","08", "04", "10", "23")
        }
        quest = Quest.create params
        date_time = ["2015","09", "05", "12", "24"]
        new_params = {
          :title => nil,
          :description => "dummy_description_new",
          :due => date_time.join("-")
        }
        put "/api/v1/quests/#{quest.id}", new_params
        quest.reload
        refute last_response.ok?

        quest.destroy
      end

      it "should fail to update an quest for nil due dates" do
        params = {
          :title => "dummy_quest",
          :description => "dummy_description",
          :due => Time.new("2014","08", "04", "10", "23")
        }
        quest = Quest.create params
        date_time = ["2015","09", "05", "12", "24"]
        new_params = {
          :description => "dummy_description_new",
          :due => nil
        }
        put "/api/v1/quests/#{quest.id}", new_params
        quest.reload
        refute last_response.ok?

        quest.destroy
      end

      it "should fail to update an quest for an invalid date format" do
        params = {
          :title => "dummy_quest",
          :description => "dummy_description",
          :due => Time.new("2014","08", "04", "10", "23")
        }
        quest = Quest.create params
        date_time = ["2015","09", "05", "12", "24"]
        new_params = {
          :due => date_time.join("/")
        }
        put "/api/v1/quests/#{quest.id}", new_params
        quest.reload
        refute last_response.ok?

        quest.destroy
      end

      it "should fail to update a quest for an invalid id." do
        params = {
          :title => "dummy_quest",
          :description => "dummy_description",
          :due => Time.new("2014","08", "04", "10", "23")
        }
        quest = Quest.create params
        date_time = ["2015","09", "05", "12", "24"]
        new_params = {
          :description => "dummy_description_new",
          :due => nil
        }
        put "/api/v1/quests/#{-1}", new_params
        quest.reload
        refute last_response.ok?

        quest.destroy
      end
    end

    describe "DELETE on /api/v1/quests/:id" do
      it "should delete an quest" do
        params = {
          :title => "dummy_quest",
          :description => "dummy_description",
          :due => Time.new("2014","08", "04", "10", "23")
        }
        quest = Quest.create params
        assert quest.valid?
        delete "/api/v1/quests/#{quest.id}"
        assert_equal last_response.status, 200
        get "/api/v1/quests/#{quest.id}"
        assert_equal(404, last_response.status)
      end

      it "shoud fail for not existing quests" do
        delete "/api/v1/quests/#{-1}"
        refute last_response.ok?
      end
    end

  end
end
