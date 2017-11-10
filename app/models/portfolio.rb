class Portfolio < ApplicationRecord
    belongs_to :user
    belongs_to :category
    has_many :projects

    validates_presence_of :name
end
