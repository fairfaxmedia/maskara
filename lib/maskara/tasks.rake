require 'maskara/generator'

namespace :maskara do

  desc 'Generate a default maskara data file based on the existing controllers'
  task :generate => :environment do
    Maskara::Generator.run
  end

end
