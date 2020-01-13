# frozen_string_literal: true

# rubocop:disable RSpec/DescribeClass
RSpec.describe 'QuetzalDb::Cfn::EC2::PublicSubnetRouteTable' do
  # rubocop:enable RSpec/DescribeClass

  subject(:template) do
    Helpers::Template.new(File.join(__dir__, '..', '..', '..', '..', 'quetzal-db-update-stack.yml'))
  end

  let(:route_table) { template['Resources']['PublicSubnetRouteTable'] }

  let(:tags) do
    [
      { 'Key' => 'Name', 'Value' => 'Public Subnet' }
    ]
  end

  it_behaves_like 'route_table'
end
