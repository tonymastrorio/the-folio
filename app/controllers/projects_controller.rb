class ProjectsController < ApplicationController
    def index
    end

    def new
        @project = Project.new
    end

    def create
        @project = Project.new(project_params)
        if @project.save
            redirect_to project_path(@project)
        else
            binding.pry
            render :new
        end
    end

    def show
        @project = Project.find_by(id: params[:id])
    end

    private

    def project_params
        params.require(:project).permit(:portfolio_id, :image, :title, :description, :github_url, :skill_ids => [])
    end
end
