class HobbyUser < ApplicationRecord
    # implemented many to many relationship attribute as the join table
    belongs_to :hobby
    belongs_to :user
    accepts_nested_attributes_for :hobby
end
