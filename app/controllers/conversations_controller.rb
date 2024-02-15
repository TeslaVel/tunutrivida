# frozen_string_literal: true

# ConversationsController
class ConversationsController < ApplicationController
  before_action :set_conversation, only: %i[show edit update destroy]
  before_action :set_conversations, only: %i[index create update destroy]

  # GET /conversations or /conversations.json
  def index
    @conversation ||= Conversation.find_by(id: params[:convo_id])

    mark_notification_seen if @conversation && params[:convo_id].present?
  end

  # GET /conversations/1 or /conversations/1.json
  def show
  end

  # GET /conversations/new
  def new
    @conversation = Conversation.new
  end

  # GET /conversations/1/edit
  def edit
  end

  # POST /conversations or /conversations.json
  def create
    @conversation = Conversation.new(conversation_params)

    respond_to do |format|
      if @conversation.save
        format.html { redirect_to conversation_url(@conversation), notice: "Conversation was successfully created." }
        format.js { render 'conversations/index', layout: false }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /conversations/1 or /conversations/1.json
  def update
    respond_to do |format|
      if @conversation.update(conversation_params)
        format.html { redirect_to conversation_url(@conversation), notice: "Conversation was successfully updated." }
        format.json { render :show, status: :ok, location: @conversation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conversations/1 or /conversations/1.json
  def destroy
    @conversation.destroy

    respond_to do |format|
      format.html { redirect_to conversations_url, notice: "Conversation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def render_chat_partial
    @conversation = Conversation.find(params[:id])
    @notes = @conversation.notes.includes(:patient) # Carga las asociaciones notes y patient

    # Renderizar el parcial y obtener el contenido como una cadena
    chat_partial_html = render_to_string(partial: 'conversations/chat', locals: { conversation: @conversation, notes: @notes })

    render plain: chat_partial_html
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conversation
      @conversation = Conversation.find(params[:id])
    end

    def set_conversations
      @conversations = current_user.dietitian_conversations
    end

    # Only allow a list of trusted parameters through.
    def conversation_params
      # params.fetch(:conversation, {})
      params.require(:conversation).permit(:patient_id).merge(dietitian_id: current_user.id)
    end

    def mark_notification_seen
      # @conversation.update(seen: true) if !@conversation.seen

      note_ids = @conversation.notes.where(seen: false).select(:id)
      recipient_id = @conversation.dietitian_id

      Notification.where(
        recipient_id: recipient_id,
        associated_object_id: note_ids,
        notification_type: :note
      ).update_all(seen: true)
    end
end
