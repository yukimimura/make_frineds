class HomeController < ApplicationController
  def top
    @post = Post.find(20)
  end
end
