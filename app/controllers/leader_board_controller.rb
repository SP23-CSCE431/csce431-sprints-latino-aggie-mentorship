class LeaderBoardController < ApplicationController
    # this controller list the users by how many hours they have done 
    def index 
        @ranking =ranker()
    end 
    private  # creating a private function will allow only the classes to access the function + it will not create a view for it 
    def ranker
        variables = []
        User.all.each do |user|
            count = user.hours.where(hours: true).count
            variables.push([user,count])
        end
        # sort_by automatic ruby function 
        return variables.sort_by{|var| var[1]}
    end


end
