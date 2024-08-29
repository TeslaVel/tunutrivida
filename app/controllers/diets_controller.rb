# frozen_string_literal: true

# DietsController
class DietsController < ApplicationController
  before_action :check_auth_for_all_origin
  before_action :set_diet, only: %i[show edit update destroy]
  before_action :set_patient, only: %i[create]

  def index
    @diets = Diet.all.page(params[:page] || 1)
  end

   # GET /diets_controller/new
  def new
    @diet = Diet.new
    7.times do |idx|
      dmw = @diet.diet_meal_weeks.build(day_of_week: idx)
      3.times do |tmx|
        dmt = dmw.diet_meal_times.build(meal_time: tmx)
        # dmt.diet_ingredient.build
      end
    end

    @patients = current_user.patients
  end

  # GET /diets_controller/1 or /diets_controller/1.json
  def show
    # @diet_body = @diet.diet_meal_weeks.includes(:diet_meal_times).group_by(&:day_of_week)

    # @diet_body.transform_values! do |dmws|
    #   dmws.each_with_object({}) do |dmw, hash|
    #     dmw.diet_meal_times.each do |dmt|
    #       hash[dmt.meal_time] = {
    #         meal_time: dmt.meal_time,
    #         meal_name: dmt.diet_ingredient.meal.name,
    #         instructions: dmt.diet_ingredient.instructions
    #       }
    #     end
    #   end
    # end
  end

  # GET /diets_controller/1/edit
  def edit
    @patients = current_user.patients
  end

  # POST /diets_controller or /diets_controller.json
  def create
    @diet = Diet.new(name: "Dieta para #{@patient.first_name}", description: 'Descripcion de la dieta')
    @diet.dietitian_id = current_user.id
    @diet.patient_id = @patient.id
    @patients = current_user.patients

    generate_random_meals

    respond_to do |format|
      if @diet.save
        format.html { redirect_to @diet, notice: 'La dieta se creó exitosamente.' }
        format.json { render :show, status: :created, location: @diet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @diet.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_diet_session
    @session = Session.find(params[:session_id])
    return unless @session
    @patient = @session.patient

    @diet = Diet.new(name: "Dieta para #{@session.patient.first_name}", description: 'Descripcion de la dieta')
    @diet.dietitian_id = current_user.id
    @diet.patient_id = @patient.id
    @diet.session_id = @session.id
    @patients = current_user.patients

    generate_random_meals

    respond_to do |format|
      if @diet.save
        format.html { redirect_to @diet, notice: 'La dieta se creó exitosamente.' }
      else
        binding.pry
        format.html { redirect_to patient_patient_package_session_show_path(@patient.id, @session.patient_package.id, @session.id), alert: @diet.errors.full_messages.join(". ") }
      end
    end
  end

  # PATCH/PUT /diets_controller/1 or /diets_controller/1.json
  def update
    # raise diet_params.to_yaml
    respond_to do |format|
      if @diet.update(diet_params)
        format.html { redirect_to @diet, notice: 'Diet was successfully updated.' }
        format.json { render :show, status: :ok, location: @diet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @diet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /diets_controller/1 or /diets_controller/1.json
  def destroy
    @diet.destroy
    respond_to do |format|
      format.html { redirect_to diets_path, notice: 'Diet factor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_diet
    @diet = Diet.find(params[:id])
  end

  def set_patient
    @patient = User.find(diet_params[:patient_id])
  end

  # Only allow a list of trusted parameters through.
  def diet_params
    params.require(:diet).permit(
      :description,
      :patient_id,
      :dietitian_id,
      diet_meal_weeks_attributes: [
        :id,
        diet_meal_times_attributes: [
          :id,
          :meal_time,
          diet_ingredient_attributes: [
            :id,
            :meal_id,
            :instructions
          ]
        ]
      ]
    )
  end

  def generate_random_meals
    r_ids = restricted_meal_ids

    7.times do |idx|
      dmw = @diet.diet_meal_weeks.build(day_of_week: idx)
      3.times do |tmx|
        meal_id = Meal.where(type_of_use: Meal::TYPE_OF_USES[tmx])
                      .where.not(id: r_ids)
                      .select(:id).sample.id
        puts "idx: #{idx} - tmx:#{tmx}: #{Meal::TYPE_OF_USES[tmx]} - meal_id: #{meal_id}"
        dmt = dmw.diet_meal_times.build(meal_time: tmx)
        dmt.diet_ingredient = DietIngredient.new(meal_id: meal_id, instructions: 'Agregar')
      end
    end
  end

  def restricted_meal_ids
    patient_conditions = PatientCondition.where(patient_id: @patient.id)
    restricted_meals = RestrictedIngredientCondition.where(condition_id: patient_conditions.select(:condition_id))
    restricted_meals.select(:meal_id)
  end
end
