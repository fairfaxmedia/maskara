class HomeController < ApplicationController
  before_filter :polluter
  #skip_filter :polluter, if: :maskara_request?

  def root
    raise
  end

  def main
  end

  private

  def polluter
    raise
  end
end
