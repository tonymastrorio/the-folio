class PortfoliosController < ApplicationController
    def new
        @portfolio = Portfolio.new
    end

    def create
        @portfolio = Portfolio.new(portfolio_params)
        @portfolio.user = current_user
        if @portfolio.save
            redirect_to new_portfolio_project_path(@portfolio)
        else
            render :new
        end
    end

    def show
        find_portfolio
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
        find_portfolio
    end

    def update
        require_permission
        find_portfolio
        @portfolio.update(portfolio_params)

        redirect_to user_portfolio_path(current_user, @portfolio)
    end

    def destroy
        require_permission
        find_portfolio
        @portfolio.destroy
        redirect_to user_portfolios_path(current_user)
    end

    private

    def portfolio_params
        params.require(:portfolio).permit(:name, :category_id)
    end

    def find_portfolio
        @portfolio = Portfolio.find_by(id: params[:id])
    end
end
