module ApplicationHelper
  def default_datetime_start(current_datetime_start)
    (current_datetime_start || DateTime.now).strftime('%Y-%m-%dT%H:%M')
  end

  def frequency_options(current_frequency)
    options_for_select(Schedule::PRESETS.keys.map { |k| [k.to_s.humanize, k]},
                       current_frequency || Schedule::PRESETS.keys.first)
  end

  def default_items_count(current_count)
    return '14' if current_count == 0 || current_count.blank?
    current_count
  end

end
