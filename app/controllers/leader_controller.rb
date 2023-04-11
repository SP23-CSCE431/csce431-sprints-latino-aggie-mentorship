class LeaderController < ApplicationController
    before_action :authorize_mentor_mentee, only: :index

    # this controller list the users by how many hours they have done 
    def index 
        @ranking1 =rankerMentor()
        @ranking2 =rankerMentee()
        @ranking3 =rankerMenteeMentorPoints()
    end 
    def leaderMentor 
        @ranking =rankerMentor()
        @ranking2 =rankerMenteeMentorPoints()
    end 
    
    

    private  # creating a private function will allow only the classes to access the function + it will not create a view for it 
    def rankerMentor
        variables = []
        User.where(role: "Mentor").all.each do |user| # looping through the users ".each"
            count = user.hour # only gets the number of hours where its true 
            variables.push([user,count]) # push it to the array 
        end
        # sort_by automatic ruby function 
        return variables.sort_by{|var| var[1]}.reverse
    end
    def rankerMentee
        variables = []
        User.where(role: "Mentee").all.each do |user| # looping through the users ".each"
            count = user.points # only gets the number of hours where its true 
            variables.push([user,count]) # push it to the array 
        end
        # sort_by automatic ruby function 
        return variables.sort_by{|var| var[1]}.reverse
    end
    def rankerMenteeMentorPoints
        variables = []
        User.all.each do |user| # looping through the users ".each"
            count = user.points # only gets the number of hours where its true 
            variables.push([user,count]) # push it to the array 
        end
        # sort_by automatic ruby function 
        return variables.sort_by{|var| var[1]}.reverse
    end

    def authorize_mentor_mentee
        authorize! :manage, :leader
        rescue CanCan::AccessDenied
        # Handle access denied error by redirecting or rendering an error page
        redirect_to root_path, notice: "You are not authorized to access this page."
    end
end
