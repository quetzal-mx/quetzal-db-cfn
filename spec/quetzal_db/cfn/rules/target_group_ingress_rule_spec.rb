# frozen_string_literal: true

# rubocop:disable RSpec/DescribeClass
RSpec.describe 'QuetzalDb::Cfn::TargetGroup::Ingress' do
  # rubocop:enable RSpec/DescribeClass
  subject(:template) do
    Helpers::Template.new(File.join(__dir__, '..', '..', '..', '..', 'quetzal-db-update-stack.yml'))
  end

  let(:expected_ingress_rule) do
    {
      'Type' => 'AWS::EC2::SecurityGroupIngress',
      'Properties' => {
        'IpProtocol' => 'tcp',
        'FromPort' => 5432,
        'ToPort' => 5432,
        'SourceSecurityGroupId' => {
          'Fn::GetAtt' => %w[
            QuetzalDbAccessGroup
            GroupId
          ]
        },
        'GroupId' => {
          'Fn::GetAtt' => %w[
            QuetzalDbTargetGroup
            GroupId
          ]
        }
      }
    }
  end

  it 'uses the correct configuration' do
    rule = template['Resources']['QuetzalDbTargetGroupIngressRule']
    expect(rule).to eq(expected_ingress_rule)
  end
end
