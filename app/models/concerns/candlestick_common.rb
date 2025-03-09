module CandlestickCommon
  extend ActiveSupport::Concern

  included do
    scope :sort_by_type, -> sort_type = :desc do
      order(date: sort_type)
    end
  end
end
