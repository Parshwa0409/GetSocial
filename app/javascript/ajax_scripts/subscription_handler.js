function subscription_ajax(method, action, data, button, btnText, btnID) {
  $.ajax({
    type: method,
    url: action,
    data: data,
    beforeSend: function (xhr) {
      xhr.setRequestHeader(
        "X-CSRF-Token",
        $('meta[name="csrf-token"]').attr("content")
      );
    },
    success: function (response) {
      console.log("Notification preference saved successfully!");
      button.html(btnText);
      button.attr("id", btnID);
      $("#subscription-notification").empty().append(response);
    },
    error: function (xhr, status, error) {
      console.error("An error occurred:", error);
    },
  });
}

$(function () {
  $(document).on("click", "#notify-me, #delete-notify-me", (event) => {
    var button = $(event.target);
    const preferred_user_id = $(event.target).data("user-id");
    const data = { preferred_user_id: preferred_user_id };
    var method, action;
    if (button.attr("id") == "notify-me") {
      method = "POST";
      action = "http://localhost:3000/notification_preferences";
      subscription_ajax(
        method,
        action,
        data,
        button,
        "Unsubscribe",
        "delete-notify-me"
      );
    } else if (button.attr("id") == "delete-notify-me") {
      method = "DELETE";
      action = `http://localhost:3000/notification_preferences/${preferred_user_id}`;
      subscription_ajax(method, action, data, button, "Subscribe", "notify-me");
    }
  });
});
