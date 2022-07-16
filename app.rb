#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'pony'

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

get "/admin" do
    erb :admin
  end


post "/" do
    @name = params[:aaa]  #Peredacza i cztenie parametra s HTML "Fail <layout.erb>"
    @phone = params[:bbb]
    @adres = params[:ccc]
    @barber = params[:barber]
    @color = params[:color]
 #//////////////////////////////////////////////////////////////////////////////////////////////
    # hesh dla prowerki # хеш для валидации параметров
    hh = {:aaa => "Введите ваше имя",:bbb => "Введите ваш телефон",:ccc => "Введите вашу дату"}

    hh.each do  |key,value| 
       if params[key] == "" #esli parametr pust peremennoj "@error" priswoit value iz hesha
          @error = hh[key]
          return erb :visit
     end
   end                      #2 wariant
   #@error = hh.select {|key,_| params[key] == ''}.values.join(", ")
   #if @error != ''
   # return erb :index
   #end
#///////////////////////////////////////////////////////////////////////////////////////
    @titel = "Thanks!"                         #Ispolzowanie peremennych s fila "message"
    @message = "Thanks #{@name}! Your phone:#{@phone}, Your adres:#{@adres}, 
    Your barber:#{@barber},Your color:#{@color}."
               #./public/
    f = File.open "./public/users.txt","a+"    #Otkrytie fila i sozdanie fila "./public/"
    f.write "User:#{@name},Phone:#{@phone},Your Adres:#{@adres},Your barber:#{@barber},Your color:#{@color}\n"
    f.close
     
      erb :message
  end    
  
    # Добавить зону /admin где по паролю будет выдаваться список тех, кто записался (из users.txt)
    
    post "/admin" do
      @login = params[:login]
      @password = params[:password]
    
      # проверим логин и пароль, и пускаем внутрь или нет:
     if @login == "admin" && @password == "anna"
        @file = File.open "./public/users.txt","r+"  #Otkrytie fila i sozdanie fila "./public/"
        erb :watch_result
        #@file.close #- должно быть, но тогда не работает. указал в erb
      else
        @report = '<p>Доступ запрещён! Неправильный логин или пароль.</p>'
        erb :admin
      end
    end
   
   post "/" do
    
    end