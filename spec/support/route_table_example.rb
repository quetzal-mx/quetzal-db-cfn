# frozen_string_literal: true

RSpec.shared_examples 'route_table' do
  let(:expected_route_table) do
    {
      'Type' => 'AWS::EC2::RouteTable',
      'Properties' => {
        'Tags' => tags,
        'VpcId' => {
          'Ref' => 'VpcId'
        }
      }
    }
  end

  it 'creates the route table' do
    expect(route_table).to eq(expected_route_table)
  end
end
