# Maskara

Maskara is designed to take the pain out of frontend development (primarily for Rails, but it tries to be platform agnostic.)

It encourages developers and frontend designers to collaboratively mock out actions with fixture data, and then to use special URLs to access those actions - this allows easier testing of heavy (or incomplete) actions, and quick prototyping, with the entire Rails view stack still available.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'maskara'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install maskara


## Usage

Generate a default YAML fixture file with the rake command:

```
rake maskara:generate
```

(The file defaults to RAILS_ROOT/db/fixtures/maskara.yml )

Edit the file with information about the objects your template needs (and filters you wish to disable) and then prepend `/maskara/` to the path you'd normally use to access the view: eg.

```http://localhost:3000/member/edit/1```

would become...

```http://localhost:3000/maskara/member/edit/1```

Instead of running the controller action, the data form the fixture file should be loaded into the controller and a normal render call executed.


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://bitbucket.org/simon_hildebrandt/maskara.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
