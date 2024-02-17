class PatientConditionsController < ApplicationController
  before_action :set_patient, only: %i[create update destroy]
  before_action :set_patient_condition, only: %i[destroy]

  # POST /patient_conditions or /patient_conditions.json
  def create
    @patient_condition = PatientCondition.new(patient_condition_params.merge(patient_id: @patient.id, created_by_id: current_user.id))

    respond_to do |format|
      if @patient_condition.save
        format.html { redirect_to patient_path(@patient), notice: 'Patient condition was successfully created.' }
        format.js { render 'users/patient_conditions', layout: false }
      else
        format.html { redirect_to patient_path(@patient), notice: @patient_condition.errors.full_messages.join(". ") << "."}
        format.json { render json: @patient_condition.errors.full_messages.join(". ") << ".", status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /patient_conditions/1 or /patient_conditions/1.json
  def update
    respond_to do |format|
      if @patient_condition.update(package_params)
        format.html { redirect_to @patient, notice: 'Patient condition was successfully updated.' }
        format.json { render :show, status: :ok, location: @patient }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patient_conditions/1 or /patient_conditions/1.json
  def destroy
    @patient_condition.destroy
    respond_to do |format|
      format.html { redirect_to patient_path(@patient), notice: 'Patient condition was successfully destroyed.' }
      # format.json { head :no_content }
      format.js { render 'users/patient_conditions', layout: false }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_patient
    @patient = User.find(params[:patient_id])
  end

  def set_patient_condition
    @patient_condition = PatientCondition.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def patient_condition_params
    params.require(:patient_condition).permit(:condition_id)
  end
end
