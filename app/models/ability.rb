class Ability
    include CanCan::Ability

    def initialize(admin)
        if admin.admin?
            can :manage, :all
        elsif admin.mentor?
            can :manage, User, id: admin.id
            can :manage, :add_hours, :log_hours
            can :manage, :check_code
            can :read, Consultation
        elsif admin.mentee?
            can :manage, User, id: admin.id
            can :manage, :check_code
            can :read, Consultation
        else
            cannot :manage, :all
        end
    end

end