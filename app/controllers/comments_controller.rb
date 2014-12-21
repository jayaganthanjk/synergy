class CommentsController < ApplicationController

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)
    @owner = find_owner
    respond_to do |format|
      if @comment.save
        if @owner.class.to_s == 'Story'
          activity = @comment.create_activity :create, owner: current_user, recipient: Project.find(@comment.owner.project_id)
          @notif = Notification.new
          @notif.notifs_create(@comment, activity.id) 
          format.html { redirect_to :back, notice: 'Comment was successfully created.' }
        else
          activity = @comment.create_activity :create, owner: current_user, recipient: Project.find(@comment.owner.story.project_id)
          @notif = Notification.new
          @notif.notifs_create(@comment, activity.id) 
          format.html { redirect_to :back, notice: 'Comment was successfully created.' }
        end
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end



  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:content, :owner_id, :owner_type, :user_id)
    end

    def find_owner
      case  params[:comment][:owner_type]
        when 'Story' 
          return Story.find params[:comment][:owner_id]
        when 'Bug' 
          return Bug.find params[:comment][:owner_id]
      end
    end
end
