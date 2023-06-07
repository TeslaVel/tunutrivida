class Api::EntriesController < Api::ApiController

   def create
      entry = current_user.entries.build(entry_params)
      entry.image.attach(params[:image]) if params[:image]

      if entry.save
        render json: { message: 'Entrada creada exitosamente', status: :ok }, status: :created
      else
        render json: { error: entry.errors.full_messages }, status: :unprocessable_entity
      end
    end

  private

   def entry_params
     params.permit(:entry_type, :description, :image)
   end
end
