module Commands
  class PreliminaryRepoCollection

    attr_reader :collection

    def initialize(uuid, *elements)
      @uuid = uuid
      set_elements(elements)
    end

    def primary_uuid
      @uuid
    end

    def <<(element)
      @collection << element
    end

    def each
      @collection.map{ |element| yield element }
    end

    def set_elements(elements)
      @collection = elements
    end
  end
end