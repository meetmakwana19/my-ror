class Section < ApplicationRecord
    # belongs_to :page, {:optional => true}
    belongs_to :page, optional: true
    # belongs_to :page, required: false

    has_many :section_edits
    has_many :admin_users, :through => :section_edits #section has many admin users if we go through the JOIN table section_edits

    # making a scope with name "visible"
    scope :visible, lambda {where(:visible => true)}
    scope :invisible, lambda {where(:visible => false)}
    scope :sorted, lambda { order("position ASC") }
    scope :newest_first, lambda { order("created_at DESC") }

end
