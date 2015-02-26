class CommentsController < ApplicationController
    before_action :set_comment, only: [:show, :edit, :update, :destroy]

    # GET /comments
    # GET /comments.json
    def index
      @comments = Comment.find(params[:id])
    end

    # GET /comments/1
    # GET /comments/1.json
    def show
      @comments = Comment.find(current_user.id)
    end

    def comments

    end

    # GET /comments/new
    def new
      @comments = Comment.where(packets_id: params[:id])
      #@comments = Comment.find_by_sql('Select * FROM comments where packets_id = ?')
    end

    # GET /comments/1/edit
    def edit
    end

    # POST /comments
    # POST /comments.json
    def create
      @comments = Comment.new(:packets_id => params[:comment][:packets_id], :comment => params[:comment][:comment], :users_id => current_user.id)
      if params[:commit] == 'Kommentar erstellen'
        respond_to do |format|
          if @comments.save
              format.html {
                redirect_to :controller => 'comments', :action => 'new', :id => @comments.packets_id, :flash => { :success => "Comment_created" } }
              format.json { render :show, status: :created, location: @comment }
            else
              format.html { render :new }
              format.json { render json: @comment.errors, status: :unprocessable_entity }
            end
        end
      elsif params[:commit] == 'Zurück'
        @packets = Packet.find(@comments.packets_id)
        @packets.status = :task
        redirect_to :controller => 'packets', :action => 'dashboard', :id => @packets.projects_id, :flash => { :success => "got_back_safely" }
      elsif params[:commit] == 'Fehler zurücksetzen'
        @packets = Packet.find(@comments.packets_id)
        @packets.status = :task
        if @packets.save
          @commentsDestroy = Comment.destroy_all(:packets_id => @comments.packets_id)
          redirect_to :controller => 'packets', :action => 'dashboard', :id => @packets.projects_id, :flash => { :success => "got_back_safely" }
        end
      end
    end


    # PATCH/PUT /comments/1
    # PATCH/PUT /comments/1.json
    def update
      respond_to do |format|
        if @comment.update(comment_params)
          format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
          format.json { render :show, status: :ok, location: @comment }
        else
          format.html { render :edit }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /comments/1
    # DELETE /comments/1.json
    def destroy
      @comment.destroy
      respond_to do |format|
        format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit( :id, :comment, :packets_id)
    end
end
