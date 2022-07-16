Pony.mail({:to => "nenashev@yahoo.com",
                                   
    :subject => 'BarberShop', :body => "#{params[:aaa]}", :attachments => "#{f}", 
    
    :via => :smtp, 
    :via_options => {
    :address        => 'smtp.mail.yahoo.com',
    :port           => '587',
    :tls            => :true,
    :user_name      => 'nenashev@yahoo.com',
    :password       => 'zxcxpoqbwclqqyza',
    :authentication => :plain,
    :domain         => 'http://localhost:4567/'
    }
    })



    Pony.mail(:from => "nenashev@yahoo.com",:to => "maksym.nenashev@gmail.com",
                                   
        :subject => 'BarberShop', :html_body => '<h1>Hello there!</h1>', 
        
        :via => :smtp, 
        :via_options => {
        :address        => 'smtp.mail.yahoo.com',
        :port           =>  587,
        :user_name      => 'nenashev@yahoo.com',
        :password       => 'zxcxpoqbwclqqyza',
        :authentication => :plain,
        :domain         => 'http://localhost:4567/'
        })