import consumer from "channels/consumer";

consumer.subscriptions.create("Noticed::RequestChannel", {
  connected() {
    console.log("CONNECTED ON REQUEST CHANNEL");
  },

  disconnected() {
    console.log("DISCONNECTED FROM REQUEST CHANNEL");
  },

  received(data) {
    console.log(data);

    const elem = $("div.activity-req-container.follow-request-activity > h3");

    if (elem.length != 0) {
      var count = parseInt(elem.html().split("-")[0].trim());
    }

    var phrase = count + 1 == 1 ? "Follow Request" : "Follow Requests";

    $("div.activity-req-container.follow-request-activity > h3").html(
      `${count + 1} - ${phrase}`
    );

    const viewBtn = $("div.activity-req-container.follow-request-activity > a");
    if (viewBtn.hasClass("invisible")) {
      viewBtn.removeClass("invisible").addClass("visible");
    }

    const is_recipient_active_user =
      $("#sidebarMenu").attr("data-user-id") == data["params"]["recipient_id"];

    if (is_recipient_active_user) {
      const toastHTML = `
      <div class="w-75 alert alert-info alert-dismissible fade show my-2 d-flex justify-content-between my-3 align-items-center mx-auto" role="alert">
      <div>${data["params"]["message"]} <strong><em>${data["params"]["sender_email"]}</em></strong></div>
      <button type="button" class="close" data-bs-dismiss="alert" aria-label="Close">
          <span aria-hidden="true">&times;</span>
      </button>
      </div>`;

      $("div#root > div#content").prepend(toastHTML);
    }
  },
});
