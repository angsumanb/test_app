 $(document).ready( function() {
   $("#table1").on('click', '#button2', function() {
    $(this).toggleClass('btn-primary');
    $(this).html('Passed');
  });
});

  
