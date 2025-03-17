require "active_record"
require "activerecord-import"

module CandlestickServices
  class CreateRangeService
    include Common::CreateCandlestick

    attr_accessor :merchandise_rate_ids

    def initialize(merchandise_rate_ids = MERCHANDISE_RATE_IDS)
      @merchandise_rate_ids = merchandise_rate_ids
    end

    def execute
      create_data
      validate_data
    end

    private
    def create_data
      merchandise_rate_ids.each do |merchandise_rate_id|
        merchandise_rate = MerchandiseRate.find_by(id: merchandise_rate_id)
        return unless merchandise_rate.present?

        [ "candlestick_date", "candlestick_hour", "candlestick_month", "candlestick_week" ].each do |c_type|
          candlesticks = c_type.camelize.constantize.where(id: not_ranged_yet(merchandise_rate, c_type))
          records = build_range merchandise_rate, candlesticks, c_type

          if records.present?
            ActiveRecord::Base.transaction do
              "Range#{c_type.camelize}".constantize.import(records, validate: false)
            end
          end
        end
      end
    end

    def not_ranged_yet merchandise_rate, type="candlestick_date"
      candlesticks = merchandise_rate.send("#{type}s")
      candlesticks.pluck(:id).uniq - merchandise_rate.send("range_#{type}s").pluck("#{type}_id".to_sym).uniq
    end

    def validate_data
      result = {}

      merchandise_rate_ids.each do |merchandise_rate_id|
        merchandise_rate = MerchandiseRate.find(merchandise_rate_id)
        result[merchandise_rate_id] = {}
        result[merchandise_rate_id]["name"] = merchandise_rate.slug
        result[merchandise_rate_id]["date_not_range"] = CandlestickDate.where(id: not_ranged_yet(merchandise_rate, "candlestick_date")).pluck(:date)
        result[merchandise_rate_id]["hour_not_range"] = CandlestickHour.where(id: not_ranged_yet(merchandise_rate, "candlestick_hour")).pluck(:date)
        result[merchandise_rate_id]["month_not_range"] = CandlestickMonth.where(id: not_ranged_yet(merchandise_rate, "candlestick_month")).pluck(:date)
        result[merchandise_rate_id]["week_not_range"] = CandlestickWeek.where(id: not_ranged_yet(merchandise_rate, "candlestick_week")).pluck(:date)
      end

      result
    end

    # Khong tinh range voi nhung data chua co du window
    def build_range(merchandise_rate, data, c_type)
      records = []
      window = c_type.camelize.constantize::C_WINDOW - 1

      data.each do |record|
        window_data = record.before_candlesticks(window)
        next if window_data.count < window
        oc_arr = window_data.map {|x| x.return_oc.abs} + [record.return_oc.abs]
        hl_arr = window_data.map {|x| x.return_hl} + [record.return_hl]

        mean_oc = oc_arr.sum(0.0)/window.to_f
        mean_hl = hl_arr.sum(0.0)/window.to_f

        record_hash = {
          date: record.date,
          mean_oc: mean_oc.round(4),
          mean_hl: mean_hl.round(4),
          standard_deviation_oc: calculate_std_with_mean(oc_arr, mean_oc),
          standard_deviation_hl: calculate_std_with_mean(hl_arr, mean_hl),
          merchandise_rate_id: merchandise_rate.id
        }

        record_hash["#{c_type}_id"] = record.id

        records.push(record_hash)
      end

      records
    end

    # Hàm tính độ lệch chuẩn khi đã biết trung bình (mean) - áp dụng cho mẫu (sample)
    # Bước 1+2: Tính phương sai (variance)
    # - data.map { |x| (x - mean) ** 2 }: Tạo mảng chứa bình phương khoảng cách từ mỗi giá trị (x) đến mean
    #   + (x - mean): Khoảng cách từ giá trị x_i đến trung bình (mean)
    #   + ** 2: Bình phương khoảng cách để loại bỏ giá trị âm và đo lường mức độ phân tán
    # - .sum: Tính tổng tất cả các giá trị bình phương, tương ứng với Σ(x_i - mean)^2
    # - / (data.length - 1): Chia tổng cho (n - 1), với n là số phần tử trong data
    #   + Dùng (n - 1) thay vì n vì đây là độ lệch chuẩn của mẫu (sample), điều chỉnh sai số ước lượng
    # - .to_f: Đảm bảo kết quả là số thực (float) thay vì số nguyên khi chia
    # Bước 3: Tính độ lệch chuẩn (standard deviation)
    # - Math.sqrt(variance): Lấy căn bậc hai của phương sai để ra độ lệch chuẩn
    # - Công thức hoàn chỉnh: std = √[Σ(x_i - mean)^2 / (n - 1)]
    def calculate_std_with_mean(data, mean)
      variance = data.map { |x| (x - mean) ** 2 }.sum / (data.length - 1).to_f
      Math.sqrt(variance).round(4)
    end
  end
end
