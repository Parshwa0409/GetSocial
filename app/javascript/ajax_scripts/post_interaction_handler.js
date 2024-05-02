function onPostSuccess(element) {
  $(element).html("❤️");
  $(element).removeClass("not-liked").addClass("liked");
}

function onDeleteSuccess(element, response) {
  $(element).html("♡");
  $(element).removeClass("liked").addClass("not-liked");
}

function AJAX(method, action, data, element, callback) {
  $.ajax({
    type: method,
    url: action,
    data: data,
    dataType: "json",
    beforeSend: function (xhr) {
      xhr.setRequestHeader(
        "X-CSRF-Token",
        $('meta[name="csrf-token"]').attr("content")
      );
    },
    success: function (response) {
      callback(element, response);
    },
  });
}

$(function () {
  $("button.like-btn").on("click", (e) => {
    e.stopPropagation();
    e.stopImmediatePropagation();

    var action, method, data;
    const button = e.target;
    var p_id = $(button).attr("data-post-id");

    if ($(button).hasClass("liked")) {
      action = `/likes/${$(e.target).attr("data-post-id")}`;
      method = "delete";
      data = { id: $(e.target).attr("data-post-id") };
      AJAX(method, action, data, button, onDeleteSuccess);
    } else {
      action = "/likes";
      method = "post";
      data = { id: $(e.target).attr("data-post-id") };
      AJAX(method, action, data, button, onPostSuccess);
    }
  });

  $("button.comment-btn").on("click", (event) => {
    const postID = $(event.target).attr("data-post-id");
    $.ajax({
      type: "get",
      url: `http://localhost:3000/posts/${postID}/comments`,
      dataType: "html",
      beforeSend: function (xhr) {
        xhr.setRequestHeader(
          "X-CSRF-Token",
          $('meta[name="csrf-token"]').attr("content")
        );
      },
      success: function (response) {
        $(document).find("#comment-modal-body > div#comments-content").empty();
        $(document)
          .find("#comment-modal-body > div#comments-content")
          .append(response);
        $(document)
          .find("button#post-comment-btn")
          .attr("data-post-id", postID);
      },
    });
  });

  $("button.share-btn").on("click", (event) => {
    const postID = $(event.target).attr("data-post-id");
    $("#sharePostModal .share-post-btn").attr("data-post-id", postID);
  });

  $("button.share-post-btn").on("click", (event) => {
    const postID = $(event.target).attr("data-post-id");
    const recipientID = $(event.target).attr("data-user-id");

    $.ajax({
      type: "post",
      url: `http://localhost:3000/posts/${postID}/share/${recipientID}`,
      beforeSend: function (xhr) {
        xhr.setRequestHeader(
          "X-CSRF-Token",
          $('meta[name="csrf-token"]').attr("content")
        );
      },
      success: function (response) {
        console.log("EWW EWW");
      },
    });

    event.stopPropagation();
    event.stopImmediatePropagation();
  });
});
