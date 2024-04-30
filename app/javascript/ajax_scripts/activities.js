$(() => {
  $("a.view-post-btn").on("click", function (event) {
    const notificationEventID = $(event.target).attr(
      "data-notification-event-id"
    );

    $.ajax({
      type: "post",
      beforeSend: function (xhr) {
        xhr.setRequestHeader(
          "X-CSRF-Token",
          $('meta[name="csrf-token"]').attr("content")
        );
      },
      url: `http://localhost:3000/notifications/${notificationEventID}/mark_pan_as_read`,
      success: function (response) {
        $(event.target).parent().remove();

        var notificationCounts = parseInt(
          $("#unread-notification-count").html()
        );
        $("#unread-notification-count").html(notificationCounts - 1);
      },
    });

    event.stopPropagation();
    event.stopImmediatePropagation();
  });

  $("#mark-all-as-read").on("click", (event) => {
    event.preventDefault();

    $.ajax({
      type: "post",
      beforeSend: function (xhr) {
        xhr.setRequestHeader(
          "X-CSRF-Token",
          $('meta[name="csrf-token"]').attr("content")
        );
      },
      url: `http://localhost:3000/notifications/mark_all_pan_as_read`,
      success: function (response) {
        console.log("Done");
        $("#post-activity-notificaions-container").remove();
        $("#unread-notification-count").remove();
      },
    });

    event.stopPropagation();
    event.stopImmediatePropagation();
  });
});
