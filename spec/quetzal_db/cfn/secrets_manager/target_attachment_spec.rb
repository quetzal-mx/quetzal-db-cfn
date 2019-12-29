# frozen_string_literal: true

RSpec.describe QuetzalDb::Cfn::SecretsManager::TargetAttachment do
  subject(:template) do
    Helpers::Template.new(File.join(__dir__, '..', '..', '..', '..', 'quetzal-db-update-stack.yml'))
  end

  let(:expected_target_attachment) do
    {
      'Type' => 'AWS::SecretsManager::SecretTargetAttachment',
      'Properties' => {
        'SecretId' => {
          'Ref' => 'QuetzalDbRootSecret'
        },
        'TargetId' => {
          'Ref' => 'QuetzalDB'
        },
        'TargetType' => 'AWS::RDS::DBInstance'
      }
    }
  end

  it 'creates the attachment' do
    attachment = template['Resources']['QuetzalSecretAttachment']
    expect(attachment).to eq(expected_target_attachment)
  end
end
