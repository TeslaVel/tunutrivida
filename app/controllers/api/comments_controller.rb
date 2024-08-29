# class Api::CommentsController < Api::ApiController
#   def create
#     entry = Entry.find(comments_params[:entry_id])
#     return unless entry

#     comment = entry.comments.build(comments_params)

#     if comment.save
#       # CommentNotification.create!(
#       #   notification_type: 'CommentNotification',
#       #   content: "#{current_user.full_name} has sent you a comment" ,
#       #   sender_id: current_user.id,
#       #   associated_object_type: 'Comment',
#       #   associated_object_id: comment.id,
#       #   recipient_id: current_user.dietitian.id
#       # )

#       render json: comment
#     else
#       render json: comment.errors, status: :unprocessable_entity
#     end
#   end

#   private

#   def comments_params
#     params.permit(:entry_id, :message).merge(user_id: current_user.id)
#   end
# end
