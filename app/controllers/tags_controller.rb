class TagsController < ApplicationController

  # GET /tags
  # GET /tags.json
  def index
    @tags = Tag.all
    render json: @tags.map { |t| t.to_tree }
  end

  # GET /tags/1
  # GET /tags/1.json
  def show
    logger.info params[:id]
    @tags = Tag.where(:id => params[:id])
 
    render json: @tags.map { |t| t.to_tree }
  end

  def topics
    @topics=Tag.where(:parent_id => nil, :custom => false).sort_by { |x| x.name }

    render json: @topics.map { |t| t.to_tree }
  end

  def posts
    @posts = Tag.find(params[:id]).posts

    render json: @posts, :include => [:author, :user, :tags]
  end


  # POST /tags
  # POST /tags.json
  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      render json: @tag, status: :created, location: @tag
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tags/1
  # PATCH/PUT /tags/1.json
  def update
    @tag = Tag.find(params[:id])

    if @tag.update(tag_params)
      head :no_content
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.json
  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy

    head :no_content
  end

  private
    
    def tag_params
      params[:tag]
    end
end
