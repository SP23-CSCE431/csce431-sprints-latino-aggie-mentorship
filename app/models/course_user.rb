class CourseUser < ApplicationRecord
    # implemented many to many relationship attribute as the join table
    belongs_to :course
    belongs_to :user
    accepts_nested_attributes_for :course
end
