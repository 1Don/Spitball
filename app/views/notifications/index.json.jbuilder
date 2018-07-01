json.array! @notifications do |notification|
	json.actor notification.actor.name
	json.action notification.action
	json.notifiable do #notification.notifiable
		json.type "on your #{notification.notifiable.class.to_s.underscore.humanize.downcase}"
	end 
	if notification.notifiable_type == "Wad"
		json.url wad_comments_path(notification.notifiable, anchor: dom_id(notification.notifiable))
	elsif notification.notifiable_type == "Discussion"
		json.url discussion_answers_path(notification.notifiable, anchor: dom_id(notification.notifiable))
	end	
end

