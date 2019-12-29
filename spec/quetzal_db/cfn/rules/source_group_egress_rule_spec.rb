# frozen_string_literal: true

# rubocop:disable RSpec/DescribeClass
RSpec.describe 'QuetzalDb::Cfn::SourceGroup::Egress' do
  # rubocop:enable RSpec/DescribeClass
  subject(:template) do
    Helpers::Template.new(File.join(__dir__, '..', '..', '..', '..', 'quetzal-db-update-stack.yml'))
  end

  let(:expected_egress_rule) do
    {
      'Type' => 'AWS::EC2::SecurityGroupEgress',
      'Properties' => {
        'IpProtocol' => 'tcp',
        'FromPort' => 0,
        'ToPort' => 65_535,
        'DestinationSecurityGroupId' => {
          'Fn::GetAtt' => %w[
            QuetzalDbTargetGroup
            GroupId
          ]
        },
        'GroupId' => {
          'Fn::GetAtt' => %w[
            QuetzalDbAccessGroup
            GroupId
          ]
        }
      }
    }
  end

  it 'uses the correct configuration' do
    rule = template['Resources']['QuetzalDbAccessGroupEgressRule']
    expect(rule).to eq(expected_egress_rule)
  end
end
