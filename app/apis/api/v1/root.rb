module API
  module V1
    class Root < Grape::API
      # http://localhost:3000/api/v1/
      version 'v1'
      format :json
      formatter :json, Grape::Formatter::Jbuilder

      mount API::V1::Cards::Check
    end
  end
end
