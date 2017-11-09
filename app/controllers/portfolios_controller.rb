class PortfoliosController < ApplicationController
    def new
        @portfolio = Portfolio.new
    end

    def create
        @portfolio = Portfolio.new(portfolio_params)
        @portfolio.user = current_user
        if @portfolio.save
            redirect_to new_project_path
        else
            render :new
        end
    end

    def show
        @portfolio = Portfolio.find(params[:id])
        @projects = Portfolio.find(params[:id]).projects
    end

    def index
        if params[:user_id]
            @portfolios = User.find(params[:user_id]).portfolios
        else
            @portfolios = Portfolio.all
        end
    end

    def edit
        require_permission
        @portfolio = Portfolio.find(params[:id])
    end

    def update
        require_permission
        @portfolio = Portfolio.update(portfolio_params)
        redirect_to user_portfolios_path(@portfolio)
    end

    private

    def portfolio_params
        params.require(:portfolio).permit(:name, :category_id)
    end
end
