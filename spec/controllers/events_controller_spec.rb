require 'spec_helper'

describe EventsController do
  let(:account) { create(:account) }
  let(:user) { create(:user, account: account) }
  let(:service) { create(:service_with_escalation_policy, account: account) }

  before do
    sign_in user
  end

  describe 'GET /services/:service_id/events' do
    let!(:event) { create(:event, service: service) }
    before { get :index, service_id: service.uuid }

    it { should assign_to(:events).with([event]) }
    it { should respond_with(:success) }
    it { should render_template(:index) }
  end

  describe 'GET /events/:id' do
    let(:event) { create(:event, service: service) }
    before { get :show, id: event.uuid }

    it { should respond_with(:ok) }
    it { should render_template(:show) }
  end

  describe 'GET /services/:service_id/events/new' do
    before { get :new, service_id: service.uuid }

    it { should respond_with(:ok) }
    it { should render_template(:new) }
  end

  describe 'POST /services/:service_id/events' do
    before { post :create, service_id: service.uuid, event: attributes_for(:event) }

    it { should respond_with(:found) }
    it { should redirect_to event_url(assigns(:event)) }
  end

  describe 'GET /services/:service_id/events/:id/edit' do
    let(:event) { create(:event, service: service) }
    before { get 'edit', service_id: service.uuid, id: event.uuid }

    it { should respond_with(:ok) }
    it { should render_template(:edit) }
  end

  describe 'PUT /events/:id' do
    let(:event) { create(:event, service: service) }
    before { put :update, id: event.uuid, event: attributes_for(:event) }

    it { should respond_with(:found) }
    it { should redirect_to event_url(event) }
    it { should assign_to(:event) }
  end

  describe 'DELETE /events/:id' do
    let(:event) { create(:event, service: service) }
    before { delete :destroy, id: event.uuid }

    it { should respond_with(:found) }
    it { should redirect_to service_events_url(service) }
  end

end
