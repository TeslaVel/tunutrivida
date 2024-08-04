# frozen_string_literal: true

# BmrFactorsController
class BmrFactorsController < ApplicationController
  before_action :check_auth_for_all_origin
  before_action :set_bmr_factor, only: %i[ show edit update destroy ]

  # GET /indicators or /indicators.json
  def index
    @bmr_factors = BmrFactor.order(:id, :source).page(params[:page] || 1)
  end

  # GET /indicators/1 or /indicators/1.json
  def show
    @genders = Gender.all
  end

  # GET /indicators/new
  def new
    @bmr_factor = BmrFactor.new
    @genders = Gender.all
  end

  # GET /indicators/1/edit
  def edit
    @genders = Gender.all
  end

  # POST /indicators or /indicators.json
  def create
    @bmr_factor = BmrFactor.new(bmr_params.merge(created_by_id: current_user.id))

    respond_to do |format|
      if @bmr_factor.save
        format.html { redirect_to bmr_factors_path, notice: "Bmr Factor was successfully created." }
        format.json { render :json, status: :created, location: @bmr_factor }
      else

        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @bmr_factor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /indicators/1 or /indicators/1.json
  def update
    respond_to do |format|
      if @bmr_factor.update(bmr_params)
        format.html { redirect_to bmr_factors_path, notice: "Bmr Factor was successfully updated." }
        format.json { render :show, status: :ok, location: @bmr_factor }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bmr_factor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /indicators/1 or /indicators/1.json
  def destroy
    @bmr_factor.destroy
    respond_to do |format|
      format.html { redirect_to bmr_factors_path, notice: "Bmr Factor was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bmr_factor
      @bmr_factor = BmrFactor.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bmr_params
      params.require(:bmr_factor)
            .permit(
              :base_value,
              :base_height,
              :base_weight,
              :base_age,
              :name,
              :position,
              :source,
              :gender_id
            )
    end
end
