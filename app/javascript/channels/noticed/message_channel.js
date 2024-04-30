import consumer from "channels/consumer";

consumer.subscriptions.create("Noticed::MessageChannel", {
  connected() {
    console.log("CONNECTED ON MSG CHANNEL");
  },

  disconnected() {
    console.log("DISCONNECTED FROM MSG CHANNEL");
  },

  received(data) {
    console.log(data);

    if (data["params"]["attachment_attached"]) {
      var html = `<div class="d-flex justify-content-between align-items-center">
        <p>${data["params"]["message"]}</p>
        <a href="http://localhost:3000/messages/${data["record_id"]}" class="view-msg-btn link-dark" data-notification-event-id="${data["id"]}">View Attachment</a>
    </div>`;
    } else {
      var html = `<div class="d-flex justify-content-between align-items-center">
        <p>${data["params"]["message"]}</p>
    </div>`;
    }

    $("div#message-notificaions-container").prepend(html);

    var unread_msg_count = $("#unread-messages-count");

    if (
      unread_msg_count.attr("data-user-id") == data["params"]["recipient_id"]
    ) {
      if (unread_msg_count.hasClass("invisible")) {
        unread_msg_count.removeClass("invisible").addClass("visible");
        unread_msg_count.html(1);
      } else {
        unread_msg_count.html(parseInt(unread_msg_count.html()) + 1);
      }
    }
  },
});
