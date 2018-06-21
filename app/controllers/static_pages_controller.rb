class StaticPagesController < ApplicationController
layout "_landing", only: [:landing, :home]

  def home
  end

  def help
  end

  def about
  end

  def landing
  end
end
