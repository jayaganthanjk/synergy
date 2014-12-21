class Notification < ActiveRecord::Base
	include PublicActivity::Model

	belongs_to :user
	validates :seen, inclusion: { in: [true, false] }

	def notifs_create(resource, activity_id)
		user_list = find_users resource
		user_list.each do |user|
			user.notifications.create(activity_id: activity_id) if check_and_create(resource, user, activity_id)
		end
		superadmins = User.with_role :super_admin
		superadmins.each do |sup|
			sup.notifications.create(activity_id: activity_id) if check_and_create(resource, sup, activity_id)
		end
	end

	def check_and_create(resource, user, activity_id)
		if get_activity_owner(activity_id) == user
			return false
		end
		parent = find_parent(resource)
		roles = user.roles.where(resource_id: parent.id).map(&:name)
		roles += user.roles.where(name: "super_admin").map(&:name)
		role = get_highest_role(roles).to_s
		case role
			when 'super_admin'
				return true
			 
			when 'admin'
				if ['Sprint', 'Story', 'Bug', 'Task', 'Comment', 'Upload'].include? resource.class.to_s
					return true
				else
					return false
				end
			
			when 'developer'
				if ['Story', 'Comment', 'Bug', 'Task', 'Upload'].include? resource.class.to_s 
					return true
				else
					return false
				end
			
			when 'client'
				if  ['Story', 'Bug'].include? resource.class.to_s
					return true
				else
					return false
				end
		end
	end

	def get_highest_role(roles)
		hierarchy = { :super_admin => 1, :admin => 2, :developer => 3, :tester => 4, :client => 5 }
		arry = []
		to_array(roles).each do |role|
			arry << hierarchy[role.to_sym]
		end 	
		highest = hierarchy.key(arry.min)
		highest
	end 

	def find_users(resource)
		superadmins = User.with_role :super_admin
		case resource.class.to_s 
			when 'Project'
				return resource.users.uniq
			when 'Sprint', 'Story', 'Upload'
				return resource.project.users.uniq - superadmins
			when 'Comment'
				if resource.owner_type == 'Bug'
					return resource.owner.story.project.users.uniq - superadmins
				else
					return resource.owner.project.users.uniq - superadmins
				end
			when 'Task', 'Bug'
				return resource.story.project.users.uniq - superadmins
		end
	end

	def find_parent(resource)
		case resource.class.to_s 
			when 'Project'
				return resource
			when 'Sprint', 'Story', 'Upload'
				return resource.project
			when 'Task', 'Bug'
				return resource.story.project
			when 'Comment' 
				if resource.owner_type == 'Bug'
					return resource.owner.story.project
				else
					return resource.owner.project
				end
		end
	end

	def user_signup(user, activity_id)
		superadmins = User.with_role :super_admin
		superadmins.each do |sup|
			notification = sup.notifications.create(activity_id: activity_id)
		end
	end

	def get_activity_owner(activity_id = nil)
		activity_id == nil ? PublicActivity::Activity.find(self.activity_id).owner : PublicActivity::Activity.find(activity_id).owner
	end

	def get_activity(activity_id = nil)
		activity_id == nil ? PublicActivity::Activity.find(self.activity_id) : PublicActivity::Activity.find(activity_id)
	end

	private

	def to_array(element)
		element.class == Array ? element : Array(element) 
	end

	def seen!
		update(:seen => true)
	end

end
