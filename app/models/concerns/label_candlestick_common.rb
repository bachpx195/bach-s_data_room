module LabelCandlestickCommon
  extend ActiveSupport::Concern

  included do
    scope :find_by_label, -> label_id do
      where(label_id: label_id)
    end
  end
end
