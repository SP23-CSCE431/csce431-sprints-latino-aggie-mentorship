class UserEvent < ApplicationRecord
    belongs_to :consultation
    belongs_to :user
    accepts_nested_attributes_for :consultation
end
