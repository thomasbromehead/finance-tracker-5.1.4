class Friendship < ApplicationRecord
  belongs_to :user
  #Create a friend alias for a user
  #Set optional to true if you want to be able to create the Experience w/o a winning_order which will be determined later on.
  belongs_to :friend, class_name: 'User', optional: true
  
end
