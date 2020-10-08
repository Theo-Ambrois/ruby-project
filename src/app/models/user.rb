class User < ApplicationRecord
	after_create :assign_default_role
  	rolify

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

	def assign_default_role
		self.add_role(:normal) if self.roles.blank?
	end
  has_and_belongs_to_many :movies
end
