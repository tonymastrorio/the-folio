class Project < ApplicationRecord
    belongs_to :portfolio
    has_many :project_skills
    has_many :skills, through: :project_skills
    accepts_nested_attributes_for :skills

    has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/assets/images/:style/missing.png"
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
