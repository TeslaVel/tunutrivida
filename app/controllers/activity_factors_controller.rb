# frozen_string_literal: true

# ActivityFactorsController
class ActivityFactorsController < ApplicationController
  before_action :check_auth_for_all_origin
  before_action :set_activity_factor, only: %i[ show edit update destroy ]

  # GET /activity_factors or /activity_factors.json
  def index
    @activity_factors = ActivityFactor.all
  end

  # GET /activity_factors/1 or /activity_factors/1.json
  def show
  end

  # GET /activity_factors/new
  def new
    @activity_factor = ActivityFactor.new
  end

  # GET /activity_factors/1/edit
  def edit
  end

  # POST /activity_factors or /activity_factors.json
  def create
    @activity_factor = ActivityFactor.new(activity_factor_params)

    respond_to do |format|
      if @activity_factor.save
        format.html { redirect_to @activity_factor, notice: "Activity factor was successfully created." }
        format.json { render :show, status: :created, location: @activity_factor }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @activity_factor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /activity_factors/1 or /activity_factors/1.json
  def update
    respond_to do |format|
      if @activity_factor.update(activity_factor_params)
        format.html { redirect_to @activity_factor, notice: "Activity factor was successfully updated." }
        format.json { render :show, status: :ok, location: @activity_factor }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @activity_factor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activity_factors/1 or /activity_factors/1.json
  def destroy
    @activity_factor.destroy
    respond_to do |format|
      format.html { redirect_to activity_factors_url, notice: "Activity factor was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity_factor
      @activity_factor = ActivityFactor.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def activity_factor_params
      params.require(:activity_factor).permit(:name, :description, :value)
    end
end
