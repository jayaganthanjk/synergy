class User < ActiveRecord::Base
  rolify
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  delegate :can?, :cannot?, to: :ability
end
