class Course < ApplicationRecord
    # implemented many to many relationship attribute
    has_many :course_users
    has_many :users, :through => :course_users
end
