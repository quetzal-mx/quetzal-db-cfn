# frozen_string_literal: true

RSpec.describe QuetzalDb::Cfn::Outputs do
  subject(:template) do
    Helpers::Template.new(File.join(__dir__, '..', '..', '..', 'quetzal-db-update-stack.yml'))
  end

  let(:expected_outputs) do
    {
      'QuetzalDbEndpoint' => {
        'Description' => 'Quetzal DB endpoint',
        'Value' => {
          'Fn::GetAtt' => %w[
            QuetzalDB
            Endpoint.Address
          ]
        }
      },
      'QuetzalDbPort' => {
        'Description' => 'Quetzal DB port',
        'Value' => {
          'Fn::GetAtt' => %w[
            QuetzalDB
            Endpoint.Port
          ]
        }
      }
    }
  end

  it 'creates the outputs' do
    outputs = template['Outputs']
    expect(outputs).to eq(expected_outputs)
  end
end
