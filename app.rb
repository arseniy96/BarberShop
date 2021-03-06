#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

get '/about' do
  erb :about
end

get '/visit' do
  erb :visit
end

get '/feedback' do
  erb :feedback
end

get '/contacts' do
  erb :contacts
end

get '/entry' do
  erb :entry
end

get '/admin' do
  @users = File.open("./public/users.txt","r")
  erb :admin
end

post '/visit' do
  @user_name = params[:user_name]
  @phone = params[:phone]
  @date_time = params[:date_time]
  @hairdresser = params[:hairdresser]
  @color = params[:color]

  if @user_name == '' or @phone == '' or @date_time == ''
    @error = 'Не все поля заполнены'
    erb :visit
  else

    @message = "Спасибо, #{@user_name}. Вы записаны на #{@date_time} к парикмахеру #{@hairdresser}"

    f = File.open("./public/users.txt","a")
    f.write "User: #{@user_name}, Phone: #{@phone}, Date: #{@date_time}, Hairdresser: #{@hairdresser}, Color: #{@color} \n"
    f.close

    erb @message
  end
end

post '/feedback' do
  @email = params[:email]
  @mes = params[:mes]

  if @email == '' or @mes == ''
    @error = 'Не все поля заполнены'
    erb :feedback
  else

    @fil = File.open("./public/message.txt", "a")
    @fil.write "Email: #{@email}, message: #{@mes}\n"
    @fil.close

    erb "Спасибо за сообщение!"
  end
end

post '/entry' do
  @login = params[:login]
  @password = params[:password]

  if @login == 'admin' && @password == 'admin'
    redirect '/admin'
  else
    erb "Access denied"
  end
end
