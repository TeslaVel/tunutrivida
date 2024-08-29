# frozen_string_literal: true

# ContactUsNotification model
class ContactUsNotification < Notification
  after_create :send_alert_notification

  private

  def send_alert_notification
    # DietitianEvents.broadcast_to(ch_name, message: 'Hello, world!')
    ch_name = "global_events_tunutrivida"
    count = ContactUs.where(seen: false).count
    ActionCable.server.broadcast(ch_name, { type: 'contactus', emails_count: count, id: id})
    puts "################# creando contactus notification en #{ch_name}"
  end
end