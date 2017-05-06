require 'rails_helper'

describe CategoriesController do
  describe '#index' do
    it 'returns 200' do
      get :index
      expect(response.status).to be 200
    end
  end

  describe '#new' do
    it 'returns 200' do
      get :new
      expect(response.status).to be 200
    end
  end

  describe '#create' do

    context 'when params are valid' do
      let(:valid_params) {{ category: { name: 'name' }}}
      ##temat
      subject{ post :create, params: valid_params }

      it 'returns 302' do
        subject
        expect(response.status).to be 302
      end

      it 'creates a category when name is present' do
        expect{ subject }.to change { Category.count }.by(1)
      end
    end

    context 'when params are NOT valid' do
      let(:invalid_params) {{ category: { name: '' }}}
      subject{ post :create, params: invalid_params }

      it 'does NOT create category when name is not validate' do
        params = { category: { name: '' }}
        expect{ subject }.not_to change { Category.count }
      end

      xit 'does NOT create category when name is NOT uniqueness' do
        post :create, params: { category: { name: 'testowo' }}
        expect(response.status).to be 200
      end
    end
  end

  describe '#show' do
    let(:category) { Category.create(name: 'test') }
    it 'returns 200' do
      get :show, params: {id: category.id}
      expect(response.status).to be 200
    end
  end

end
