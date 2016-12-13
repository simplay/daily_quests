# TimeBuilder builds a Time instance from a given string.
# The input string is supposed to be in the following format: YYYY-MM-DD-hh-mm
# The quantities hour (hh) and minutes (mm) are optional but
# if someone is using hours, also minutes have to be specified.
#
# Example: the 12th of August in 1995 at 22:24 o'clock: 
#   a_valid_string       = "1995-08-12-22:24"
#   another_valid_string = "1995-08-12"
#   invalid_string       = "1995-08"
#   invalid_string_2     = "1995-08-12-22-24-30"
#   
class TimeBuilder

  # Prepares a given inputs string by splitting its elements.
  # 
  # @param date_time_string [Time] in the format YYYY-MM-DD-hh-mm
  def initialize(date_time_string)
    @date_elements = []   
    @date_elements = date_time_string.split("-") unless date_time_string.nil?
  end

  # Checks whether the string exhibits a valid format.
  #
  # @return [Boolean] true if the string has a correct input format,
  #   otherwise false.
  def valid?
    @date_elements.count == 3 || @date_elements.count == 5
  end

  # Obtain a new Time instance from the given date string.
  #
  # @return [Time, nil] the built Time object from the given
  #   formatted date string.
  def content
    return nil unless valid?
    Time.new(*@date_elements)
  end
end
