class SectionEdit < ApplicationRecord
    belongs_to :admin_user
    belongs_to :section, {:optional => true} 
end
