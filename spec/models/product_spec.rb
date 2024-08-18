require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    
    before do
      @category = Category.create(name: "Succulents")
      @product = Product.new(
        name: "Test Product", 
        price_cents: 1000, 
        quantity: 5, 
        category: @category
        )
    end

    it 'saves successfully with all four fields set' do
      expect(@product).to be_valid
    end

    it 'does not validate without a name' do
      @product.name = nil
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'does not validate without a price' do
      @product.price_cents = nil
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it 'does not validate without a quantity' do
      @product.quantity = nil
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'does not validate without a category' do
      @product.category = nil
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end

  end
end
