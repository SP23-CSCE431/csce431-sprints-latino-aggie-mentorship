class Hobby < ApplicationRecord
    # implemented many to many relationship attribute
    has_many :hobby_users
    has_many :users, :through => :hobby_users
end
