class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_destroy    :log_before_destory
  after_destroy     :log_after_destory
  before_validation :normalize_name, on: :create
  before_validation :normalize_email, if: Proc.new { |u| u.email.present? }  
  before_validation :set_role, on: [ :create, :update ]    

  validates :name, presence: true
  validates :name, length: { maximum: 16, minimum: 2 }
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
  has_many :comments, dependent: :destroy
  has_many :commented_events,
           through: :comments,
           source: :commentable,
           source_type: :Event
  has_many :commented_users,
           through: :comments,
           source: :commentable,
           source_type: :User      

  Role.find_each do |role|
    define_method "#{role.code}?" do
      role_id == role.id
     end
  end

  private

  def log_before_destory
    Rails.logger.info "##### Собираемся удалить пользователя #{name} #####"
  end

  def log_after_destory
    Rails.logger.info "########### Пользователь #{name} удален ###########"
  end

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
