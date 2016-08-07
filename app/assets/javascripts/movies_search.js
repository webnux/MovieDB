$(document).ready(function() {
  $("#category").change(function() {
    $.get($("#movies_search").attr("action"), $("#movies_search").serialize(), null, "script");
    return false;
  })

  $("#movie").keyup(function() {
    $.get($("#movies_search").attr("action"), $("#movies_search").serialize(), null, "script");
  })
})
