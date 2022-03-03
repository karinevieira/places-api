require 'rails_helper'

RSpec.describe "/places", type: :request do
  let(:name)  { 'Estação das Docas' }
  let(:city)  { 'Belém' }
  let(:state) { 'Pará' }
  let(:token) { '1234567890' }

  let(:valid_attributes) do
    { name: name, city: city, state: state, token: token }
  end 

  let(:invalid_attributes) do
    { name: nil, city: nil, state: nil, token: token } 
  end 

  let(:valid_headers) do
    { Authorization: token }
  end
  
  let(:invalid_headers) do
    { Authorization: '123456789' }
  end

  describe "GET /index" do
    context "with headers" do
      it "renders a successful response" do
        Place.create! valid_attributes
        get api_places_url, headers: valid_headers, as: :json
        expect(response).to be_successful
      end
    end

    context "without headers" do
      it "renders a JSON response with an unauthorized status" do
        get api_places_url, as: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "with invalid headers" do
      it "renders a JSON response with an unauthorized status" do
        get api_places_url, headers: invalid_headers, as: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      place = Place.create! valid_attributes
      get api_place_url(place), headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Place" do
        expect {
          post api_places_url,
               params: { place: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Place, :count).by(1)
      end

      it "renders a JSON response with the new place" do
        post api_places_url,
             params: { place: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Place" do
        expect {
          post api_places_url,
               params: { place: invalid_attributes }, headers: valid_headers, as: :json
        }.to change(Place, :count).by(0)
      end

      it "renders a JSON response with errors for the new place" do
        post api_places_url,
             params: { place: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_name)  { 'MASP' }
      let(:new_city)  { 'São Paulo' }
      let(:new_state) { 'São Paulo' }

      let(:new_attributes) do
        { name: new_name, city: new_city, state: new_state }
      end 

      it "updates the requested place" do
        place = Place.create! valid_attributes
        patch api_place_url(place),
              params: { place: new_attributes }, headers: valid_headers, as: :json
        place.reload

        expect(place.name).to eq(new_name)
        expect(place.city).to eq(new_city)
        expect(place.state).to eq(new_state)
      end

      it "renders a JSON response with the place" do
        place = Place.create! valid_attributes
        patch api_place_url(place),
              params: { place: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the place" do
        place = Place.create! valid_attributes
        patch api_place_url(place),
              params: { place: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested place" do
      place = Place.create! valid_attributes
      expect {
        delete api_place_url(place), headers: valid_headers, as: :json
      }.to change(Place, :count).by(-1)
    end
  end
end
