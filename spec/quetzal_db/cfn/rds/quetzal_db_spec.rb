# frozen_string_literal: true

RSpec.describe QuetzalDb::Cfn::RDS::QuetzalDb do
  subject(:template) do
    Helpers::Template.new(File.join(__dir__, '..', '..', '..', '..', 'quetzal-db-update-stack.yml'))
  end

  let(:expected_db) do
    {
      'Type' => 'AWS::RDS::DBInstance',
      'Properties' => {
        'AllocatedStorage' => 20,
        'DBInstanceClass' => {
          'Fn::FindInMap' => [
            'Stages',
            {
              'Ref' => 'Stage'
            },
            'DBInstanceType'
          ]
        },
        'DBName' => 'quetzal_db',
        'Engine' => 'postgres',
        'EngineVersion' => 11.5,
        'MasterUsername' => {
          'Fn::Join' => [
            '',
            [
              '{{resolve:secretsmanager:',
              {
                'Ref' => 'QuetzalDbRootSecret'
              },
              ':SecretString:username}}'
            ]
          ]
        },
        'MasterUserPassword' => {
          'Fn::Join' => [
            '',
            [
              '{{resolve:secretsmanager:',
              {
                'Ref' => 'QuetzalDbRootSecret'
              },
              ':SecretString:password}}'
            ]
          ]
        },
        'VPCSecurityGroups' => [{
          'Fn::GetAtt' => %w[QuetzalDbTargetGroup GroupId]
        }]
      }
    }
  end

  it 'creates the resource with the right configuration' do
    db = template['Resources']['QuetzalDB']
    expect(db).to eq(expected_db)
  end
end
