# frozen_string_literal: true

RSpec.describe QuetzalDb::Cfn::Mappings do
  subject(:template) do
    Helpers::Template.new(File.join(__dir__, '..', '..', '..', 'quetzal-db-update-stack.yml'))
  end

  let(:expected_mappings) do
    {
      'Stages' => {
        'beta' => {
          'DBInstanceType' => 'db.t3.micro'
        }
      }
    }
  end

  it 'creates the mappings' do
    mappings = template['Mappings']
    expect(mappings).to eq(expected_mappings)
  end
end
