// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require materialize

$(document).ready(function() {
  $("select").formSelect();
});

// Create Comments

$(document).ready(function() {
  $("#send").click(function() {
    var author = $("#author").val();
    var text = $("#text").val();
    var video_id = $("#video_id").val();

    if (author != "" && text != "") {
      $.ajax({
        method: "POST",
        url: "/videos/create_comment",
        data: { author: author, text: text, video_id: video_id }
      }).done(function(retorno) {
        $("#list-comments").html(retorno);
        $("#author").val("");
        $("#text").val("");
      });
    } else {
      alert("Você esqueceu de preencher algum campo!");
    }
  });
});
