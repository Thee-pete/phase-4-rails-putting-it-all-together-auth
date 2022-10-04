class RecipesController < ApplicationController
    before_action :authorize
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def index
        recipes = Recipe.all
        render json: recipes, status: :created
    end

    def create
        recipe = Recipe.create(recipe_params)
        if recipe.valid?
          render json: recipe, status: :created
        else
           render json: {errors: recipe.errors.full_messages}, status: :unprocessable_entity
        end

    end

    private
  
    def record_not_found
        render json: { error: "Recipe not found" }, status: :not_found
    end
    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete)
    end

end
