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

  describe 'GET show' do
    let!(:task) { create(:task) }

    it 'assigns @task' do
      get :show, params: { id: task.id }
      expect(assigns(:task)).to eq(task)
    end

    it 'returns a 200 http status' do
      get :show, params: { id: task.id }
      expect(response).to have_http_status(200)
    end

    it 'renders the show template' do
      get :show, params: { id: task.id }
      expect(response).to render_template(:show)
    end

    context 'when the task is not found' do
      it 'redirects to root path' do
        get :show, params: { id: 123456 }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'GET new' do
    it 'returns a 200 http status' do
      get :new
      expect(response).to have_http_status(200)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST create' do
    task_params = { name: 'Test create method' }

    it 'creates task' do
      post :create, params: { task: task_params }
      expect(Task.last).to have_attributes(
        name: 'Test create method',
        status: 'pending'
      )
    end

    it 'redirects to root path' do
      post :create, params: { task: task_params }
      expect(response).to redirect_to(root_path)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    context 'when the task name is not valid' do
      it 'renders the new template' do
        post :create, params: { task: { name: nil } }
        expect(response).to render_template(:new)
      end
    end
  end
end
