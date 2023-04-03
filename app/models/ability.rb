class Ability
    include CanCan::Ability

    def initialize(admin)
        if admin.admin?
            can :manage, :all
        elsif admin.mentor?
            can :manage, User, id: admin.id
            can :manage, :add_hours
            can :read, Consultation
            can :manage, :check_code
        elsif admin.mentee?
            can :manage, User, id: admin.id
            can :read, Consultation
            can :manage, :check_code
        else
            cannot :manage, :all
        end
    end

end