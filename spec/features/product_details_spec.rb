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


    visit root_path

    within('footer.actions') do
      click_on 'Details'
    end

    save_screenshot

    expect(page).to have_css 'section.products-show', count: 1
  end

end
