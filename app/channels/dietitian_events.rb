
class DietitianEvents < ApplicationCable::Channel
  def subscribed
    if params[:dietitian_id].present?
      ch_name = "dietitian_events_#{params[:dietitian_id]}"
    elsif current_user.present?
      ch_name = "dietitian_events_#{current_user.id}"
    end

    if ch_name.present?
      stream_from ch_name
      puts "############ BCKEND Dietitian Event Listenin #{ch_name} Params #{params}"
    end

  end

  def receive(data)
    puts "############ BCKEND Dietitian Event DATA RECIBIDA ## #{data}"
    conversation = Conversation.find(data.conversation_id)
    html = render_to_string(partial: 'conversations/note', locals: { conversation: conversation })
    puts "html #{html}"
  end

  def unsubscribed
  end
end
