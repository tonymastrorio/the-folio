class Portfolio < ApplicationRecord
    belongs_to :user
    belongs_to :category
    has_many :projects
end
