class User < ActiveRecord::Base
  rolify
  include PublicActivity::Model
  activist
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  delegate :can?, :cannot?, to: :ability
  has_many :notifications
  has_many :seen_notifs, -> { where(:seen => true).order('created_at desc') }, :class_name => 'Notification'
  has_many :unseen_notifs, -> { where(:seen => false).order('created_at desc') }, :class_name => 'Notification'
  has_many :projects, through: :project_roles
  has_many :comments
  has_many :bugs
  has_many :uploads

  def projects
    Project.all.select { |project| self.can? :read, project }
  end

  def isRole role
    if self.roles.find_by_name role
      return true
    else
      return false
    end
  end

  def ability
    @ability ||= Ability.new(self)
  end
end
