module FellowshipOne
  class Fund
    def self.all
      path = "/giving/v1/funds"
      # SHOULD WE DO THIS?
      Fellowship.get(path)

    end
  end
end
