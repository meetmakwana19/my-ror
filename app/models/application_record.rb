class ApplicationRecord < ActiveRecord::Base
  # this class will have all code which is common to all the models.
  self.abstract_class = true
end
