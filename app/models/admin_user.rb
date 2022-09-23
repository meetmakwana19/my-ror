class AdminUser < ApplicationRecord
    # m:n associations
    has_and_belongs_to_many :pages
end
