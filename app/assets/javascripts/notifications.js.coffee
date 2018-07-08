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
        if data[4].read == false
            $('#notification-indic').html("new")  
        else
            $('#notification-indic').html("")           

$(document).on('turbolinks:load', -> new Notifications)