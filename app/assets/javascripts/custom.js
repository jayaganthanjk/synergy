$(document).ready(function(){
  $.fn.datepicker.defaults.format = "dd-mm-yyyy";
  $.fn.datepicker.defaults.startDate = "d";
  $('.input-daterange').datepicker({
  });
  $('.input-group.date').datepicker({});


  var emails = [];

  //Ajax request to get the users list of adding resoureces
  function findUserMails()
  {
    $.ajax({
      type : 'get',
      async : false,
      dataType : 'json',
      url : "/findUsers",
      success: function(data){
        console.log(data);
        emails = data;
      },
      failure : function(error){
        alert("Error in ajax request for gettting users list "+error);
      }
    })
  }

  findUserMails();

  $('.typeahead').typeahead();
  $('.typeahead').typeahead('destroy');
  $('#email').typeahead({
    source : function(query,process){
      var return_email = [];
      var map ={};
      $.each( emails, function(i, state){
        map[state.email] = email;
        return_email.push(state.email);
      });
      process(return_email);
    }
  });



}); 