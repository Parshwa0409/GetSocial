$(function () {
  $("#query-btn").on("click", (e) => {
    e.preventDefault();

    const action = $("#query-form").attr("action");
    const method = $("#query-form").attr("method");
    const form_data = $("#query-form").serialize();

    $.ajax({
      url: action,
      type: method,
      data: form_data,
      dataType: "html",
      success: function (response) {
        $("#query-results").empty();
        $("#query-results").append(response);
      },
    });
  });
});
