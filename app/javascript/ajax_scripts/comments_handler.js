$(function () {
  $("#post-comment-form").submit(function (event) {
    event.preventDefault();

    const method = $(this).attr("method");
    const formData = $(this).serialize();
    const postID = $(event.target).find("button").attr("data-post-id");

    $.ajax({
      url: `http://localhost:3000/posts/${postID}/comments`,
      method: method,
      data: formData,
      beforeSend: function (xhr) {
        xhr.setRequestHeader(
          "X-CSRF-Token",
          $('meta[name="csrf-token"]').attr("content")
        );
      },
      success: function (response) {
        $(event.target).find("#post-comment-input").val("");
        $(document)
          .find("#comment-modal-body > div#comments-content")
          .prepend(response);
      },
      error: function (xhr, status, error) {
        console.error("Error posting comment:", error);
      },
    });
  });
});
