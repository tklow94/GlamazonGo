class GroceriesController < ApplicationController
    def index
        @groceries = Grocery.all
        render json: @groceries
    end
end

