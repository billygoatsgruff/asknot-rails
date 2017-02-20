class AdminAuthorizationAdapter < ActiveAdmin::AuthorizationAdapter

  def authorized?(action, subject = nil)
    case subject
    when ActiveAdmin::Page
      true
    when normalized(Tweet)
      if (action == :update && subject.active) || action == :destroy || action == :activate
        user.admin_type != "submitter"
      else
        true
      end
    else
      user.admin_type == "full_admin"
    end
  end

  def is_tweet_subject(subject)
    subject.name == "Tweets" || subject.name == "New Tweet" || subject.name == "Dashboard"
  end

  def is_admin_namespace(subject)
    subject.namespace.name == :admin
  end

end