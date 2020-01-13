# frozen_string_literal: true

RSpec.describe QuetzalDb::Cfn::EC2::EIP do
  subject(:template) do
    Helpers::Template.new(File.join(__dir__, '..', '..', '..', '..', 'quetzal-db-update-stack.yml'))
  end

  let(:expected_elastic_ip) do
    {
      'Type' => 'AWS::EC2::EIP',
      'Properties' => {
        'Domain' => 'vpc'
      }
    }
  end

  it 'creates the elastic ip' do
    elastic_ip = template['Resources']['QuetzalElasticIp']
    expect(elastic_ip).to eq(expected_elastic_ip)
  end
end
