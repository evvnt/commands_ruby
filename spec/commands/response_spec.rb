describe Commands::Response do
  include Commands::SuccessAndFail

  subject { success(data: args) }
  context 'hash with one keys' do
    let(:args) { {a: :foo} }

    describe '[]' do
      it 'returns a' do
        expect(subject[:a]).to eq(:foo)
      end
    end
  end

  context 'hash with two keys' do
      let(:args) { {a: :foo, b: :bar} }

      describe '[]' do
        it 'returns a' do
          expect(subject[:a]).to eq(:foo)
        end

        it 'returns b' do
          expect(subject[:b]).to eq(:bar)
        end
      end
    end
end