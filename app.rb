require("bundler/setup")
require('pry')
require("sinatra/activerecord")
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
Bundler.require(:default)
also_reload("lib/**/*.rb")

#enable sessions
enable :sessions

#route to index
get("/") do
  @users = User.all
  @people = Person.all
  @companies = Company.all
  erb(:index)
end

#get people according to their id
get('/people/:id') do
  @person = Person.find(params.fetch('id').to_i)
  erb(:person)
end

#update details of the person according to his/her id
patch('/people/:id') do
  @person = Person.find(params.fetch("id").to_i)
  @person.update(first_name: params.fetch("first_name"), last_name: params.fetch("last_name"), phone: params.fetch("phone"), email: params.fetch("email"), note: params.fetch("note"))
  erb(:person)
end

#delete a person according to his/her id
delete('/people/:id') do
  @person = Person.find(params.fetch("id").to_i)
  @person.destroy
  redirect('/')
end

#post companies' details
post('/companies') do
  name = params.fetch("name")
  phone = params.fetch("phone")
  email = params.fetch("email")
  note = params.fetch("note")
  @company = Company.new(name: name, phone: phone, email: email, note: note)
  @company.save
  erb(:company)
end

#get company according to its id
get('/companies/:id') do
  @company = Company.find(params.fetch('id').to_i)
  erb(:company)
end

#update company details according to its id
patch('/companies/:id') do
  @company = Company.find(params.fetch("id").to_i)
  @company.update(name: params.fetch("name"), phone: params.fetch("phone"), email: params.fetch("email"), note: params.fetch("note"))
  erb(:company)
end

#delete a comapany according to its id
delete('/companies/:id') do
  @company = Company.find(params.fetch("id").to_i)
  @company.destroy
  redirect('/')
end

#renders a success.erb page, which should be displayed once a user successfully logs in
get('/success') do
  erb(:success)
end

#renders a form to create a new user. The form includes fields for username and password
get('/signup') do
  erb(:signup)
end

#renders a form for logging in
get('/login') do
  erb(:login)
end

#renders a failure.erb page. This will be accessed if there is an error logging in or signing up.
get('/failure') do
  erb(:failure)
end

#post sign up details from form
post "/signup" do
  user = User.new(username: params.fetch("username"), password: params.fetch("password"))
  if user.save
    redirect "/login"
  else
    redirect "/failure"
  end
end

#get request to dashboard
get('/dashboard') do
  @user = User.find(session[:id])
  @people = Person.all
  @companies = Company.all
  erb(:dashboard)
end

#post to dashboard when new-client is added
post("/dashboard/new_client") do
  user =User.find(session[:id])
  @person =Person.new(user_id: user.id ,first_name: params.fetch("first_name"), last_name: params.fetch("last_name"), phone: params.fetch("phone"), email: params.fetch("email"))
  @person.save
  redirect "/dashboard"
end

#get the dashboard with all new clients.people
get("/dashboard/new_client") do
  @people = Person.all
  erb(:dashboard)
end

#post to dashboard when new-company is added
post("/dashboard/new_company") do
  user =User.find(session[:id])
  @company =Company.new(user_id:user.id,name: params.fetch("name"), phone: params.fetch("phone"), email: params.fetch("email"))
  @company.save
  redirect "/dashboard"
end

#get the dashboard when a new-company is added
get("/dashboard/new_company") do
  @company = Company.all
  erb(:dashboard)
end

#post login to check/authenticate users details
post "/dashboard" do
  user = User.find_by(:username => params[:username])
  if user && user.authenticate(params[:password])
    session[:id] = user.id
    redirect "/dashboard"
  else
    redirect "/failure"
  end
end

#clears the session data and redirects to the homepage
#handle logout of a user and redirects to root/home
get '/logout' do
  session.clear
  redirect "/"
end


get '/about' do
  erb(:about)
end

get '/contact' do
  erb(:contact)
end


#route to support page
get ('/support') do
  erb:support
end

#route to features page
get ('/features') do
  erb:features

end

get '/about' do
  erb(:about)
end
