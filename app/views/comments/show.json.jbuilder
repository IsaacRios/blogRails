json.extract! @comment, :id, :user:id, :article_id, :body, :create_at, :update_at
json.user do
	json.email @comment.user.email
end