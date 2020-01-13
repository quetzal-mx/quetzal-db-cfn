# frozen_string_literal: true

RSpec.describe QuetzalDb::Cfn::EC2::NATGateway do
  subject(:template) do
    Helpers::Template.new(File.join(__dir__, '..', '..', '..', '..', 'quetzal-db-update-stack.yml'))
  end

  let(:expected_nat_gateway) do
    {
      'Type' => 'AWS::EC2::NatGateway',
      'Properties' => {
        'AllocationId' => {
          'Fn::GetAtt' => %w[
            QuetzalElasticIp
            AllocationId
          ]
        },
        'SubnetId' => {
          'Ref' => 'PublicSubnetId'
        }
      }
    }
  end

  it 'creates the NAT Gateway' do
    nat_gateway = template['Resources']['QuetzalNATGateway']
    expect(nat_gateway).to eq(expected_nat_gateway)
  end
end
