# frozen_string_literal: true

# rubocop:disable RSpec/DescribeClass
RSpec.describe 'QuetzalDb::Cfn::RDS::QuetzalDbSubnetGroup' do
  # rubocop:enable RSpec/DescribeClass

  subject(:template) do
    Helpers::Template.new(File.join(__dir__, '..', '..', '..', '..', 'quetzal-db-update-stack.yml'))
  end

  let(:expected_group) do
    {
      'Type' => 'AWS::RDS::DBSubnetGroup',
      'Properties' => {
        'DBSubnetGroupDescription' => 'Quetzal DB subnets group',
        'SubnetIds' => {
          'Ref' => 'SubnetIds'
        }
      }
    }
  end

  it 'creates the subnet group' do
    group = template['Resources']['QuetzalDbSubnetGroup']
    expect(group).to eq(expected_group)
  end
end
