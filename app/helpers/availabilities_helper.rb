module AvailabilitiesHelper
  def hours_and_minutes(step = 5, selected = nil)
    selection = selected&.strftime('%H:%M')
    start_time = Time.parse('2000-01-01 06:00:00')
    end_time = Time.parse('2000-01-01 23:59:00')
    time_array = []

    while start_time <= end_time
      time_array << [start_time.strftime('%I:%M %p'), start_time.strftime('%H:%M')]
      start_time += step.minutes
    end

    options_for_select(time_array, selection)
  end
end
