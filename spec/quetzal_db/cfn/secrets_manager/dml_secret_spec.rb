# frozen_string_literal: true

# rubocop:disable RSpec/DescribeClass
RSpec.describe 'QuetzalDb::Cfn::SecretsManager::DSLSecret' do
  # rubocop:enable RSpec/DescribeClass

  subject(:template) do
    Helpers::Template.new(File.join(__dir__, '..', '..', '..', '..', 'quetzal-db-update-stack.yml'))
  end

  let(:secret) { template['Resources']['QuetzalDbDMLSecret'] }

  let(:expected_secrets_template) do
    {
      'Fn::Join' => [
        '',
        [
          '{"username": "',
          {
            'Ref' => 'DMLUser'
          },
          '"}'
        ]
      ]
    }
  end

  it 'sets the correct description' do
    expect(secret['Properties']['Description']).to eq('Quetzal DB DML Access')
  end

  it 'sets the correct string template' do
    expect(secret['Properties']['GenerateSecretString']['SecretStringTemplate']).to eq(expected_secrets_template)
  end

  it_behaves_like 'secret'
end
