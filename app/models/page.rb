class Page < ApplicationRecord
        
    # completing one-to-many associations
    # optional is false by default 
    belongs_to :subject, {:optional => true} 

    has_and_belongs_to_many :admin_users

    # making a scope with name "visible"
    scope :visible, lambda {where(:visible => true)}
    scope :invisible, lambda {where(:visible => false)}
    scope :sorted, lambda { order("position ASC") }
    scope :newest_first, lambda { order("created_at DESC") }

end
