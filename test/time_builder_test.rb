require_relative 'test_helper'

class TimeBuilderTest < MiniTest::Test

  def test_invalid_for_nil
    refute TimeBuilder.new(nil).valid?
  end

  def test_invalid_for_empty_string
    refute TimeBuilder.new("").valid?
  end

  def test_invalid_for_invalid_format
    refute TimeBuilder.new("1995.08.12.22.24").valid?
    refute TimeBuilder.new("1995/08/12/22/24").valid?
  end

  def test_valid_for_correctly_formatted_input
    assert TimeBuilder.new("1995-08-12-22-24").valid?
  end

  def test_valid_for_short_correctly_formatted_input
    assert TimeBuilder.new("1995-08-12").valid?
  end

  def test_valid_for_short_correctly_formatted_input
    refute TimeBuilder.new("1995-08").valid?
    refute TimeBuilder.new("1995").valid?
    refute TimeBuilder.new("1995-08-12-22").valid?
    refute TimeBuilder.new("1995-08-12-22-24-30").valid?
  end

  def test_content_is_correctly_build_for_valid_string
    args = ["1995", "08", "12", "22", "24"]
    gt = Time.new(*args)
    assert_equal(gt, TimeBuilder.new(args.join("-")).content)

    args = ["1995", "08", "12"]
    gt = Time.new(*args)
    assert_equal(gt, TimeBuilder.new(args.join("-")).content)
  end

  def test_content_has_correct_value_in_seconds
    args = ["1995", "08", "12", "22", "24"]
    gt = Time.new(*args)
    assert_equal(gt.sec, TimeBuilder.new(args.join("-")).content.sec)
  end

  def test_content_is_nil_when_invalid
    args = ["1995", "08"]
    gt = Time.new(*args)
    assert_nil TimeBuilder.new(args.join("-")).content
  end
  
end
