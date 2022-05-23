class ExampleCommand
  extend Commands::Base

  def initialize(params)
    @params = params
  end

  def call
    if @params[:error]
      raise @params[:error]
    else
      ok(@params[:data])
    end
  end
end

describe ExampleCommand do
  let(:params) { {} }

  describe 'self.call!' do
    subject { described_class }

    context 'with data' do
      let(:params) { { data: 42 } }

      it 'succeeds' do
        response = subject.call!(params)
        expect(response).to have_succeeded
        expect(response.data).to eq(42)
      end
    end

    context 'with an error' do
      let(:error) { StandardError.new('oh no!') }
      let(:params) { { error: error } }

      it 'raises' do
        expect { subject.call!(params) }.to raise_error error
      end
    end
  end

  describe 'self.call' do
    subject { described_class }

    context 'with data' do
      let(:params) { { data: 42 } }

      it 'succeeds' do
        response = subject.call(params)
        expect(response).to have_succeeded
        expect(response.data).to eq(42)
      end
    end

    context 'with an error' do
      subject { described_class }

      let(:error) { StandardError.new('oh no!') }
      let(:params) { { error: error } }

      it 'fails' do
        response = subject.call(params)
        expect(response).to have_failed
        expect(response.data).to eq(error)
      end

      it 'does not raise' do
        expect { subject.call(params) }.not_to raise_error
      end
    end
  end

  describe 'call' do
    subject { described_class.new(params) }

    context 'with data' do
      let(:params) { { data: 42 } }

      it 'succeeds' do
        response = subject.call

        expect(response).to have_succeeded
        expect(response.data).to eq(42)
      end
    end

    context 'with an error' do
      let(:params) { { error: 'oh no!' } }

      it 'raises' do
        expect { subject.call }.to raise_error(/oh no!/)
      end
    end
  end
end
