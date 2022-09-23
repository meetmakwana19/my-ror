class Section < ApplicationRecord
    # belongs_to :page, {:optional => true}
    belongs_to :page, optional: true
    # belongs_to :page, required: false
    has_many :section_edits
end
