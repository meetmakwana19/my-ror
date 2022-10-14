class Page < ApplicationRecord
        
    acts_as_list :scope => :subject #will take in account the subjects that no page nos for a subject

    # completing one-to-many associations
    # optional is false by default 
    belongs_to :subject, {:optional => true} 

    has_many :sections
    has_and_belongs_to_many :admin_users

    # making a scope with name "visible"
    scope :visible, lambda {where(:visible => true)}
    scope :invisible, lambda {where(:visible => false)}
    scope :sorted, lambda { order("position ASC") }
    scope :newest_first, lambda { order("created_at DESC") }

    validates_presence_of :name
    validates_length_of :name, :maximum => 255

    # using presence_of with length_of to ensure there's no space in permalink. It's disallowing permalink.
    validates_presence_of :permalink
    validates_length_of :permalink, :within => 3..255 #within range

    # unique permalink for every page.
    validates_uniqueness_of :permalink 


end
