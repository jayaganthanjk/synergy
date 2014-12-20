$(document).ready(function(){
  $.fn.datepicker.defaults.format = "dd-mm-yyyy";
  $.fn.datepicker.defaults.startDate = "d";
  $('.input-daterange').datepicker({
  });
  $('.input-group.date').datepicker({});
}); 