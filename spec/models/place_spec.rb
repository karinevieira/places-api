require 'rails_helper'

RSpec.describe Place, type: :model do
  let(:name)  { 'Estação das Docas' }
  let(:city)  { 'Belém' }
  let(:state) { 'Pará' }
  let(:token) { '1234567890' }
  subject { Place.new(name: name, city: city, state: state, token: token) }

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:token) }

    it { should validate_length_of(:token).is_at_least(10) }
  end

  describe 'scope' do
    it '.by_token' do
      expect(Place.where(token: token).to_sql).to eq Place.by_token(token).to_sql
    end

    it '.search' do
      expect(Place.where('LOWER(name) LIKE ?', "%#{name.downcase}%").to_sql).to eq Place.search(name).to_sql
    end

    it '.sorted_by_name' do
      expect(Place.order(:name).to_sql).to eq Place.sorted_by_name.to_sql
    end
  end
end
