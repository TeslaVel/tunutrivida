module ApplicationHelper
  include ActiveLinkToHelper
  include TemplateNavHelper

  def device
    agent = request.user_agent
    return 'tablet' if agent =~ /(tablet|ipad)|(android(?!.*mobile))/i
    return 'mobile' if agent =~ /Mobile/
    return 'desktop'
  end

  def create_options_from_collection(collection = nil, disabled = false)
    return [] unless collection[:data].present?

    selected = collection[:selected].present? ? collection[:selected] : nil
    selection = nil

    data = Array.wrap(collection[:data])

    if collection[:data].is_a?(Array)
      options = data.map { |k| [k.to_s.humanize, k] }
      found = data.find { |k| k == selected } if selected
      selection = [found.to_s.humanize, found] if found
    else
      value_method = collection[:value_method].present? ? collection[:value_method] : :id
      label_method = collection[:label_method].present? ? collection[:label_method] : :name

      options = data.map { |k| [k[label_method].to_s.humanize, k[value_method]] }
      found = data.find { |d| d[value_method] == selected } if selected
      selection = [found[label_method], found[value_method]] if found
    end

    option = collection[:top_option]
    top_option = option.present? ? [option[:label], option[:value]] : ['Select', nil]

    options.prepend(top_option)

    if disabled
      return selection
    end

    options_for_select(options, selection || top_option)
  end

  def create_options_for_range_times(options)
    return [] unless options.present?

    selected = options[:selected] || nil
    time_step = options[:time_step] || 5
    time_start = (options[:time_start] || '06:00 AM').to_time.strftime('%I:%M %p')
    time_end = (options[:time_end] || '23:59 PM').to_time.strftime('%I:%M %p')

    selection = if selected.present?
                  [selected.to_time.strftime('%I:%M %p'), selected.to_time.strftime('%H:%M')]
                else
                  ['08:30 AM', '08:30']
                end

    start_time = Time.parse("2000-01-01 #{time_start}:00")
    end_time = Time.parse("2000-01-01 #{time_end}:00")
    time_array = []

    while start_time <= end_time
      time_array << [start_time.strftime("%I:%M %p"), start_time.strftime("%H:%M")]
      start_time += time_step.minutes
    end

    options_for_select(time_array, selection)
  end
end
