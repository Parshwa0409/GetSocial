$(function () {
  $(".view-story-btn").on("click", (event) => {
    $.ajax({
      type: "post",
      url: "http://localhost:3000/story_views",
      data: { story_id: $(event.target).attr("data-story-id") },
      beforeSend: function (xhr) {
        xhr.setRequestHeader(
          "X-CSRF-Token",
          $('meta[name="csrf-token"]').attr("content")
        );
      },
      success: function (response) {
        console.log("Story viewed!!!");
      },
    });

    event.stopPropogation();
    event.stopImmediatePropogation();
  });
});
