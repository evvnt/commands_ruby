module Commands
  module Helpers

    #Can be used to extract certain keys from a hash.
    def pluck_from_hash(params, *keys)
      _h = {}
      Array(keys).each {|k| _h[k] = params[k]}
      _h
    end

    def _pp(params)
      params.to_unsafe_hash.deep_symbolize_keys
    end

  end
end
