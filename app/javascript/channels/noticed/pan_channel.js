import consumer from "channels/consumer";

consumer.subscriptions.create("Noticed::PanChannel", {
  connected() {
    console.log("CONNECTED ON PAN CHANNEL");
  },

  disconnected() {
    console.log("DISCONNECTED FROM PAN CHANNEL");
  },

  received(data) {
    console.log(data);

    const html = `<div class="notification-container">
        <p><span>${data["params"]["sender_email"]}</span> ${data["params"]["message"]}</p>
        <a href="http://localhost:3000/posts/${data["record_id"]}" class="view-post-btn link-dark" data-notification-event-id="${data["id"]}">View Post</a>
    </div>`;

    var unc = $("#unread-notification-count");

    if (!data["params"]["post_create"]) {
      if (unc.attr("data-user-id") == data["params"]["recipient_id"]) {
        if (unc.hasClass("invisible")) {
          unc.removeClass("invisible").addClass("visible");
          unc.html(1);
        } else {
          unc.html(parseInt(unc.html()) + 1);
        }
      }
    } else {
      console.log(data["params"]["recipient_ids"]);
      data["params"]["recipient_ids"].forEach((recipient_id) => {
        if (unc.attr("data-user-id") == recipient_id) {
          if (unc.hasClass("invisible")) {
            unc.removeClass("invisible").addClass("visible");
            unc.html(1);
          } else {
            unc.html(parseInt(unc.html()) + 1);
          }
        }
      });
    }

    $("div#post-activity-notificaions-container").prepend(html);
  },
});
