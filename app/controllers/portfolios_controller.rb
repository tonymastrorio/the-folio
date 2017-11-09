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

    end

    def index
        if params[:user_id]
            @portfolios = User.find(params[:user_id]).portfolios
        else
            @portfolios = Portfolio.all
        end
    end


    private

    def portfolio_params
        params.require(:portfolio).permit(:name, :category_id)
    end
end
