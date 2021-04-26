require 'rails_helper'

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
      let(:org){ create(:organization)}
      before { create(:customer_order, organization: org) }

      it 'returns english error message' do
        expect(ForeignKeyFailure.call(model: org).success?).to eq(false)
        expect(ForeignKeyFailure.call(model: org).errors[:exception]).to match(/.*Organization.*Customer Orders.*/)
      end
    end
  end
end
