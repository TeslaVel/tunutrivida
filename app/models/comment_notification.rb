# frozen_string_literal: true

# CommentNotification model
class CommentNotification < Notification
  after_create :send_alert_notification

  private

  def send_alert_notification
    # DietitianEvents.broadcast_to(ch_name, message: 'Hello, world!')
    puts "################# creando comment notification en #{ch_name}"
    ch_name = "dietitian_events_#{recipient.id}"
    count = Notification.where(recipient_id: recipient.id, seen: false).count
    ActionCable.server.broadcast(ch_name, { type: 'comment', notification_count: count, id: id})
  end
end
