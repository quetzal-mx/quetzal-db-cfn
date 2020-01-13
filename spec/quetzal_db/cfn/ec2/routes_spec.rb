# frozen_string_literal: true

# rubocop:disable RSpec/DescribeClass
RSpec.describe 'QuetzalDb::Cfn::EC2::Routes' do
  # rubocop:enable RSpec/DescribeClass

  subject(:template) do
    Helpers::Template.new(File.join(__dir__, '..', '..', '..', '..', 'quetzal-db-update-stack.yml'))
  end

  context 'when creating the public subnet routes' do
    let(:route) { template['Resources']['DefaultPublicRoute'] }

    let(:expected_route) do
      {
        'Type' => 'AWS::EC2::Route',
        'Properties' => {
          'DestinationCidrBlock' => '0.0.0.0/0',
          'GatewayId' => {
            'Ref' => 'InternetGatewayId'
          },
          'RouteTableId' => {
            'Ref' => 'PublicSubnetRouteTable'
          }
        }
      }
    end

    it 'creates the route with the gateway as target' do
      expect(route).to eq(expected_route)
    end
  end

  context 'when creating the private subnet routes' do
    let(:route) { template['Resources']['NATPrivateRoute'] }

    let(:expected_route) do
      {
        'Type' => 'AWS::EC2::Route',
        'Properties' => {
          'DestinationCidrBlock' => '0.0.0.0/0',
          'NatGatewayId' => {
            'Ref' => 'QuetzalNATGateway'
          },
          'RouteTableId' => {
            'Ref' => 'PrivateSubnetRouteTable'
          }
        }
      }
    end

    it 'creates the route with the NAT gateway as target' do
      expect(route).to eq(expected_route)
    end
  end
end
