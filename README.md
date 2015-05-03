# Capybara for Meteor

When building Blonk I needed a robust framework to test my Meteor apps while the current Meteor specific frameworks were maturing. Meteor-Rspec-Capybara allows you to run all of your acceptance tests using Ruby, RSpec, and Capybara. It also includes a few Meteor helpers to make life easy.

You can execute JavaScript and return values as needed with the `runJS` command. This allows you to check the state of the app without completely relying on the UI selectors.

<br>
## Installation

0. Download the zip file from repo
0. Unzip/move folder into your Meteor app `/tests` directory
0. Rename folder to `acceptance` or something meaningful
0. `$ cd acceptance`
0. `$ bundle install`  (you may need to install bundle with `gem install bundle`)
0. `$ ./setup_drivers.sh` to setup phantomjs & Chrome drivers

<br>
## Usage (using default meteor app)

0. `meteor create test-app`
0. `cd test-app`
0. `mkdir -p tests/capybara`
0. copy contents of repo into capybara diretory
0. `$ cd tests/capybara`
0. `bundle install` - installs Ruby gems
0. `./setup_drivers.sh` - installs Chrome and PhantomJS
0. `bundle exec rspec` - runs boilerplate tests

The tests should have two passing and one failing if you haven't changed the default app. To add more tests just add them to the specs directory and adding spec on the end, ex: `yourthing_spec.rb`. You can run specific tests using `rpsec -e "show blog"`

<br>
### Acceptance Tests

```ruby

feature "Show Blog Post" do
  before(:each) { visit "/blog" }

  context "As a normal user" do
    # peek into the clientside using runJS
    scenario "I should see at least one post" do
      has_a_post = runJS "!! $('.post-item').length"
      has_a_post.should == true
    end

    scenario "I should see the full post if they click on title" do
      click_on "My First Blog Post"
      page.should have_content "Hello World"
    end
  end

  context "As an author/editor" do
    # should see an edit link ...
  end
end
```


### Execute and Return Meteor Code

Sometimes you just need more than the UI to verify something has happened. Using the `runJS` method executes the script and returns it's value.

```ruby
  user_logged_in = runJS("!!Meteor.user()")

  task_count = runJS "Tasks.find(...)"

  user_logged_in.should == true
  task_count.should == 3
```


<br>
## Notes

Currently working with latency compensation can bit a bit tricky. For now i'm using something like `sleep 0.2` to wait for the serverside to catch up (for example checking if a document is in the collection right after inserting it).

**Forked and based off of**  
[rschultheis](1)'s [rspec-capybara-starter](2)  

**ThoughtBot's Capybara Cheat Sheet:**  
https://learn.thoughtbot.com/test-driven-rails-resources/capybara.pdf


[1]: https://github.com/rschultheis
[2]: https://github.com/rschultheis/rspec_capybara_starter
