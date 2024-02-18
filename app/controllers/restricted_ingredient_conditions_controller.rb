class RestrictedIngredientConditionsController < ApplicationController
  before_action :set_retricted_ingredient, only: %i[show edit update destroy]

  def index
    @restricted_ingredients = RestrictedIngredientCondition.all.page(params[:page] || 1)
  end

  def show
  end

  def new
    @restricted_ingredient = RestrictedIngredientCondition.new
  end

  def edit
  end

  # POST /restricted_ingredients or /restricted_ingredients.json
  def create
    @restricted_ingredient = RestrictedIngredientCondition.new(retricted_ingredient_condition_params)

    respond_to do |format|
      if @restricted_ingredient.save
        format.html { redirect_to @restricted_ingredient, notice: "Restricted was successfully created." }
        format.json { render :show, status: :created, location: @restricted_ingredient }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @restricted_ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /conditions/1 or /conditions/1.json
  def update
    respond_to do |format|
      if @restricted_ingredient.update(retricted_ingredient_condition_params)
        format.html { redirect_to @restricted_ingredient, notice: "Restricted was successfully updated." }
        format.json { render :show, status: :ok, location: @restricted_ingredient }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @restricted_ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conditions/1 or /conditions/1.json
  def destroy
    @restricted_ingredient.destroy
    respond_to do |format|
      format.html { redirect_to restricted_ingredient_conditions_path, notice: "Restricted Condition was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_retricted_ingredient
    @restricted_ingredient = RestrictedIngredientCondition.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def retricted_ingredient_condition_params
    params.require(:restricted_ingredient_condition).permit(:condition_id, :meal_id)
  end
end
