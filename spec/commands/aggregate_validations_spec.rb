describe Commands::AggregateValidations do
  include Commands::AggregateValidations

  describe 'aggregate_validations' do
    it 'calls procs' do
      expect {aggregate_validations(-> {})}.not_to raise_error
    end

    it 'merges errors' do
      expect(aggregate_validations(-> {raise Commands::Errors::ParameterValidation.new('foo', {error1: :error1})},
                                   -> {raise Commands::Errors::ParameterValidation.new('foo', {error2: :error2})})).to eq({:error1 => :error1, :error2 => :error2})
    end
  end

  describe 'aggregate_validations!' do
    it 'raises errors' do
      expect {aggregate_validations!(-> {raise Commands::Errors::ParameterValidation, 'boom'})}.to raise_error(Commands::Errors::ParameterValidation)
    end
  end

end
