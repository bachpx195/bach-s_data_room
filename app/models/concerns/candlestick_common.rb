module CandlestickCommon
  extend ActiveSupport::Concern

  included do
    scope :sort_by_type, -> sort_type = :desc do
      order(date: sort_type)
    end

    scope :null_parent_id, -> do
      where(parent_id: nil)
    end

    scope :find_by_merchandise_rate, -> merchandise_rate_id, limit do
      where(merchandise_rate_id: merchandise_rate_id)
      .limit(limit)
      .sort_by_type
    end
  end
end
