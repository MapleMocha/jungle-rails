require 'rails_helper'

RSpec.describe Product, type: :model do
    # validation tests/examples here
    describe 'Validations' do


      it 'product should be exist when filled out properly' do
        @category = Category.create! name: 'Outdoor Gear'
        @product = @category.products.create({
            name:  'Men\'s Classy shirt',
            price: 64.99,
            quantity: 0
          })
          expect(@product).to be_present
      end

      it 'should not be created without a name' do
        @category = Category.create! name: 'Outdoor Gear'
        @product = @category.products.new({
            price: 64.99,
            quantity: 0
          })
        @product.save
        expect(@product.errors.full_messages).to include("Name can't be blank")
      end

      it 'should not be created without a quantity' do
        @category = Category.create! name: 'Outdoor Gear'
        @product = @category.products.create({
            name:  'Men\'s Classy shirt',
            price: 64.99,
          })
        expect(@product.errors.full_messages).to include("Quantity can't be blank")
      end

      it 'price should be present' do
        @category = Category.create! name: 'Outdoor Gear'
        @product = @category.products.create({
            name:  'Men\'s Classy shirt',
            quantity: 0
          })
        expect(@product.errors.full_messages).to include("Price can't be blank")
      end

      it 'category should be present' do
        @product = Product.create({
            name:  'Men\'s Classy shirt',
            price: 64.99,
            quantity: 0
          })
        expect(@product.errors.full_messages).to include("Category can't be blank")
      end


    end
end

# Create an initial example that ensures that a product with all four fields set will indeed save successfully
# Have one example for each validation, and for each of these:
# Set all fields to a value but the validation field being tested to nil
# Test that the expect error is found within the .errors.full_messages array
# You should therefore have five examples defined given that you have the four validations above



# require 'rails_helper'
#
# describe '#id' do
#   it 'should not exist for new records' do
#     @widget = Widget.new
#     expect(@widget.id).to be_present
#   end
#
#   it 'should be auto-assigned by AR for saved records' do
#     @widget = Widget.new
#     # we use bang here b/c we want our spec to fail if save fails (due to validations)
#     # we are not testing for successful save so we have to assume it will be successful
#     @widget.save!
#
#     expect(@widget.id).to be_present
#   end
# end
