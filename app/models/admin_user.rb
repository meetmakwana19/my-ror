class AdminUser < ApplicationRecord
    # m:n associations
    # has_and_belongs_to_many :pages, optional: true
    # has_and_belongs_to_many :pages, required: false
    has_and_belongs_to_many :pages
    
    has_many :section_edits
    has_many :sections, :through => :section_edits

    EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i
    FORBIDDEN_USERNAMES = ["littleboop", "humptydumpty", "marymary"]
 
    # long form validations
    # validates_presence_of :first_name
    # validates_length_of :first_name, :maximum => 25

    # validates_presence_of :last_name
    # validates_length_of :last_name, :maximum => 50

    # validates_presence_of :username
    # validates_length_of :username, :within => 8..25
    # validates_uniqueness_of :username

    # validates_presence_of :email 
    # validates_length_of :email, :maximum => 100
    # validates_uniqueness_of :email
    # validates_format_of :email, :with => EMAIL_REGEX
    # validates_confirmation_of :email #another virtual field for confirmation 
    
    # sexy form validations 
    validates :first_name, :presence => true,
                           :length => { :maximum => 25} 
    validates :last_name, :presence => true,
                           :length => { :maximum => 50} 
    validates :username, :uniqueness => true,
                           :length => { :within => 8..25} 
    validates :email, :presence => true,
                           :length => { :maximum => 100},
                           :format => EMAIL_REGEX,
                           :confirmation => true  
               
    # custom validation _friday
    validate :username_is_allowed
    validate :no_new_users_on_thursday, :on => :create #validation not attached to any attribute

    private 
    def username_is_allowed
        if FORBIDDEN_USERNAMES.include?(username)
            errors.add(:username, "has been restricted from use.")
        end
    end

    def no_new_users_on_thursday
        if Time.now.wday == 4 #4 for thursday
            errors.add(:base, "NO new users on thursdays")
        end
    end

    
end
