class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :manage, :all if user.has_role? :super_admin

    #abilities for admin
    can [:read, :show], Project do |project|
      Project.with_role(:admin, user).pluck(:id).include?(project.id)
    end
    can [:manage], Story do |story|
      Project.with_role(:admin, user).pluck(:id).include?(story.project.id)
    end
    can [:manage], Sprint do |sprint|
      Project.with_role(:admin, user).pluck(:id).include?(sprint.project.id)
    end
    can [:manage], Task do |task|
      Project.with_role(:admin, user).pluck(:id).include?(task.story.project.id)
    end
    can [:manage], Timelog do |timelog|
      case timelog.parent_type
        when 'Task'
          Project.with_role(:developer, user).pluck(:id).include?(timelog.parent.project.id)
        when 'Project'
           Project.with_role(:developer, user).pluck(:id).include?(timelog.parent.id)
      end
    end
     can [:manage], Comment do |comment|
      case comment.owner_type
        when 'Story'
          Project.with_role(:admin, user).pluck(:id).include?(comment.owner.project.id)
        when 'Bug'
          Project.with_role(:admin, user).pluck(:id).include?(comment.owner.story.project.id)
      end
    end
    can [:manage], Bug do |bug|
      Project.with_role(:admin, user).pluck(:id).include?(bug.story.project.id)
    end


    #abilities for admin_tech
    can [:read, :show], Project do |project|
      Project.with_role(:admin_tech, user).pluck(:id).include?(project.id)
    end
    can [:manage], Story do |story|
      Project.with_role(:admin_tech, user).pluck(:id).include?(story.project.id)
    end
    can [:manage], Sprint do |sprint|
      Project.with_role(:admin_tech, user).pluck(:id).include?(sprint.project.id)
    end
    can [:manage], Task do |task|
      Project.with_role(:admin_tech, user).pluck(:id).include?(task.story.project.id)
    end
   can [:manage], Timelog do |timelog|
      case timelog.parent_type
        when 'Task'
          Project.with_role(:developer, user).pluck(:id).include?(timelog.parent.project.id)
        when 'Project'
           Project.with_role(:developer, user).pluck(:id).include?(timelog.parent.id)
      end
    end
     can [:manage], Comment do |comment|
      case comment.owner_type
        when 'Story'
          Project.with_role(:admin_tech, user).pluck(:id).include?(comment.owner.project.id)
        when 'Bug'
          Project.with_role(:admin_tech, user).pluck(:id).include?(comment.owner.story.project.id)
      end
    end
    can [:manage], Bug do |bug|
      Project.with_role(:admin_tech, user).pluck(:id).include?(bug.story.project.id)
    end

    #abilities for developer
    can [:read, :show], Project do |project|
      Project.with_role(:developer, user).pluck(:id).include?(project.id)
    end
    can [:manage], Story do |story|
      Project.with_role(:developer, user).pluck(:id).include?(story.project.id)
    end
    can [:read], Sprint do |sprint|
      Project.with_role(:developer, user).pluck(:id).include?(sprint.project.id)
    end
    can [:manage], Task do |task|
      Project.with_role(:developer, user).pluck(:id).include?(task.story.project.id)
    end
    can [:manage], Timelog do |timelog|
      case timelog.parent_type
        when 'Task'
          Project.with_role(:developer, user).pluck(:id).include?(timelog.parent.project.id)
        when 'Project'
           Project.with_role(:developer, user).pluck(:id).include?(timelog.parent.id)
      end
    end
    can [:manage], Comment do |comment|
      case comment.owner_type
        when 'Story'
          Project.with_role(:developer, user).pluck(:id).include?(comment.owner.project.id)
        when 'Bug'
          Project.with_role(:developer, user).pluck(:id).include?(comment.owner.story.project.id)
      end
    end
    can [:manage], Bug do |bug|
      Project.with_role(:developer, user).pluck(:id).include?(bug.story.project.id)
    end


    #abilities for tester
    can [:read, :show], Project do |project|
      Project.with_role(:tester, user).pluck(:id).include?(project.id)
    end
    can [:read], Story do |story|
      Project.with_role(:tester, user).pluck(:id).include?(story.project.id)
    end
    can [:read], Sprint do |sprint|
      Project.with_role(:tester, user).pluck(:id).include?(sprint.project.id)
    end
    can [:manage], Comment do |comment|
      case comment.owner_type
        when 'Story'
          Project.with_role(:tester, user).pluck(:id).include?(comment.owner.project.id)
        when 'Bug'
          Project.with_role(:tester, user).pluck(:id).include?(comment.owner.story.project.id)
      end
    end
    can [:manage], Bug do |bug|
      Project.with_role(:tester, user).pluck(:id).include?(bug.story.project.id)
    end

  end

end