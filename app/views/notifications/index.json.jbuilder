json.array! @notifications do |notification|
	json.actor notification.actor.name unless !notification.actor.name
	json.action notification.action
	json.read notification.read
	if notification.notifiable_type == "Wad"
		json.notifiable do
			json.type "on your #{notification.notifiable.class.to_s.underscore.humanize.downcase}"
		end
		json.url wad_comments_path(notification.notifiable, anchor: dom_id(notification.notifiable))
	elsif notification.notifiable_type == "Discussion"
		json.notifiable do
			json.type "your #{notification.notifiable.class.to_s.underscore.humanize.downcase}"
		end
		json.url discussion_answers_path(notification.notifiable, anchor: dom_id(notification.notifiable))
	elsif notification.notifiable_type == "Comment"
		json.notifiable do
			json.type "your #{notification.notifiable.class.to_s.underscore.humanize.downcase}"
		end
		json.url wad_comments_path(notification.notifiable.wad)
	elsif notification.notifiable_type == "Message"
		json.notifiable do
			json.type "a #{notification.notifiable.class.to_s.underscore.humanize.downcase}"
		end
		json.url conversations_path(conversation_id: notification.notifiable.conversation.id)
	end
end
