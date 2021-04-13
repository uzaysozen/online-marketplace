document.addEventListener("turbolinks:load", function(){ 
  var scrollDiv = document.getElementById("messages");
  if (scrollDiv !== null) {
    scrollDiv.scrollTop = scrollDiv.scrollHeight;
  }
});