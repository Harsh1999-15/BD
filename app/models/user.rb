class User < ApplicationRecord
  rolify
  attr_accessor :remove_image
  has_one_attached :image, dependent: :destroy
  has_many :books, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :username, presence:true, uniqueness:true
  validates :unique_id, presence:true, uniqueness:true ,format: { with: /\A(\b[A-Z]+\s+\d{1,9})*\z/, message: "please enter keywords in correct format"}
  #before_save :uppercase_id
  after_create :assign_default_role
  def uppercase_id
    self[:unique_id] = self.unique_id.upcase
  end
  # def assign_default_role
  #   self.add_role(:reader) if self.roles.blank?
  # en
  

  def assign_default_role
     if self.roles.blank?
      ch = unique_id.split(" ")
      if ch[0]=="AU" || ch[0]=="au"
        self.add_role(:author)
      # elsif ch[0]== "VIP" || ch[0]=="vip" 
      #   self.add_role(:vip)
      else
        self.add_role(:reader)
      end
     end
  end



  attr_writer :login

  def login
    @login || self.username || self.email || self.unique_id
  end

  def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if (login = conditions.delete(:login))
        where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value OR lower(unique_id) = :value", { :value => login.downcase }]).first
      elsif conditions.has_key?(:username) || conditions.has_key?(:email) || conditions.has_key?(:unique_id)
        where(conditions.to_h).first
      end
  end
end
