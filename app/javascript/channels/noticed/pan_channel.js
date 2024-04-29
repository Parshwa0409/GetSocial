import consumer from "channels/consumer";

consumer.subscriptions.create("Noticed::PanChannel", {
  connected() {
    console.log("CONNECTED ON PAN CHANNEL");
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log(data);

    const html = `<div class="notification-container">
        <p><span>${data["params"]["user_email"]}</span> ${data["params"]["message"]}</p>
        <a href="http://localhost:3000/posts/${data["record_id"]}" class="view-post-btn link-dark" data-notification-event-id="${data["id"]}">View Post</a>
    </div>`;

    $("div#post-activity-notificaions-container").prepend(html);
  },
});
