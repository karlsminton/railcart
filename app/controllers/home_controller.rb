# frozen_string_literal: true

require 'uuid'

# class HomeController handles root route
class HomeController < ApplicationController
  def index
    @data = session.to_hash.to_s
  end
end
