module CandlestickServices
  class CreateSp500Service

    def initialize()
    end

    def execute
      pyscript_path = Rails.root.join('tvDatafeed/main.py')
      exec("python3 #{pyscript_path}")
    end
  end
end
