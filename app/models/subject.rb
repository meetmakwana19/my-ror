class Subject < ApplicationRecord

    # making a scope with name "visible"
    scope :visible, lambda {where(:visible => true)}
    scope :invisible, lambda {where(:visible => false)}
    scope :sorted, lambda { order("position ASC") }
    scope :newest_first, lambda { order("created_at DESC") }

    # scope with an arguement "query", using array syntax 
    # 2nd value in array condition will have % sign to indicate SQL syntax and then the query will be safely placed in the place of ? as it is a dynamic data
    scope :search, lambda { |query| where("name LIKE ?", "%#{query}%")}

    # making one-to-one associations
    # has_one :page #dont forget to add belongs_to in page.rb
    has_many :pages #dont forget to add belongs_to in page.rb
end
