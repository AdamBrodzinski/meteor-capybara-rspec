describe "Default Meteor App" do

  before(:each) do
    # tcfg.yml config is set to localhost:3000 using Chrome
    visit('/')
  end

  #this test should pass
  it "should have correct heading", tag('Smoke') do
    expect(page).to have_content("Welcome to Meteor!")
  end

  # this test should pass
  it "should respond to a click" do
    click_on "Click Me"
    click_on "Click Me"
    expect(page).to have_content("You've pressed the button 2 times")
  end

  # this is failing, make me pass!
  it "should have Testing Meteor in body" do
    expect(page).to have_content("Testing Meteor!")
  end

end

