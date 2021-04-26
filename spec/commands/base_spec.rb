describe Commands::Base do
  class ForeignKeyFailure < Commands::Base
    def initialize(model:)
      @model = model
    end
    def call
      @model.destroy!
    end
  end

  describe 'self.call' do
    context 'invalid foreign key' do
      #TODO: Stub some objects
      xit 'returns english error message' do
      end
    end
  end
end
