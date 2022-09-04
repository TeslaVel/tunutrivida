class IndicatorsController < ApplicationController
  before_action :set_indicator, only: %i[ show edit update destroy ]

  # GET /indicators or /indicators.json
  def index
    @indicators = Indicator.all.order_by_id.page(params[:page] || 1)
  end

  # GET /indicators/1 or /indicators/1.json
  def show
    @genders = Gender.all
  end

  # GET /indicators/new
  def new
    @indicator = Indicator.new
    @genders = Gender.all
    @indicator_types = IndicatorType.all
  end

  # GET /indicators/1/edit
  def edit
    @genders = Gender.all
    @indicator_types = IndicatorType.all
  end

  # POST /indicators or /indicators.json
  def create
    @indicator = Indicator.new(indicator_params)

    respond_to do |format|
      if @indicator.save
        format.html { redirect_to indicators_path, notice: "Indicator was successfully created." }
        format.json { render :json, status: :created, location: @indicator }
      else

        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @indicator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /indicators/1 or /indicators/1.json
  def update
    respond_to do |format|
      if @indicator.update(indicator_params)
        format.html { redirect_to indicators_path, notice: "Indicator was successfully updated." }
        format.json { render :show, status: :ok, location: @indicator }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @indicator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /indicators/1 or /indicators/1.json
  def destroy
    @indicator.destroy
    respond_to do |format|
      format.html { redirect_to indicators_url, notice: "Indicator was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_indicator
      @indicator = Indicator.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def indicator_params
      params.require(:indicator).permit(:value_min, :value_max, :description, :position, :gender_id, :indicator_type_id)
    end
end
