# frozen_string_literal: true

# Api::EntriesController
class Api::EntriesController < Api::ApiController
  def create
    entry = current_user.entries.build(entry_params)

    if params[:image].present? && params[:image] != 'undefined'
      entry.image.attach(params[:image])
    end

    if entry.save
      return render json: { message: 'Entrada creada exitosamente', status: :ok }, status: :created
    else
      render json: { error: entry.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def entry_params
    params.permit(:entry_type, :description)
  end
end
