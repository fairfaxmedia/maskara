require 'maskara/middleware'

describe Maskara::Middleware do

  let(:dummy_app) { double('Fake Middleware', call: true) }
  subject { described_class.new(dummy_app) }

  describe "doesn't mutate a normal request" do
    it "that doesn't mention maskara" do
      env = { 'PATH_INFO' => '/home?x=y' }
      expect(dummy_app).to receive(:call) {|args|
        expect(args).to include(env).and exclude('MASKARA_REQUEST')
      }
      subject.call(env)
    end

    it "that mentions maskara" do
      env = { 'PATH_INFO' => '/home/maskara/z?x=y' }
      expect(dummy_app).to receive(:call) {|args|
        expect(args).to include(env).and exclude('MASKARA_REQUEST')
      }

      subject.call(env)
    end
  end

  it "mutates a maskara request" do
    env = { 'PATH_INFO' => '/maskara/home?x=y' }
    expectation = env.merge('PATH_INFO' => '/home?x=y', 'MASKARA_REQUEST' => true)
    expect(dummy_app).to receive(:call).with(hash_including(expectation))
    subject.call(env)
  end

end
