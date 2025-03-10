module CandlestickCommon
  extend ActiveSupport::Concern

  included do
    scope :sort_by_type, -> sort_type = :desc do
      order(date: sort_type)
    end

    scope :null_parent_id, -> do
      where(parent_id: nil)
    end 
  end
end
