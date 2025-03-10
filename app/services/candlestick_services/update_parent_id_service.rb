require "active_record"

# Muc dich
# Update parent id cua cac candlestick
module CandlestickServices
  class UpdateParentIdService
    include Common::CreateCandlestick

    def initialize
    end

    # b1: Kiem tra parent id nao da bi xoa va update lai nhung candlestick chua parent id bi xoa 
    # b2: Kiem tra cac candlestick nao chua co parent id va update
    def execute
      result = {
        "parent_id removed": nil,
        "null parent_id": nil,
      }
      
      # parent_id removed
      hour_parent_ids = hour_parent_ids_removed
      if hour_parent_ids.present?
        CandlestickHour.where(parent_id: hour_parent_ids).each do |ch|
          ch.update_parent_id
        end
      end

      date_parent_ids, date_parent_month_ids = date_parent_ids_removed
      if date_parent_ids.present?
        CandlestickDate.where(parent_id: date_parent_ids).each do |cd|
          cd.update_parent_id
        end
      end

      if date_parent_month_ids.present?
        CandlestickDate.where(parent_month_id: date_parent_month_ids).each do |cd|
          cd.update_parent_id
        end
      end

      #null parent_id
      CandlestickHour.null_parent_id.each { |ch| ch.update_parent_id } if CandlestickHour.null_parent_id.present?
      CandlestickDate.null_parent_id.each { |ch| ch.update_parent_id } if CandlestickDate.null_parent_id.present?
      CandlestickDate.null_parent_month_id.each { |ch| ch.update_parent_month_id } if CandlestickDate.null_parent_id.present?

      result
    end

    private
    def hour_parent_ids_removed
      CandlestickHour.pluck(:parent_id).uniq - CandlestickDate.pluck(:id)
    end

    # parent_id & parent_month_id
    def date_parent_ids_removed
      [CandlestickDate.pluck(:parent_id).uniq - CandlestickWeek.pluck(:id), CandlestickDate.pluck(:parent_month_id).uniq - CandlestickMonth.pluck(:id)]
    end
  end
end
