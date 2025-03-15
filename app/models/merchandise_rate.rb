# == Schema Information
#
# Table name: merchandise_rates
#
#  id         :bigint           not null, primary key
#  tag_id     :bigint           not null
#  name       :string(255)
#  slug       :string(255)
#  base_id    :integer
#  quote_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class MerchandiseRate < ApplicationRecord
  has_many :candlestick_months
  has_many :candlestick_weeks
  has_many :candlestick_dates
  has_many :candlestick_hours
  has_many :date_events
  has_many :event_masters
  has_many :patterns
  has_many :metric_dates
  has_many :pattern_candlestick_dates
  has_many :label_candlestick_dates
  has_many :label_candlestick_hours
  has_many :label_candlestick_weeks
  has_many :label_candlestick_months

  belongs_to :tag
  belongs_to :base, class_name: "Merchandise"
  belongs_to :quote, class_name: "Merchandise"

  validates :base_id, presence: true
  validates :quote_id, presence: true

  before_create :genarate_slug
  before_update :genarate_slug

  scope :crypto_currencies, -> { where(tag_id: 8) }

  def lastest_candlestick_date(interval)
    send("candlestick_#{interval}s".to_sym).sort_by_type(:desc).first&.date
  end

  def start_end_date(interval = "hour")
    merchandise_rate_candlestick_dates = send("candlestick_#{interval}s".to_sym).sort_by_type(:desc).pluck(:date)
    [ merchandise_rate_candlestick_dates.last, merchandise_rate_candlestick_dates.first ]
  end

  def is_btc?
    self.id == 34
  end

  private
  def genarate_slug
    return if self.slug.present?
    base = Merchandise.find(base_id)
    quote = Merchandise.find(quote_id)
    self.slug = "#{base.slug}#{quote.slug}"
  end
end
