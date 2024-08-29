class ConditionsController < ApplicationController
  before_action :set_condition, only: %i[show edit update destroy]
  before_action :set_conditions, only: %i[index filter]

  # GET /conditions or /conditions.json
  def index
  end

  def filter
    name_filter = filter_params[:name_filter]

    if name_filter.present?
      @conditions = @conditions.where("name ILIKE ?", "%#{name_filter}%")
    end

    @conditions = @conditions.page(params[:page] || 1)

    respond_to do |format|
      format.js { render :index, layout: false }
    end
  end

  # GET /conditions/1 or /conditions/1.json
  def show
  end

  # GET /conditions/new
  def new
    @condition = Condition.new
  end

  # GET /conditions/1/edit
  def edit
  end

  # POST /conditions or /conditions.json
  def create
    @condition = Condition.new(condition_params)

    respond_to do |format|
      if @condition.save
        format.html { redirect_to @condition, notice: "Condition was successfully created." }
        format.json { render :show, status: :created, location: @condition }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @condition.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /conditions/1 or /conditions/1.json
  def update
    respond_to do |format|
      if @condition.update(condition_params)
        format.html { redirect_to @condition, notice: "Condition was successfully updated." }
        format.json { render :show, status: :ok, location: @condition }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @condition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conditions/1 or /conditions/1.json
  def destroy
    @condition.destroy
    respond_to do |format|
      format.html { redirect_to conditions_url, notice: "Condition was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_condition
      @condition = Condition.find(params[:id])
    end

    def set_conditions
      @conditions = Condition.all.page(params[:page] || 1)
    end

    def condition_params
      params.require(:condition).permit(:name, :description)
    end

    def filter_params
      params.permit(:page, :name_filter)
    end
end
