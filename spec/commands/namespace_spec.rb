describe Commands::Namespace do
  include Commands::Namespace
  let(:command) {-> {raise Commands::Errors::ParameterValidation.new('doh!', {err1: :foo})}}
  describe 'namespace_errors' do
    it 'adds namespace' do
      expect(namespace_errors(command,:bar)).to eq ({bar: {err1: :foo}})
    end
  end

  describe 'namespace_errors!' do
    it 'raises' do
      expect {namespace_errors!(command, :bar)}.to raise_error Commands::Errors::ParameterValidation, 'Form validation failed.'
    end
  end
end
