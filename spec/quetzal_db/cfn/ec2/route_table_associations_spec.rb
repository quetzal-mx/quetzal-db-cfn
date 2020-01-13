# frozen_string_literal: true

# rubocop:disable RSpec/DescribeClass
RSpec.describe 'QuetzalDb::Cfn::EC2::RouteTableAssociations' do
  # rubocop:enable RSpec/DescribeClass

  subject(:template) do
    Helpers::Template.new(File.join(__dir__, '..', '..', '..', '..', 'quetzal-db-update-stack.yml'))
  end

  context 'when creating the public route table association' do
    let(:route_table_association) { template['Resources']['PublicSubnetRouteTableAssociation'] }
    let(:route_table) { 'PublicSubnetRouteTable' }
    let(:subnet) { 'PublicSubnetId' }

    it_behaves_like 'route_table_association'
  end

  context 'when creating the private route table association' do
    let(:route_table_association) { template['Resources']['PrivateSubnetRouteTableAssociation'] }
    let(:route_table) { 'PrivateSubnetRouteTable' }
    let(:subnet) { 'PrivateSubnetId' }

    it_behaves_like 'route_table_association'
  end
end
