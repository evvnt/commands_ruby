module Commands
  module PreliminaryRepo
    def preliminary_repo(key_prefix = 'prefatory')
      @repo ||= ::Prefatory::Repository.new(key_prefix: key_prefix)
    end
  end
end

