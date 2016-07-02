class User < ActiveRecord::Base
  has_many :wikis
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

 # after_create :set_default_role

  def standard?
    self.role == 'standard'
  end

  def premium?
    self.role == 'premium'
  end

  def admin?
    self.role == 'admin'
  end

  private

  def set_default_role
    self.role = 'standard'
    self.save!
  end
end
