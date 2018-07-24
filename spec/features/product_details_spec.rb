require 'rails_helper'

RSpec.feature "Product Details", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

      @product = @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
      
  end

  scenario "They see all products" do

    visit "/products/#{@product.id}"



    # commented out b/c it's for debugging only
    save_and_open_screenshot
    # save_screenshot

    expect(page).to have_css 'section.products-show', count: 1
  end

end

# Tips:
# You should just run the single feature and not previous ones, since feature specs, especially those using a real browser, are slow to run.
# You will need to use the javascript-enabled (ie real) browser by specifying js: true in the feature declaration (see home page feature)
# Use screenshots to debug
# You can also use puts page.html to output the current HTML being rendered by our browser
# Use the reference documents provided in the previous activity
