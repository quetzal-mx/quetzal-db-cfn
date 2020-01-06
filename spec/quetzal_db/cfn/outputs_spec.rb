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
        },
        'Export' => {
          'Name' => {
            'Fn::Sub' => '${AWS::StackName}-QuetzalDbEndpoint'
          }
        }
      },
      'QuetzalDbPort' => {
        'Description' => 'Quetzal DB port',
        'Value' => {
          'Fn::GetAtt' => %w[
            QuetzalDB
            Endpoint.Port
          ]
        },
        'Export' => {
          'Name' => {
            'Fn::Sub' => '${AWS::StackName}-QuetzalDbPort'
          }
        }
      },
      'AccessSecurityGroup' => {
        'Description' => 'Quetzal DB Security Group',
        'Value' => {
          'Fn::GetAtt' => %w[
            QuetzalDbAccessGroup
            GroupId
          ]
        },
        'Export' => {
          'Name' => {
            'Fn::Sub' => '${AWS::StackName}-AccessSecurityGroup'
          }
        }
      }
    }
  end

  it 'creates the outputs' do
    outputs = template['Outputs']
    expect(outputs).to eq(expected_outputs)
  end
end
