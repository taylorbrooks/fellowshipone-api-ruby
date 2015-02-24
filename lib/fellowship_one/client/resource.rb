module FellowshipOne
  class Resource
    def get(path)
      connection.get do |req|
        req.url path
      end.body
    end
  end
end
