#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
  end

get "/about" do
    erb :about  #podkluczenie fila HTML
  end

get "/visit" do
    erb :visit  #podkluczenie fila HTML
  end
