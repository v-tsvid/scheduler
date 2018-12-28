class HomeController < ApplicationController

  def schedule
    @schedule = Schedule.new(schedule_params)
    @schedule.generate_schedule unless schedule_params.blank?
  end

  private

  def schedule_params
    params.permit(:datetime_start, :frequency, :items_count)
  end
end