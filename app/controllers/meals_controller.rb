class MealsController < ApplicationController
  before_action :set_meal, only: %i[show edit update destroy]
  before_action :set_meals, only: %i[index filter]

  # GET /meals or /meals.json
  def index
  end

  def filter
    type_of_use_id = filter_params[:type_of_use_id]
    meal_type_id = filter_params[:meal_type_id]

    if type_of_use_id.present? && type_of_use_id != 'all'
      @meals = @meals.where(type_of_use: type_of_use_id.to_i)
    end

    if meal_type_id.present? && meal_type_id != 'all'
      @meals = @meals.where(meal_type: meal_type_id.to_i)
    end

    @meals = @meals.page(params[:page] || 1)

    respond_to do |format|
      format.js { render :index, layout: false }
    end
  end

  # GET /meals/1 or /meals/1.json
  def show
  end

  # GET /meals/new
  def new
    @meal = Meal.new
  end

  # GET /meals/1/edit
  def edit
  end

  # POST /meals or /meals.json
  def create
    @meal = Meal.new(meal_params)

    respond_to do |format|
      if @meal.save
        format.html { redirect_to meal_url(@meal), notice: "Meal was successfully created." }
        format.json { render :show, status: :created, location: @meal }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meals/1 or /meals/1.json
  def update
    respond_to do |format|
      if @meal.update(meal_params)
        format.html { redirect_to meal_url(@meal), notice: "Meal was successfully updated." }
        format.json { render :show, status: :ok, location: @meal }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meals/1 or /meals/1.json
  def destroy
    @meal.destroy!

    respond_to do |format|
      format.html { redirect_to meals_url, notice: "Meal was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_meal
    @meal = Meal.find(params[:id])
  end

  def set_meals
    @meals = Meal.all.page(params[:page] || 1)
  end

  # Only allow a list of trusted parameters through.
  def meal_params
    params.require(:meal).permit(:name, :meal_type, :type_of_use)
  end

  def filter_params
    params.permit(:page, :meal_type_id, :type_of_use_id)
  end
end
