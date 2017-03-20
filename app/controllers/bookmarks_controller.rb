class BookmarksController < ApplicationController
  before_action :set_authorized_bookmark, only: [:show, :edit, :update, :destroy]
  before_action :authorize

  autocomplete :tag, :name, :class_name => 'ActsAsTaggableOn::Tag'

  def index
    @search = SearchTagged.(params[:q], current_user.id, Bookmark)
    @bookmark = Bookmark.new
  end

  def show
    redirect_to @bookmark.url
  end

  def edit
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.user = current_user

    respond_to do |format|
      if @bookmark.save
        format.html { redirect_to bookmarks_path, notice: 'Bookmark was successfully created.' }
        format.json { render :show, status: :created, location: @bookmark }
      else
        format.html {
          search = SearchTagged.(params[:q], current_user.id, Bookmark).result
          @bookmarks = search.records
          @scope = search.query.tag || "all"
          render :index
        }
        format.json { render json: @bookmark.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @bookmark.update(bookmark_params)
        format.html { redirect_to bookmarks_path, notice: 'Bookmark was successfully updated.' }
        format.json { render :show, status: :ok, location: @bookmark }
      else
        format.html { render :edit }
        format.json { render json: @bookmark.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @bookmark.destroy
    respond_to do |format|
      format.html { redirect_to bookmarks_url, notice: 'Bookmark was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_authorized_bookmark
      @bookmark = Bookmark.find(params[:id])
      redirect_to bookmarks_path, notice: "Not authorized to operate on this bookmark" unless current_user == @bookmark.user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bookmark_params
      params.require(:bookmark).permit(:url, :title, :notes, :tag_list)
    end

end
