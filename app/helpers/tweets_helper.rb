module TweetsHelper
	def can_user_edit?(user)
		current_user == user
    end
end
