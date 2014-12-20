class User < ActiveRecord::Base
  rolify
  include PublicActivity::Model
  activist
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  delegate :can?, :cannot?, to: :ability
  has_many :comments
  has_many :bugs
end
