# frozen_string_literal: true

RSpec.describe QuetzalDb::Cfn::SecretsManager::DDLSecret do
  subject(:template) do
    Helpers::Template.new(File.join(__dir__, '..', '..', '..', '..', 'quetzal-db-update-stack.yml'))
  end

  let(:secret) { template['Resources']['QuetzalDbDDLSecret'] }

  it_behaves_like 'secret'

  it 'sets the correct description' do
    expect(secret['Properties']['Description']).to eq('Quetzal DB DDL Access')
  end

  it 'sets the correct string template' do
    expect(secret['Properties']['GenerateSecretString']['SecretStringTemplate']).to eq('{"username": "ddl"}')
  end
end
