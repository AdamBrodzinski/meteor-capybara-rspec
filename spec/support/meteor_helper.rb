module MeteorHelpers
  # return the Meteor user id
  def user_id
    evaluate_script("Meteor.userId();")
  end  

  # logout Meteor user if logged in
  def logout_user
    execute_script("Meteor.logout();")
  end

  # uses Iron Router navigation instead of a complete refresh
  def go_to_url(url)
    evaluate_script("Router.go('#{url}')")
  end     

  # use path IronRouter route name, 'editPost' instead of '/posts/edit/'
  def go_to_route(route_name)
    evaluate_script("Router.go('#{route_name}')")
  end     

  # login user using Accounts UI (not tested with Bootstrap)
  def login_user
    logout_user() #make sure we're not already logged in from prev test

    find('#login-sign-in-link').click

    fill_in "Email", with: "foo@bar.com"
    fill_in "Password", with: "password"

    find('#login-buttons-password').click
  end             
end


#following config allows us to simply call the helpers from within our examples
RSpec.configure do |config|
  config.include MeteorHelpers
end

