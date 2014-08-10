#This is a place to put simple helper functions that don't keep any state

require 'securerandom'

module GeneralTestHelpers

  #random strings come in handy in most every test suite
  def random_string length=32
    SecureRandom.hex(length/2).to_s.force_encoding('utf-8')
  end

  def runJS(statement)
    evaluate_script(statement)
  end    

  def root_path
    '/'
  end       

end

#and the following config allows us to simply call the helpers
#from within our RSpec examples
RSpec.configure do |config|
  config.include GeneralTestHelpers
end

# allow user to use a JavaScript like notation for accessing object from the
# RunJS return value. 
#
# Example: 
#   foo = RunJS("{bar: 'baz'})
#   foo.bar == 'baz'
#   # or without helper... 
#   foo['bar'] == 'baz'
#
class Hash
  def method_missing(method, *opts)
    m = method.to_s
    if self.has_key?(m)
      return self[m]
    elsif self.has_key?(m.to_sym)
      return self[m.to_sym]
    end
    super
  end
end

