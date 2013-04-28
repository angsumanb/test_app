$(document).ready( function() {
     if($('#vicky').text() == 'Hello') {
        $('#vicky').text("ifif");
     } 

  $("#table1").on('click', '.status', function() {
    $(this).removeClass('btn-warning');
    $(this).addClass('btn-success');
    $(this).prop('value', 'Passed');
  });

// ---------Change the button class when changing status on click event//  
$(".statusgroup").on('click', '.passed', function() {
    $(this).addClass('btn-success');
    $(this).closest('.statusgroup').find('.pending').removeClass('btn-warning');
    $(this).closest('.statusgroup').find('.failed').removeClass('btn-danger');
    $(this).closest('.statusgroup').find('.blocked').removeClass('btn-inverse');
  });
 
$(".statusgroup").on('click', '.pending', function() {
    $(this).addClass('btn-warning');
    $(this).closest('.statusgroup').find('.passed').removeClass('btn-success');
    $(this).closest('.statusgroup').find('.failed').removeClass('btn-danger');
    $(this).closest('.statusgroup').find('.blocked').removeClass('btn-inverse');
  });

$(".statusgroup").on('click', '.failed', function() {
    $(this).addClass('btn-danger');
    $(this).closest('.statusgroup').find('.passed').removeClass('btn-success');
    $(this).closest('.statusgroup').find('.pending').removeClass('btn-warning');
    $(this).closest('.statusgroup').find('.blocked').removeClass('btn-inverse');
  });


$(".statusgroup").on('click', '.blocked', function() {
    $(this).addClass('btn-inverse');
    $(this).closest('.statusgroup').find('.passed').removeClass('btn-success');
    $(this).closest('.statusgroup').find('.pending').removeClass('btn-warning');
    $(this).closest('.statusgroup').find('.failed').removeClass('btn-danger');
  });
//-----------------------------------------------------------
  $('.status').each(function () {
    if ($(this).attr('value') == 'Passed') {
        $(this).addClass('btn-success');
      //works $('input').attr('value','working');
   // if ($('#button1').attr('value') == 'Passed') {
     //   $('#button1').attr('value','working');
    } 
    if ($(this).attr('value') == 'Pending') {
        $(this).addClass('btn-warning');
    } 
});
  $('.statusgroup').each(function () {
    if ($(this).find('.passed').html() == 'Passed') {
     //   $(this).find('.passed').addClass('btn-success');
      //works $('input').attr('value','working');
   // if ($('#button1').attr('value') == 'Passed') {
     //   $('#button1').attr('value','working');
    } 
    if ($(this).find('.pending').html() == 'Pending') {
    //    $(this).find('.pending').addClass('btn-warning');
    } 
});

  $('.selectAll').on('click', function selectAll(){
//    event.preventDefault();
        $("input:checkbox").each(function(event){
          $(this).attr('checked', true);
        });
        return false; //works even w/o returning false - no jump back to top
      });
  $('.unselectAll').on('click', function selectAll(){
    //event.preventDefault();
        $("input:checkbox").each(function(event){
          $(this).attr('checked', false);
        });
        return false;
      });

  $('.selectAllFromPod').on('click', function (event) {
    //event.preventDefault();
    $(this).closest('.pod').find("input:checkbox").each(function() {
          $(this).attr('checked', true);
        });
        return false;
      });
});
