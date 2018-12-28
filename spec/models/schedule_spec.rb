require "rails_helper"

RSpec.describe Schedule, type: :model do
  it { is_expected.to validate_inclusion_of(:frequency).in_array(Schedule::PRESETS.keys) }
  it { is_expected.to validate_numericality_of(:items_count).is_greater_than(0).only_integer }

  it 'validates that datetime_start is valid DateTime' do
    s = Schedule.new(datetime_start: 'not DateTime')
    s.valid?
    expect(s.errors.messages[:datetime_start]).to eq ['must be a valid date and time']
  end
end
