module Commands
  # Messages contains metadata (warnings and info) for a +Commands::Response+.
  class Messages
    attr_reader :warnings, :info

    def initialize(warnings: [], info: [])
      @warnings = Array(warnings)
      @info = Array(info)
    end

    def to_h
      { warnings: warnings, info: info }
    end
  end
end
