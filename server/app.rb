require 'bundler'
Bundler.require

get "/users/sign_in" do
  content_type :json
  if params[:login] == "car" && params[:password] == "black"
    { success: "Ура вы успешно вошли в систему!" }.to_json
  else
    status 401
    body({ error: "Вы указали неверный логин или пароль!"}.to_json)
  end
end