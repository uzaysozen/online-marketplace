document.addEventListener("turbolinks:load", function(){ 
  var scrollDiv = document.getElementById("messages");
  scrollDiv.scrollTop = scrollDiv.scrollHeight;
});