# frozen_string_literal: true

class CommentNotification < Notification
  after_create :send_alert_notification

  private

  def send_alert_notification
     # DietitianEvents.broadcast_to(ch_name, message: 'Hello, world!')
     if self.contactus?
      ch_name = "global_events_tunutrivida"
      count = ContactUs.where(seen: false).count
      ActionCable.server.broadcast(ch_name, { type: 'contactus', emails_count: count })
     elsif self.comment?
      ch_name = "dietitian_events_#{recipient.id}"
      count = Notification.where(recipient_id: recipient.id, seen: false).count
      ActionCable.server.broadcast(ch_name, { type: 'comment', notification_count: count })
     end
     puts "################# creando alerta en #{ch_name}"
  end
end