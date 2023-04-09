class LeaderController < ApplicationController
    # this controller list the users by how many hours they have done 
    def index 
        @ranking1 =rankerMentor()
        @ranking2 =rankerMentee()
    end 
    def _leaderMentor 
        @ranking =rankerMentor()
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
            count = user.hour # only gets the number of hours where its true 
            variables.push([user,count]) # push it to the array 
        end
        # sort_by automatic ruby function 
        return variables.sort_by{|var| var[1]}.reverse
    end
end
