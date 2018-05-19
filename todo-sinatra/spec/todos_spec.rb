require_relative 'spec_helper.rb'

describe 'Fetch todos' do
  let(:json_response) { JSON.parse response.body }
  subject(:response) { get '/todos' }

  it { is_expected.to be_ok }
  it { expect(json_response).to have_key 'todos' }
  it { expect(json_response['todos'].count).to eq 2 }
  it { expect(json_response['todos'].first).to eq('item' => 'first') }
end
