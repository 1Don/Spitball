class Notifications
    constructor: ->
        @notifications = $("[data-behavior='notifications']")
        @setup() if @notifications.length > 0 

    setup: -> 

        $.ajax(
            url: "/notifications.json"
            dataType: "JSON"
            method: "GET"
            success: @handleSuccess
        )

    handleSuccess: (data) =>
       console.log(data) 
       items = $.map data, (notification) ->
            "<a onclick='sendPost()' class='dropdown-item' href='#{notification.url}'>#{notification.actor} #{notification.action} #{notification.notifiable.type}</a>"
        console.log(items)

        $("[data-behavior='notification-items']").prepend(items)
        $("[data-behavior='unread-count']").text(items.length)
        if items.length is 0
            $("[data-behavior='unread-count']").text("")               

$(document).on('turbolinks:load', -> new Notifications)