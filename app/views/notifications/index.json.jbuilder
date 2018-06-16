json.array! @notifications do |notification|
	json.actor notification.actor.name
	json.action notification.action
	json.notifiable do #notification.notifiable
		json.type "on your #{notification.notifiable.class.to_s.underscore.humanize.downcase}"
	end 
	json.url wad_comments_path(notification.notifiable, anchor: dom_id(notification.notifiable))
end