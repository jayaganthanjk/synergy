$(document).ready(function(){
  $.fn.datepicker.defaults.format = "dd-mm-yyyy";
  $.fn.datepicker.defaults.startDate = "d";
  $('.input-daterange').datepicker({
  });
  $('.input-group.date').datepicker({});
  $('[data-toggle="tooltip"]').tooltip();

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

  $('.inline-edit').popover({
  	html: true,
  	content: function() {
  		var states = [
  		"Not Started",
  		"In Progress",
  		"Delivered",
  		"Accepted",
  		"Rejected"
  		]
  		var options = '<select class="form-control" data-id="'+$(this).data('id')+'">';
  		var current_state = $(this).data('state');
  		var id = $(this).data('id');
  		for (var i=0; i < states.length; i++) {
  			if(states[i] == current_state) {
  				options += "<option value=\"" + states[i] + "\" selected disabled>" + states[i] + "</option>";
  			} else {
  				options += "<option value=\"" + states[i] + "\">" + states[i] + "</option>";
  			}
  		}
  		options += '</select>';
  		var $form = $("<form>", {
  			html: options
  		});
  		$form.find('select').change(function() {
  			console.log($(this).val(),id);
  		});
  	  	return $form.prop('outerHTML');
  	}
  });
  $( ".story" ).delegate( "select", "change", function() {
	$.ajax({
		type: "POST",
		url: "/changestorystate",
		data: {
			id: $(this).data('id'),
			state: $(this).val()
		}
	}).done(function(data, textStatus, jqXHR) {
		console.log(data, textStatus, jqXHR);
		window.location.href = '';
	});
  });
}); 