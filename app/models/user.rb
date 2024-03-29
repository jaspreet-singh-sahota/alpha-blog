class User < ApplicationRecord
    before_save { self.email = email.downcase }
    validates :name, presence: true, 
                    uniqueness: { case_sensitive: false}, 
                    length: { minimun: 2 , maximum: 25 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true,
                    uniqueness: { case_sensitive: false}, 
                    length: { maximum: 50 },
                    format: { with: VALID_EMAIL_REGEX }
    has_many :articles , dependent: :destroy
    has_secure_password

end