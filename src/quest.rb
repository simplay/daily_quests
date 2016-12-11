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
      :start => created_at,
      :due => due,
      :finished => finished
    }
  end

  private

  # Set the default values of a new quest instance.
  def set_default_values
    self.finished ||= false
  end
end
