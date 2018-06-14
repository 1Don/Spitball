json.array! @notifications do |notification|
	json.actor notification.actor
	json.action notification.action
	json.notifiable notification.notifiable
	json.url wad_comments_path(notification.notifiable.wad, anchor: dom_id(notification.notifiable))
end