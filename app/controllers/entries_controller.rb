# frozen_string_literal: true

# EntriesController
class EntriesController < ApplicationController
  before_action :check_auth_for_all_origin
  before_action :set_entry, only: %i[show edit update destroy mark_notification_seen]
  before_action :mark_notification_seen, only: [:show]

  # GET /entries or /entries.json
  def index
    selectd_id = if current_user.is_dietitian?
                    current_user.patients.select(:id)
                  else
                    [current_user.id]
                  end
    @entries = Entry.where(user_id: selectd_id).order(created_at: :desc)
  end

  # GET /entries/1 or /entries/1.json
  def show
    @comments = @entry.comments.order(created_at: :asc)
  end

  # GET /entries/new
  def new
    @entry = Entry.new
  end

  # GET /entries/1/edit
  def edit
  end

  # POST /entries or /entries.json
  def create
    @entry = current_user.entries.build(entry_params)

    respond_to do |format|
      if @entry.save
        format.html { redirect_to @entry, notice: "Entry was successfully created." }
        format.json { render :show, status: :created, location: @entry }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entries/1 or /entries/1.json
  def update
    respond_to do |format|
      if @entry.update(entry_params)
        format.html { redirect_to @entry, notice: "Entry was successfully updated." }
        format.json { render :show, status: :ok, location: @entry }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1 or /entries/1.json
  def destroy
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to entries_url, notice: "Entry was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def entry_params
      params.require(:entry).permit(:description, :entry_type, :image)
    end

    def mark_notification_seen
      @entry.update(seen: true)
      comment_ids = @entry.comments.select(:id)

      recipient_id = if @entry.user.is_dietitian?
                        @entry.user.id
                      else
                        @entry.user.dietitian.id
                      end
      Notification.where(
        recipient_id: recipient_id,
        associated_object_id: comment_ids,
        notification_type: :comment
      ).update_all(seen: true)
    end
end
