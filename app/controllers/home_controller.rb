class HomeController < ApplicationController

  def schedule
    ensure_items_count_is_integer
    @schedule = Schedule.new(schedule_params)
    @schedule.generate_schedule unless schedule_params.blank?
  end

  private

  def ensure_items_count_is_integer
    return if params[:items_count].blank?
    params[:items_count] = params[:items_count].to_i
  end

  def schedule_params
    params.permit(:datetime_start, :frequency, :items_count)
  end
end