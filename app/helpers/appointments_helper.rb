module AppointmentsHelper
  def select_dietitian_availability(selected = nil)
    time_step = current_user&.appointment_setting&.time_step || 5
    h_start = current_user&.availability&.time_start || '06:00'
    h_end = current_user&.availability&.time_end || '23:59'

    selection = if selected
                  selected&.strftime("%H:%M")
                else
                  nil
                end
    start_time = Time.parse("2000-01-01 #{h_start}:00")
    end_time = Time.parse("2000-01-01 #{h_end}:00")
    time_array = []

    while start_time <= end_time
      time_array << [start_time.strftime("%I:%M %p"), start_time.strftime("%H:%M")]
      start_time += time_step.minutes
    end

    options_for_select(time_array, selection)
  end
end
