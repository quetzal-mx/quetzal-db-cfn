# frozen_string_literal: true

# rubocop:disable RSpec/DescribeClass
RSpec.describe 'QuetzalDb::Cfn::EC2::PrivateSubnetRouteTable' do
  # rubocop:enable RSpec/DescribeClass

  subject(:template) do
    Helpers::Template.new(File.join(__dir__, '..', '..', '..', '..', 'quetzal-db-update-stack.yml'))
  end

  let(:route_table) { template['Resources']['PrivateSubnetRouteTable'] }

  let(:tags) do
    [
      { 'Key' => 'Name', 'Value' => 'Private Lambda Subnet' }
    ]
  end

  it_behaves_like 'route_table'
end
