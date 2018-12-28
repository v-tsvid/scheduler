require "rails_helper"

RSpec.describe HomeController, type: :controller do
  describe "GET schedule" do
    it 'converts params[:items_count] to integer' do
      get :schedule, params: { items_count: '3' }
      expect(controller.params[:items_count]).to eq 3
    end

    it 'assigns empty @schedule if params are empty' do
      schedule = Schedule.new
      get :schedule
      expect(assigns(:schedule).datetime_start).to eq schedule.datetime_start
      expect(assigns(:schedule).frequency).to eq schedule.frequency
      expect(assigns(:schedule).items_count).to eq schedule.items_count
    end

    it 'renders :schedule' do
      get :schedule
      expect(response).to render_template('schedule')
    end
  end

  describe "POST schedule" do
    it 'converts params[:items_count] to integer' do
      post :schedule, params: { items_count: '3' }
      expect(controller.params[:items_count]).to eq 3
    end

    it 'assigns empty @schedule if params are empty' do
      schedule = Schedule.new
      post :schedule
      expect(assigns(:schedule).datetime_start).to eq schedule.datetime_start
      expect(assigns(:schedule).frequency).to eq schedule.frequency
      expect(assigns(:schedule).items_count).to eq schedule.items_count
    end

    it 'assigns @schedule with params and generates schedule on it' do
      datetime = DateTime.now.to_s
      schedule = Schedule.new(datetime_start: datetime,
                              frequency: :weekly,
                              items_count: 3)
      schedule.generate_schedule
      post :schedule, params: { datetime_start: datetime,
                                frequency: :weekly,
                                items_count: 3 }
      expect(assigns(:schedule).datetime_start).to eq schedule.datetime_start
      expect(assigns(:schedule).frequency).to eq schedule.frequency
      expect(assigns(:schedule).items_count).to eq schedule.items_count
    end

    it 'renders :schedule' do
      post :schedule
      expect(response).to render_template('schedule')
    end
  end
end
