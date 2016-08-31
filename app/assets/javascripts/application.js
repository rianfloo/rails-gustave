//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require_tree .


function openMessenger() {
  window.open('https://www.messenger.com/t/gustavesommelier', 'messenger');
  document.body.classList.add('inactive');
  setTimeout(function(){
    checkFocus = setInterval(function(){
      if (document.hasFocus()) {
        document.body.classList.remove('inactive');
        clearInterval(checkFocus);
      }
    }, 1)
  }, 1000);
};

$('document').ready(function() {
  $('.card-animations').click(function() {
    var cardId = $(this).closest(".flipper").attr("id");
    console.log($(cardId));
    $('#' + cardId).toggleClass('flipped');
    $('#' + cardId).closest('.cards').toggleClass('flipable');
  });

  $( ".star-cb-group > input" ).click(function() {
    console.log("click");
    $(".star-cb-group > input").prop("checked", false);
    $(this).prop("checked", true);
  });

});


