require "rails_helper"

# edit order using same form used for new orders
# edited order should appear as modified on the index page

feature "user edits wing order" do
  let!(:honey_bbq_flavor) { Flavor.create(name: "Honey BBQ") }
  let!(:sweet_chili_flavor) { Flavor.create(name: "Sweet Chili") }
  let!(:bbq_flavor) { Flavor.create(name: "BBQ") }
  let!(:buffalo_flavor) { Flavor.create(name: "Buffalo") }

  scenario "successfully orders wings" do
    visit new_wing_order_path
    new_name = Time.now
    fill_in "Full Name", with: new_name
    fill_in "City", with: "Boston"
    select "Massachusetts", from: "State"
    choose "100 wings"
    check "Add Ranch Dressing"
    check "Honey BBQ"
    check "Sweet Chili"
    check "BBQ"
    check "Buffalo"
    click_button "Place Order"

    expect(page).to have_content(new_name)
    expect(page).to have_content("Boston")
    expect(page).to have_content("MA")
    expect(page).to have_content("100")
    expect(page).to have_content("Ranch")
    expect(page).to have_content("Honey BBQ")
    expect(page).to have_content("Sweet Chili")
    expect(page).to have_content("BBQ")
    expect(page).to have_content("Buffalo")

    click_link(new_name)
    uncheck "Honey BBQ"
    click_button "Place Order"
    expect(page).to have_content("Sweet Chili BBQ Buffalo")
  end
end
