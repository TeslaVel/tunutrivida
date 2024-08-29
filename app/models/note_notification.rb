# frozen_string_literal: true

# NoteNotification model
class NoteNotification < Notification
  after_create :send_alert_notification

  private

  def send_alert_notification
    # DietitianEvents.broadcast_to(ch_name, message: 'Hello, world!')
    ch_name = "dietitian_events_#{recipient.id}"
    count = Notification.where(recipient_id: recipient.id, seen: false).count
    event_emitter = sender.is_patient? ? 'patient' : 'dietitian'
    ActionCable.server.broadcast(
      ch_name, {
        type: 'note',
        event_emitter: event_emitter,
        notification_count: count,
        conversation_id: associated_object.conversation_id
      }
    )
    puts "################# creando alerta en #{ch_name}"
  end
end