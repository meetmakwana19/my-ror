class Page < ApplicationRecord
        
    # completing one-to-many associations
    # optional is false by default 
    belongs_to :subject, {:optional => true} 
end
