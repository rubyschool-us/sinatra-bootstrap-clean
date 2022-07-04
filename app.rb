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

get "/contacts" do
    erb :contacts  #podkluczenie fila HTML
  end

post "/" do
    @name = params[:aaa]  #Peredacza i cztenie parametra s HTML "Fail <layout.erb>"
    @phone = params[:bbb]
    @adres = params[:ccc]

    @titel = "Thanks!"                         #Ispolzowanie peremennych s fila "message"
    @message = "Thanks #{@name}! Your phone:#{@phone}, Your adres:#{@adres}."
     
    f = File.open "./public/users.txt","a+"       #Otkrytie fila i sozdanie fila "./public/"
    f.write "User:#{@name}, Phone:#{@phone}, Your Adres:#{@adres}.\n"
    f.close
    erb :message    
  
    end