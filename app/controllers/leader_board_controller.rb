class LeaderBoardController < ApplicationController
    # this controller list the users by how many hours they have done 
    def index 
        @ranking =ranker()
    end 
    private  # creating a private function will allow only the classes to access the function + it will not create a view for it 
    def ranker
        variables = []
        User.all.each do |user| # looping through the users ".each"
            count = user.hours.where(hours: true).count # only gets the number of hours where its true 
            variables.push([user,count]) # push it to the array 
        end
        # sort_by automatic ruby function 
        return variables.sort_by{|var| var[1]}
    end

end