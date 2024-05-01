$(() => {
  $("#mark-all-pan-as-read").on("click", (event) => {
    event.preventDefault();

    $.ajax({
      type: "post",
      url: `http://localhost:3000/notifications/mark_all_pan_as_read`,
      beforeSend: function (xhr) {
        xhr.setRequestHeader(
          "X-CSRF-Token",
          $('meta[name="csrf-token"]').attr("content")
        );
      },
      success: function (response) {
        $("#unread-notification-count")
          .removeClass("visible")
          .addClass("invisible");
        $("#post-activity-notificaions-container").empty();
      },
    });

    event.stopPropagation();
    event.stopImmediatePropagation();
  });

  $("#mark-all-dm-as-read").on("click", (event) => {
    event.preventDefault();

    $.ajax({
      type: "post",
      url: `http://localhost:3000/notifications/mark_all_dm_as_read`,
      success: function (response) {
        $("#unread-messages-count")
          .removeClass("visible")
          .addClass("invisible");
        $("#message-notificaions-container").empty();
      },
    });

    event.stopPropagation();
    event.stopImmediatePropagation();
  });
});
