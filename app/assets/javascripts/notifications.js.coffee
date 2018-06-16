class Notifications
    constructor: ->
        @notifications = $("[data-behavior='notifications']")
        @setup() if @notifications.length > 0 

    setup: -> 
        $("[data-behavior='notifications-link']").on "click", @handleClick ->

        $.ajax(
            url: "/notifications.json"
            dataType: "JSON"
            method: "GET"
            success: @handleSuccess
        )
    handleClick: (e) =>
        $.ajax(
            url: "/notifications/mark_as_read"
            dataType: "JSON"
            method: "POST"
            success: ->
                $("[data-behavior='unread-count']").text("")                
        )
    handleSuccess: (data) =>
       console.log(data) 
       items = $.map data, (notification) ->
            "<a class='dropdown-item' href='#{notification.url}'>#{notification.actor} #{notification.action} #{notification.notifiable.type}</a>"
        console.log(items)

        $("[data-behavior='notification-items']").html(items)
        $("[data-behavior='unread-count']").text(items.length)
        if items.length is 0
            $("[data-behavior='unread-count']").text("")               

jQuery ->
    new Notifications