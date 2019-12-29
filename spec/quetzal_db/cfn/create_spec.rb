# frozen_string_literal: true

RSpec.describe QuetzalDb::Cfn::Create do
  subject(:template) do
    Helpers::Template.new(File.join(__dir__, '..', '..', '..', 'quetzal-db-create-stack.yml'))
  end

  let(:expected_empty_resource) do
    {
      'Type' => 'Custom::EmptyResource',
      'Condition' => 'NotCreate'
    }
  end

  it 'adds an empty resource' do
    empty_resource = template['Resources']['EmptyResource']
    expect(empty_resource).to eq(expected_empty_resource)
  end
end
