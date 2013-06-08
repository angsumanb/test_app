window.Calendar.clearEvents = function(){
    events = $(".events .event");
    $.each(events, function(index, event){
      event.remove();
    });
  }

$(window).load(function() {
  Calendar.clearEvents();
});
