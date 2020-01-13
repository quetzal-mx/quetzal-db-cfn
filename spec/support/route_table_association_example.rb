# frozen_string_literal: true

RSpec.shared_examples 'route_table_association' do
  let(:expected_route_table_association) do
    {
      'Type' => 'AWS::EC2::SubnetRouteTableAssociation',
      'Properties' => {
        'RouteTableId' => {
          'Ref' => route_table
        },
        'SubnetId' => {
          'Ref' => subnet
        }
      }
    }
  end

  it 'creates the association' do
    expect(route_table_association).to eq(expected_route_table_association)
  end
end
