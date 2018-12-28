require "rails_helper"

RSpec.describe Schedule, type: :model do
  it { is_expected.to validate_inclusion_of(:frequency).in_array(Schedule::PRESETS.keys) }
  it { is_expected.to validate_numericality_of(:items_count).is_greater_than(0).only_integer }

  it 'validates that datetime_start is valid DateTime' do
    s = Schedule.new(datetime_start: 'not DateTime')
    s.valid?
    expect(s.errors.messages[:datetime_start]).to eq ['must be a valid date and time']
  end

  context '#datetime_start=' do
    it 'assigns datetime_start to nil if the argument is nil' do
      s = Schedule.new
      s.datetime_start = nil
      expect(s.datetime_start).to eq nil
    end

    it 'assigns datetime_start to nil if the argument cannot be parsed as DateTime' do
      s = Schedule.new
      s.datetime_start = 'random string'
      expect(s.datetime_start).to eq nil
    end

    it 'assigns datetime_start to parsed DateTime (ignoring milliseconds)' do
      s = Schedule.new
      datetime = DateTime.now
      datetime_str = datetime.to_s
      s.datetime_start = datetime_str
      expect(s.datetime_start).to eq datetime.change(usec: 0)
    end
  end

  context '#frequency=' do
    it 'assigns frequency to argument converted to symbol' do
      s = Schedule.new
      s.frequency = 'arg'
      expect(s.frequency).to eq :arg
    end

    it 'assigns frequency to :daily if argument is nil' do
      s = Schedule.new
      s.frequency = nil
      expect(s.frequency).to eq :daily
    end
  end

  context '#items_count=' do
    it 'assigns items_count to argument' do
      s = Schedule.new
      s.items_count = 33
      expect(s.items_count).to eq 33
    end

    it 'assigns items_count to default value for current frequency if argument is nil' do
      s = Schedule.new(frequency: :weekly)
      s.items_count = nil
      expect(s.items_count).to eq Schedule::PRESETS[:weekly][:items_count]
    end

  end

  context '#generate_schedule' do
    it 'returns self if object is valid' do
      s = Schedule.new(datetime_start: DateTime.now.to_s, frequency: :daily, items_count: 10)
      expect(s).to receive(:valid?) { true }
      expect(s.generate_schedule).to eq s
    end

    it 'returns false if object is invalid' do
      s = Schedule.new
      expect(s).to receive(:valid?) { false }
      expect(s.generate_schedule).to eq false
    end

    it 'sets schedule as array of DateTime\'s' do
      s = Schedule.new(datetime_start: DateTime.now.to_s, frequency: :daily, items_count: 2)
      expect(s.schedule).to eq []
      s.generate_schedule
      sched = s.schedule
      expect(sched.class).to eq Array
      expect(sched.first.class).to eq DateTime
      expect(sched.second.class).to eq DateTime
    end

    it 'adds datetime_start to schedule as first element (ignores milliseconds)' do
      datetime = DateTime.now
      s = Schedule.new(datetime_start: datetime.to_s, frequency: :daily, items_count: 2)
      s.generate_schedule
      expect(s.schedule.first).to eq datetime.change(usec: 0)
    end

    it 'makes schedule size match items_count' do
      s = Schedule.new(datetime_start: DateTime.now.to_s, frequency: :daily, items_count: 5)
      s.generate_schedule
      expect(s.schedule.size).to eq 5
    end

    it 'adds to schedule DateTime\'s that differ by frequency' do
      s = Schedule.new(datetime_start: DateTime.now.to_s, frequency: :monthly, items_count: 3)
      s.generate_schedule
      sched = s.schedule
      expect(sched.second - sched.first) == 1.month
      expect(sched.third - sched.second) == 1.month
    end
  end
end
