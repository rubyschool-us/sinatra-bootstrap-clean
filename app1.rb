#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'pony'
require 'sqlite3'
                   #Sozdanie bazy
#////////////////////////////////////////////////////////////////////////////////
def is_barber_exists? db,name
  db.execute('select * from Barbers where name=?',[name]).length > 0
  end

def seed_db db, barbers
  barbers.each do |barber|
  if !is_barber_exists? db, barber
      db.execute 'INSERT INTO Barbers (name) VALUES (?)', [barber]
   end
  end
 end          

def get_db
  db = SQLite3::Database.new 'test.sqlite'
  db.results_as_hash = true
   return db
 end

configure do
  db = get_db
  db.execute 'CREATE TABLE IF NOT EXISTS "Messages"
    (
      "id" INTEGER PRIMARY KEY AUTOINCREMENT,
      "name" TEXT,
      "phone" TEXT,
      "adres" TEXT,
      "barber" TEXT,
      "color" TEXT
      )'
  
             #Sozdanie SQL dla parikmahera
  db.execute 'CREATE TABLE IF NOT EXISTS "Barbers"
    (
      "id" INTEGER PRIMARY KEY AUTOINCREMENT,
      "name" TEXT
      )'
    seed_db db, ["Петя","Оля","Дуся"]
  #db.close
  end
                     #Zapis w bazu
def save_form_data_to_database
  db = get_db
  db.execute 'INSERT INTO Messages (name, phone, adres, barber, color)
  VALUES (?, ?, ?, ?, ?)', [@name,@phone,@adres,@barber,@color]
  db.close
 end      
                       #Read SQL
def read_sql
  db = get_db
  @results = db.execute 'SELECT * FROM Messages ORDER BY id DESC'
  db.close
 end
 
 before do          #Read SQL kak 2 wariant
  db = get_db
  @barbers = db.execute 'Select * from Barbers'
 end
#/////////////////////////////////////////////////////////////////////////////////

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

get "/watch_result" do
    read_sql
    erb :watch_result
  end
  
post "/" do
    @name = params[:aaa]  #Peredacza i cztenie parametra s HTML "Fail <layout.erb>"
    @phone = params[:bbb]
    @adres = params[:datetime]
    @barber = params[:barber]
    @color = params[:color]
 #//////////////////////////////////////////////////////////////////////////////////////////////
    # hesh dla prowerki # хеш для валидации параметров
    hh = {:aaa => "Введите ваше имя",:bbb => "Введите ваш телефон",:datetime => "Введите вашу дату"}

    hh.each do  |key,value| 
       if params[key] == "" #esli parametr pust peremennoj "@error" priswoit value iz hesha
          @error = hh[key]
          return erb :visit
      end
    end
                           #2 wariant
   #@error = hh.select do {|key,_| params[key] == ''}.values.join(", ")
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
    save_form_data_to_database
      erb :message
  end    
  
    # Добавить зону /admin где по паролю будет выдаваться список тех, кто записался (из users.txt)
    
post "/admin" do
    @login = params[:login]
    @password = params[:password]
    
      # проверим логин и пароль, и пускаем внутрь или нет:
     if @login == "admin" && @password == "anna"
        @file = File.open "./public/users.txt","r+"  #Otkrytie fila i sozdanie fila "./public/"
        read_sql #podkluchenie SQL i cztenie
        erb :watch_result
        #@file.close #- должно быть, но тогда не работает. указал в erb
      else
        @report = '<p>Доступ запрещён! Неправильный логин или пароль.</p>'
        erb :admin
      end
    end
  
    
   