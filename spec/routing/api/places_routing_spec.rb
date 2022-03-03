require "rails_helper"

RSpec.describe Api::PlacesController, type: :routing do
  it { should route(:get, '/api/places').to(action: :index, format: :json) }
  it { should route(:get, 'api/places/1').to(action: :show, id: 1, format: :json) }

  it { should route(:post, '/api/places').to(action: :create, format: :json) }

  it { should route(:put, '/api/places/1').to(action: :update, id: 1,format: :json) }
  it { should route(:patch, '/api/places/1').to(action: :update, id: 1, format: :json) }

  it { should route(:delete, 'api/places/1').to(action: :destroy, id: 1, format: :json) }
end
