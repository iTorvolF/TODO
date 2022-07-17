class Queries::Users::MaxEvents
  attr_accessor :max_count

  def self.call(max_count = 3)
    new(max_count).call
  end

  def initialize(max_count)
    @max_count = max_count
  end

  def call
    Queries::Users::MaxEvents.call(max_count).pluck(:name)
  end

  private

  def user_ids
    Event.group(:user_id)
         .count
         .max_by(max_count) { |_user_id, count| count}
         .map { |user_id, _count| user_id }
  end
end