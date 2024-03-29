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
       items = $.map data, (notification) ->
            "<a onclick='sendPost()' class='dropdown-item small' href='#{notification.url}', data-turbolinks='false'>#{notification.actor} #{notification.action}<br class='d-block d-sm-none'> #{notification.notifiable.type}</a>"

        $("[data-behavior='notification-items']").prepend(items)
        if (data[0] && data[0].read) == false
            $('.notification-indic').html("new")
        else
            $('.notification-indic').html("")

$(document).on('turbolinks:load', -> new Notifications)
