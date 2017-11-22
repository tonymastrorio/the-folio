class Project < ApplicationRecord
    belongs_to :portfolio
    has_many :project_skills
    has_many :skills, through: :project_skills
    # accepts_nested_attributes_for :skills, allow_destroy: true, reject_if: :all_blank

    has_attached_file :image, styles: { large: "500x500>", medium: "300x300>", thumb: "100x100>" }, default_url: "/assets/:style/missing.png"
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
    validates_presence_of :title, :description

    def self.by_skill(skill_id)
        Project.joins(:skills).where(skills: {id: skill_id})
    end

    def skills_attributes=(skills_attributes)
        skills_attributes.values.each do |skill_attributes|
            #Do not create a category if it does not have a name
            if skill_attributes[:name].present?
                skill = Skill.find_or_create_by(name: skill_attributes[:name])
                if !self.skills.include?(skill)
                    self.project_skills.build(:skill => skill)
                end
            end
        end
    end
end
