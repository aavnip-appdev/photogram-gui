class UsersController < ApplicationController
  def index
    matching_users = User.all
    @list_of_users = matching_users.order({:username => :asc})
    render({:template=> "user_templates/index.html.erb"})    
  end

  def show
    # "path_username"=>"anisa"
    url_username = params.fetch("path_username")

    matching_usernames = User.where({:username=> url_username})

    @the_user = matching_usernames.at(0)

    render({:template=> "user_templates/show.html.erb"}) 
  end

  def create
    # Parameters: {"query_username"=>"aavni", "path_username"=>":path_username"}

    input_username = params.fetch("query_username")
    a_new_user = User.new
    a_new_user.username = input_username
    a_new_user.save 
    
    # render({:template=> "user_templates/create.html.erb"})
    next_url = "/users/" + a_new_user.username
    redirect_to(next_url)
  end

  def update
    # Parameters: {"query_username"=>"dhruv 2", "modify_username"=>"dhruv"}
    original_username = params.fetch("modify_username")
    updated_username = params.fetch("query_username")
    matching_users = User.where({:username => original_username})
    the_user = matching_users.at(0)
    the_user.username = updated_username
    the_user.save

    next_url = "/users/" + the_user.username
    redirect_to(next_url)

  end

end