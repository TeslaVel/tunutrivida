# frozen_string_literal: true

# Api::ProfileController
class Api::ProfilesController < Api::ApiController
  def update
    if current_user.update(profile_params)
      if params[:image].present? && params[:image] != 'undefined'
        current_user.image.attach(params[:image])
      end

      return render json: {
        message: 'Perfil actualizado exitosamente',
        user: {
          id: current_user.id,
          firstName: current_user.first_name,
          lastName: current_user.last_name,
          email: current_user.email,
          dietitianId: current_user.dietitian_id,
          imageUrl: current_user.image_url,
          height: current_user.sessions&.first&.height,
          weight: current_user.sessions&.first&.weight,
          imc: current_user.sessions&.first&.imc,
          age: current_user.age,
          gender: current_user&.gender&.name&.downcase
        },
        status: :ok
      }, status: :created
    else
      render json: { error: current_user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.permit(:first_name,
                  :last_name,
                  :date_of_birth,
                  :gender_id)
  end
end
