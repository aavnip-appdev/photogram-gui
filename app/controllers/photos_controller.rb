class PhotosController < ApplicationController
  def index
    matching_photos = Photo.all
    @list_of_photos = matching_photos.order({:created_at=> :desc})
    
    render({:template=> "/photo_templates/index.html.erb"})
  end

  def show
    #   Parameters: {"path_id"=>"717"}

    url_id = params.fetch("path_id")
    matching_photos = Photo.where({:id=> url_id})
    @the_photo =matching_photos.at(0)

    render({:template=>"/photo_templates/show.html.erb"})
  end

  def bye
    #   Parameters: {"deleted_id"=>"765"}
    the_id = params.fetch("deleted_id")
    matching_photos = Photo.where({:id=> the_id})
    the_photo = matching_photos.at(0)
    the_photo.destroy

    # render({:template=> "/photo_templates/bye.html.erb"})
    redirect_to("/photos")
  end

  def create
    # Parameters: {"query_image"=>"", "query_caption"=>"", "query_owner_id"=>""}
    # Parameters: {"query_image"=>"https://www.chicagobooth.edu/-/media/project/chicago-booth/why-booth/a-global-footprint/a-dynamic-influence-in-europose-the-middle-east-and-africa/chicago-booth-london-building-entrance.jpg?cx=0.58&cy=0.72&cw=940&ch=749&hash=BA83D00D9BE1FDAA565CB2B6B949C1D0", "query_caption"=>"Chicago Booth", "query_owner_id"=>"117"}

    input_image = params.fetch("query_image")
    input_caption = params.fetch("query_caption")
    input_owner_id = params.fetch("query_owner_id")

    a_new_photo = Photo.new
    a_new_photo.image = input_image
    a_new_photo.caption = input_caption
    a_new_photo.owner_id = input_owner_id

    a_new_photo.save

    # render({:template=> "/photo_templates/create.html.erb"})
    next_url = "/photos/" + a_new_photo.id.to_s
    redirect_to(next_url)
  end

  def update
    #  Parameters: {"query_image"=>"https://www.chicagobooth.edu/-/media/project/chicago-booth/why-booth/a-global-footprint/a-dynamic-influence-in-europose-the-middle-east-and-africa/chicago-booth-london-building-entrance.jpg?cx=0.58&cy=0.72&cw=940&ch=749&hash=BA83D00D9BE1FDAA565CB2B6B949C1D0", "query_caption"=>"Chicago Booth Updated\r\n", "modify_id"=>"951"}
    
    input_image = params.fetch("query_image")
    input_caption = params.fetch("query_caption") 
    
    the_id = params.fetch("modify_id")
    matching_photos = Photo.where({:id => the_id})
    the_photo = matching_photos.at(0)
    the_photo.image = input_image
    the_photo.caption = input_caption
    the_photo.save

    # render({:template=>"/photo_templates/update.html.erb"})
    next_url = "/photos/" + the_photo.id.to_s
    redirect_to(next_url)
  end

  def comment
    # Parameters: {"form_input_photo_id"=>"839", "form_input_author_id"=>"117", "form_input_comment"=>"testing"} 
    comment_photo_id = params.fetch("form_input_photo_id")
    comment_author_id = params.fetch("form_input_author_id")
    comment_text = params.fetch("form_input_comment")
    
    a_new_comment = Comment.new
    a_new_comment.photo_id = comment_photo_id
    a_new_comment.author_id = comment_author_id
    a_new_comment.body = comment_text
    a_new_comment.save

    # render({:template=>"/photo_templates/add_comment.html.erb"})
    next_url = "/photos/" + a_new_comment.photo_id.to_s
    redirect_to(next_url)

  end

end