class Api::V1::CandlestickDatesController < Api::V1::BaseApiController
  def update_metric
    result = CandlestickServices::CreateMetricDateService.new(params["merchandise_rate_ids"]).execute

    render json: result
  end
end
