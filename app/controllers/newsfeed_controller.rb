class NewsfeedController < ApplicationController

  # TODO: Newsfeed endpoint here
  def index
    @news_feeds = Post.most_recent.paginate(page: params[:page], per_page: 50)
    p get_card_type(323232323235667)
  end
end
