class User < ApplicationRecord
    # implemented many to many relationship attribute
    has_many :course_users
    has_many :courses, :through => :course_users
    accepts_nested_attributes_for :course_users

    # function designed to handle searching for users based on entered search params
    def self.search(search)
      # if some input was entered into the search field, else return all users
      if search
        # find all users where the input matches the department of a course they took
        found_users = User.joins(:courses).where(courses: {department: search})
        # if no users are found return all users, else return all found users
        if found_users.size.zero?
          User.all
        else
          self.where(id: found_users)
        end
      else
        User.all
      end
    end
end
