class ContactUs < ApplicationRecord
  after_create :create_notification
  belongs_to :read_by, class_name: 'User', foreign_key: 'read_by', optional: true

  def full_name
		"#{first_name} #{last_name}"
	end

  def get_initials
    stripped_first_name = first_name.strip
    stripped_last_name = last_name.strip

    "#{stripped_first_name[0].capitalize}.#{stripped_last_name[0].capitalize}"
  end

  def first_name_initial
    stripped_first_name = first_name.strip
    stripped_last_name = last_name.strip

    "#{stripped_first_name[0].capitalize}. #{stripped_last_name}"
  end

  private

  def create_notification
    ContactUsNotification.create!(
      notification_type: :contactus,
      content: "#{first_name_initial} has sent you an email",
      associated_object_type: 'ContactUs',
      associated_object_id: id
    )
  end
end
