class CommentMailer < ActionMailer::Base

  default :from => ArchiveConfig.RETURN_ADDRESS

  # Sends email to an owner of the top-level commentable when a new comment is created
  def comment_notification(user, comment)
    @comment = comment
    mail(
      :to => user.email,
      :subject => "[#{ArchiveConfig.APP_NAME}] Comment on " + comment.ultimate_parent.commentable_name
    )
  end

  # Sends email to an owner of the top-level commentable when a comment is edited
  def edited_comment_notification(user, comment)
    @comment = comment
    mail(
      :to => user.email,
      :subject => "[#{ArchiveConfig.APP_NAME}] Edited comment on " + comment.ultimate_parent.commentable_name
    )
  end

  # Sends email to commenter when a reply is posted to their comment
  # This may be a non-user of the archive
  def comment_reply_notification(your_comment, comment)
    @your_comment = your_comment
    @comment = comment
    mail(
      :to => your_comment.comment_owner_email,
      :subject => "[#{ArchiveConfig.APP_NAME}] Reply to your comment on " + @comment.ultimate_parent.commentable_name
    )
  end
   
  # Sends email to commenter when a reply to their comment is edited
  # This may be a non-user of the archive
  def edited_comment_reply_notification(your_comment, edited_comment)
    @your_comment = your_comment
    @comment = edited_comment
    mail(
      :to => your_comment.comment_owner_email,
      :subject => "[#{ArchiveConfig.APP_NAME}] Edited reply to your comment on " + @comment.ultimate_parent.commentable_name
    )
  end

  # Sends email to the poster of a comment 
  def comment_sent_notification(comment)
    @comment = comment
    @noreply = true # don't give reply link to your own comment
    mail(
      :to => comment.email,
      :subject => "[#{ArchiveConfig.APP_NAME}] Comment you sent on " + @comment.ultimate_parent.commentable_name
    )
  end
   
end
