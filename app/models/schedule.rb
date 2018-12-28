class Schedule
  include ActiveModel::Model

  PRESETS = { daily:      { increment: 1.day,     items_count: 14 },
              weekly:     { increment: 1.week,    items_count: 8  },
              monthly:    { increment: 1.month,   items_count: 6  },
              bi_monthly: { increment: 2.months,  items_count: 6  },
              quarterly:  { increment: 3.months,  items_count: 4  },
              yearly:     { increment: 1.year,    items_count: 3  } }.freeze

  attr_accessor :datetime_start, :frequency, :items_count, :schedule

  validates_presence_of :datetime_start, :frequency
  validates :frequency, inclusion: { in: PRESETS.keys }
  validates :items_count, numericality: { only_integer: true,
                                          greater_than: 0,
                                          allow_blank: true }

  def initialize(attributes = {})
    super
    @datetime_start = attributes[:datetime_start] || DateTime.now
    @frequency = attributes[:frequency] || PRESETS.keys.first
    @items_count = attributes[:items_count]
    @items_count ||= PRESETS[self.frequency][:items_count]
    @schedule = []
  end

  def generate_schedule
    return unless valid?
    current_datetime = datetime_start
    10.times do
      schedule << current_datetime
      current_datetime += PRESETS[frequency][:increment]
    end
    self
  end
end