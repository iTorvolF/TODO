class MaxEventsUsersService
  attr_accessor :max_count

  def initialize(max_count = 3)
    @max_count = max_count
  end

  def call
    User.where(id: user_ids).pluck(:email)
  end

  private

  def user_ids
    Event.group(:user_id)
         .count
         .max_by(max_count) { |_user_id, count| count}
         .map { |user_id, _count| user_id }
  end
end