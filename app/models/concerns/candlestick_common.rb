module CandlestickCommon
  extend ActiveSupport::Concern

  included do
    scope :date_between, -> start_date, end_date do
      where("date >= ? AND date <= ?", start_date.to_date.beginning_of_day, end_date.to_date.end_of_day)
    end

    scope :sort_by_type, -> sort_type = :desc do
      order(date: sort_type)
    end

    scope :null_parent_id, -> do
      where(parent_id: nil)
    end

    scope :time_between, -> start_time, end_time do
      where("date >= ? AND date <= ?", start_time, end_time )
    end

    scope :find_by_merchandise_rate, -> merchandise_rate_id, limit do
      where(merchandise_rate_id: merchandise_rate_id)
      .limit(limit)
      .sort_by_type
    end
  end
end
