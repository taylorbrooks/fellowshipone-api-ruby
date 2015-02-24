module FellowshipOne
  class Person
    def self.all
      path = "/v1/People"
      get(path)
    end

    def self.new
      @path = "/v1/People/new"
    end

    def self.find(person_id)
      @path = "/v1/People/#{person_id}"
    end

  end
end
