// just a function to pluralize the word "character" based on the number
function pluralize_characters(num) {
  if(num < 0) {
    num *= -1;
  }
  if(num == 1) {
    return num + " character";
  } else {
    return num + " characters";
  }
}

$(document).ready(function() {
  $("#micropost_content").keyup(function() {
    var chars = $("#micropost_content").val().length;
    var left = 140 - chars; 
    if(left >= 0) {
      $("#char_count").text(pluralize_characters(left) + " left");
    } else {
      $("#char_count").text(pluralize_characters(left) + " too long");
    }
  });
});
