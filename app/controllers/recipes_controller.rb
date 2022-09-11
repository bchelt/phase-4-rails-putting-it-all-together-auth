class RecipesController < ApplicationController
    def index
        if session[:user_id]
            recipes = Recipe.all
            render json: recipes, status: :created
        else
            render json: { errors: ["Not logged in"] }, status: :unauthorized
        end
    end

    def create
        
        if session[:user_id]
            recipe = Recipe.create(title: params[:title], minutes_to_complete: params[:minutes_to_complete], instructions: params[:instructions], user_id: session[:user_id])
            if recipe.valid?
                render json: recipe, status: :created
            else
                render json: { errors: recipe.errors.full_messages }, status: :unprocessable_entity
            end
        else
            render json: { errors: ["Not logged in"] }, status: :unauthorized
        end

    end

    private

    def recipe_params
        params.permit(:title, :minutes_to_complete, :instructions)
    end
end
