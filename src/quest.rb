# == Schema Information
#
# Table name: quests
#
#  id          :integer          not null, primary key
#  title       :string
#  description :string
#  due         :datetime
#  finished    :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

# A Quest models a task which should be finished until a certain #due date.
# It may contain an optional description.
class Quest < ActiveRecord::Base
  validates :title,
            :due, presence: true

  after_initialize :set_default_values

  # Serialized this Quest instance to a hash.
  # 
  # @return [Hash] relevant API data
  def to_hash
    {
      :id => id,
      :title => title,
      :description => description,
      :start => start.to_s,
      :due => due.to_s,
      :finished => finished
    }
  end

  # Get this quest's creation date and time.
  # 
  # @return [Time] created at date time.
  def start
    created_at
  end

  private

  # Set the default values of a new quest instance.
  def set_default_values
    self.finished ||= false
  end
end
