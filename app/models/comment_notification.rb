# frozen_string_literal: true

class CommentNotification < Notification
  after_create :send_alert_notification

  private

  def send_alert_notification
     # DietitianEvents.broadcast_to(ch_name, message: 'Hello, world!')

     ch_name = "global_events_d_#{recipient.id}"
     notification_count = Notification.where(recipient_id: recipient.id, seen: false).count
     ActionCable.server.broadcast(ch_name, { title: 'Re', notification_count: notification_count })
  end
end