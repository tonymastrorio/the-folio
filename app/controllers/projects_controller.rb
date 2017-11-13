class ProjectsController < ApplicationController
    skip_before_action :authenticate_user!, only: [:index, :show]

    def index
        @skills = Skill.all
        if !params[:skill].blank?
            @projects = Project.by_skill(params[:skill])
        else
            @projects = Project.all
        end
    end

    def new
        find_portfolio
        @project = Project.new
        @project.skills.build
    end

    def create
        @project = Project.new(project_params)
        @portfolio = Portfolio.find_by(id: params[:project][:portfolio_id])
        if @project.save
            redirect_to portfolio_project_path(@portfolio, @project)
        else
            render :new
        end
    end

    def show
        find_project
        find_portfolio
    end

    def edit
        require_permission_projects_controller
        find_project
        find_portfolio
    end

    def update
        require_permission_projects_controller
        find_portfolio
        find_project
        @project.update(project_params)

        redirect_to portfolio_project_path(@portfolio, @project)
    end

    def destroy
        require_permission_projects_controller
        find_portfolio
        find_project
        @project.destroy
        redirect_to user_portfolio_path(current_user, @portfolio)
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

    def find_portfolio
        @portfolio = Portfolio.find_by(id: params[:portfolio_id])
    end

    def find_project
        @project = Project.find_by(id: params[:id])
    end
end
