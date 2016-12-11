require_relative 'test_helper'

class QuestTest < MiniTest::Test

  def test_finished_by_defautlt_false
    refute Quest.new.finished
  end

  def test_finisehed_can_be_specified
    q = Quest.new(title: "foo", due: Time.now, finished: true)
    assert q.finished
  end
end
