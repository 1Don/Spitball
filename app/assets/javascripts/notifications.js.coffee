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
        items = $.map.dataw (notification) ->
            "<a class='dropdown-item' href='#{notification.url}>#{notification.action} #{notification.notifiable.type}</a>"

        $("[data-behavior='unread-count']").text(items.length)
        $("[data-behavior='notification-items']").html(items)

jQuery ->
    new Notifications