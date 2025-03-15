class Api::V1::PatternsController < Api::V1::BaseApiController
  before_action :set_pattern, only: [:index]
  before_action :set_merchandise_rate, only: [:index, :list_pattern]
  
  def index
    result_array = PatternCandlestickDate.where(pattern_id: [@pattern.id] + @pattern.child_patterns.pluck(:id), merchandise_rate_id: @merchandise_rate.id)
                      .order(date: :desc)
                      .pluck(:date)
                      .uniq

    render json: result_array
  end

  def create
    result = PatternServices::CreatePatternService.new(params["pattern_id"]).execute

    render json: result
  end

  def list_pattern
    result_array = @merchandise_rate.patterns.map{|em| [em.id, em.name, em.slug]}

    render json: result_array
  end

  private
  def set_pattern
    @pattern = Pattern.find(params[:pattern_id])
  end

  def set_merchandise_rate
    @merchandise_rate = MerchandiseRate.find(params[:merchandise_rate_id])
  end
end
