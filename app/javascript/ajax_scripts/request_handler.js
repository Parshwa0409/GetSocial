function change_button_text(e, text, u_id) {
  const el = $(document).find(`[data-user-id='${u_id}']`);
  $(el).text(text);
}

function request_ajax(u_id, request_type) {
  $.ajax({
    type: "post",
    url: `http://localhost:3000/requests/${u_id}/${request_type}`,
    data: "data",
    beforeSend: function (xhr) {
      xhr.setRequestHeader(
        "X-CSRF-Token",
        $('meta[name="csrf-token"]').attr("content")
      );
    },
    success: function (response) {
      console.log(response);
    },
  });
}

$(function () {
  $(document).on("click", ".follow, .unfollow, .cancel", (event) => {
    event.preventDefault();
    const button = $(event.target);
    const u_id = $(event.target).attr("data-user-id");
    const isFollowing = button.hasClass("follow");

    if (isFollowing) {
      button.removeClass("follow").addClass("cancel");
      change_button_text(event, "Cancel Request", u_id);

      request_ajax(u_id, "follow");
    } else {
      if (button.hasClass("cancel")) {
        button.removeClass("cancel").addClass("follow");
        request_ajax(u_id, "cancel");
      } else if (button.hasClass("unfollow")) {
        $("div.button-container.send-msg-btn").remove();
        $("#user-posts").addClass("invisible");
        button.removeClass("unfollow").addClass("follow");
        request_ajax(u_id, "unfollow");
      }

      change_button_text(event, "Follow", u_id);
    }
  });

  $(document).on("click", ".accept, .decline", (event) => {
    event.preventDefault();
    const button = $(event.target);
    const u_id = $(event.target).attr("data-user-id");
    const req_accepted = button.hasClass("accept");

    if (req_accepted) {
      request_ajax(u_id, "accept");
    } else {
      request_ajax(u_id, "decline");
    }

    $(event.target).closest("div.request-container").parent().remove();
  });

  $(document).on("click", ".cancel-pending-request", (event) => {
    event.preventDefault();
    const u_id = $(event.target).attr("data-user-id");

    request_ajax(u_id, "cancel");

    $(event.target).parent().parent().empty();
  });

  $("button.unblock-btn").on("click", function (event) {
    const userID = $(event.target).attr("data-user-id");

    $.ajax({
      type: "post",
      url: `http://localhost:3000/requests/${userID}/unblock`,
      beforeSend: function (xhr) {
        xhr.setRequestHeader(
          "X-CSRF-Token",
          $('meta[name="csrf-token"]').attr("content")
        );
      },
      success: function (response) {
        $(event.target).closest("div.grand-parent").remove();
      },
    });
    event.stopPropagation();
    event.stopImmediatePropagation();
  });
});
