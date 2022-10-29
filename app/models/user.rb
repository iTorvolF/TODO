# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  active                 :boolean          default(TRUE)
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  done_counter           :integer          default(0)
#  email                  :string
#  encrypted_password     :string           default(""), not null
#  events_count           :integer
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  name                   :string
#  not_done_counter       :integer          default(0)
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  settings               :jsonb
#  sign_in_count          :integer          default(0), not null
#  state                  :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  role_id                :integer
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_name                  (name) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (role_id => roles.id)
#
class User < ApplicationRecord
  include Rolable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable, :registerable

  # before_destroy    :log_before_destory
  # after_destroy     :log_after_destory
  before_validation :normalize_name, on: :create
  before_validation :normalize_email, if: proc { |u| u.email.present? }
  before_validation :set_role, on: %i[create update]

  validates :name, presence: true
  validates :name, length: { maximum: 50, minimum: 2 }
  validates :name, uniqueness: true

  scope :default, -> { where(role_id: Role.find_by(code: :default).id) }
  scope :fresh, ->(created_at) { where('created_at > ?', created_at) }
  scope :default_fresh, ->(created_at) { default.fresh(created_at) }

  store :settings, coder: JSON
  store_accessor :settings, :per_page, :time_zone, :show_help

  enum state: {
    created: 1,
    email_verified: 2,
    studied: 3,
    actived: 4,
    disabled: 5
  }

  belongs_to :role
  has_many :events, dependent: :destroy
  has_many :items, through: :events
  has_many :comments, dependent: :destroy
  has_many :commented_events,
           through: :comments,
           source: :commentable,
           source_type: :Event
  has_many :commented_users,
           through: :comments,
           source: :commentable,
           source_type: :User

  has_one_attached :avatar

  act_as_rolable

  def admin?
    role&.code == 'admin'
  end

  def description
    "#{name} (#{email})"
  end

  def active_for_authentication?
    super && active?
  end

  private

  # def log_before_destory
  #   Rails.logger.info "##### Собираемся удалить пользователя #{name} #####"
  # end

  # def log_after_destory
  #   Rails.logger.info "########### Пользователь #{name} удален ###########"
  # end

  def normalize_name
    self.name = name&.downcase&.titleize
  end

  def set_role
    self.role ||= Role.find_by(code: :default)
  end

  def normalize_email
    self.email = email&.downcase
  end
end
