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

var myEl = document.getElementById('card-animations');
myEl.addEventListener('click', function() {
  $('#cards').addClass('flipper');
}, false);
