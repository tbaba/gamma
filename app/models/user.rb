class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable
  devise :database_authenticatable, :rememberable, :trackable
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation

  def password_required?
    false
  end
end
