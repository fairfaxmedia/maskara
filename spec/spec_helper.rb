$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'byebug'
require 'maskara'

RSpec::Matchers.define :exclude do |key|
  match do |hash|
    !hash.include?(key)
  end
end
