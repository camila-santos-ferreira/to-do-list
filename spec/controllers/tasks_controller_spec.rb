require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  describe 'GET index' do
    let!(:first_task) { create(:task) }
    let!(:second_task) { create(:task) }

    it 'assigns @tasks' do
      get :index
      expect(assigns(:tasks)).to eq([first_task, second_task])
    end

    it 'returns a 200 http status' do
      get :index
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end
end
