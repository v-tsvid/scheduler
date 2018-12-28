class Schedule
  include ActiveModel::Model

  PRESETS = { daily:      { increment: 1.day,     items_count: 14 },
              weekly:     { increment: 1.week,    items_count: 8  },
              monthly:    { increment: 1.month,   items_count: 6  },
              bi_monthly: { increment: 2.months,  items_count: 6  },
              quarterly:  { increment: 3.months,  items_count: 4  },
              yearly:     { increment: 1.year,    items_count: 3  } }.freeze

  attr_reader :datetime_start, :frequency, :items_count
  attr_accessor :schedule

  validates :frequency, inclusion: { in: PRESETS.keys }
  validates :items_count, numericality: { only_integer: true,
                                          greater_than: 0,
                                          allow_blank: true }
  validate :datetime_start_is_valid

  def initialize(attributes = {})
    super
    self.datetime_start = attributes[:datetime_start]
    self.frequency = attributes[:frequency]
    self.items_count = attributes[:items_count]
    self.schedule = []
  end

  def generate_schedule
    return false unless valid?
    current_datetime = datetime_start
    items_count.times do
      schedule << current_datetime
      current_datetime += PRESETS[frequency][:increment]
    end
    self
  end

  def datetime_start=(str)
    @datetime_start = begin
      DateTime.parse(str || '')
    rescue ArgumentError
      DateTime.now
    end
  end

  def frequency=(str)
    @frequency = str&.to_sym || PRESETS.keys.first
  end

  def items_count=(str)
    @items_count = str.to_i || PRESETS[self.frequency][:items_count]
  end

  private

  def datetime_start_is_valid
    unless datetime_start.is_a? DateTime
      errors.add(:datetime_start, 'must be a valid date and time')
    end
  end
end