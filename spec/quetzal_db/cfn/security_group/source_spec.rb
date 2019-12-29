# frozen_string_literal: true

# rubocop:disable RSpec/DescribeClass
RSpec.describe 'QuetzalDb::Cfn::SecurityGroup::Source' do
  # rubocop:enable RSpec/DescribeClass
  subject(:template) do
    Helpers::Template.new(File.join(__dir__, '..', '..', '..', '..', 'quetzal-db-update-stack.yml'))
  end

  let(:expected_security_group) do
    {
      'Type' => 'AWS::EC2::SecurityGroup',
      'Properties' => {
        'GroupDescription' => 'Quetzal DBs access security group'
      }
    }
  end

  it 'uses the correct configuration' do
    security_group = template['Resources']['QuetzalDbAccessGroup']
    expect(expected_security_group).to eq(security_group)
  end
end
