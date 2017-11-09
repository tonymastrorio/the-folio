class ProjectsController < ApplicationController
    def index
    end

    def new
        @portfolio = Portfolio.find_by(id: params[:portfolio_id])
        @project = Project.new
        @project.skills.build
    end

    def create
        @project = Project.new(project_params)
        if @project.save
            redirect_to project_path(@project)
        else
            render :new
        end
    end

    def show
        @project = Project.find_by(id: params[:id])
        @portfolio = Portfolio.find_by(id: params[:portfolio_id])
    end

    def edit
        require_permission_projects_controller
        @project = Project.find_by(id: params[:id])
        @portfolio = Portfolio.find_by(id: params[:portfolio_id])
    end

    def update
        require_permission_projects_controller
        @portfolio = Portfolio.find_by(id: params[:portfolio_id])
        @project = Project.update(project_params)

        redirect_to portfolio_project_path(@project)
    end

    private

    def project_params
        params.require(:project).permit(:portfolio_id, :image, :title, :description, :github_url, :skill_ids => [], :skills_attributes => {})
    end

    def require_permission_projects_controller
        if current_user != Portfolio.find(params[:portfolio_id]).user
            redirect_to root_path
        end
    end
end
