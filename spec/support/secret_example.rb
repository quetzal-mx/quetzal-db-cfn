# frozen_string_literal: true

RSpec.shared_examples 'secret' do
  let(:expected_secret) do
    {
      'Type' => 'AWS::SecretsManager::Secret',
      'Properties' => {
        'GenerateSecretString' => {
          'GenerateStringKey' => 'password',
          'PasswordLength' => 16,
          'ExcludeCharacters' => '"@/\\'
        }
      }
    }
  end

  it 'creates the secret with the correct configuration' do
    secret['Properties'].delete('Description')
    secret['Properties']['GenerateSecretString'].delete('SecretStringTemplate')
    expect(secret).to eq(expected_secret)
  end
end
