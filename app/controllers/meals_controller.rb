class MealsController < ApplicationController
  def update
    @meal = Meal.find(params[:id])
    @meal.update(rating: review_param[:rating].to_i)
    redirect_to dashboard_path
  end

  private

  def review_param
    params.permit(:rating)
  end
end
