class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :user_stocks
  has_many :stocks, through: :user_stocks


  has_many :friendships
  has_many :friends, through: :friendships
  
  def full_name
    return "#{first_name} #{last_name}".strip if (first_name || last_name)
    "Anonymous"
  end
  
  
  def stock_already_added?(ticker_symbol)
    stock = Stock.find_by_ticker(ticker_symbol)
    #Return false unless the stock already exists
    return false unless stock
    # Is the user already tracking this stock?
    user_stocks.where(stock_id: stock.id).exists?
  end
  
  def under_stock_limit?
    user_stocks.count < 10
  end

  def can_add_stock?(ticker_symbol)
    # Check to see if both conditions are met
    under_stock_limit? && !stock_already_added?(ticker_symbol)
  end

  def self.search(param)
    param.strip!
    param.downcase!
    to_send_back = (first_name_matches(param) + last_name_matches(param) + email_matches(param)).uniq
    return nil unless to_send_back
    to_send_back
  end
  
  def self.first_name_matches(param)
    matches('first_name', param)
  end
  
  def self.last_name_matches(param)
    matches('last_name', param)
  end
  
  def self.email_matches(param)
    matches('email', param)
  end
  
  def self.matches(field_name, param)
    where("#{field_name} like ?", "%#{param}%")
  end


  #Instance method, needs to match the current_user so that we don't display his email/name in the list
  def except_current_user(users)
    #Reject method, reject user from users array
    users.reject{ |user| user.id == self.id }
  end

  #Search for the friend so that we don't display an "Add as friend" button if the two are already friends
  def friends_with?(user)
    friendships.where(friend_id: user.id).present?
  end

end
