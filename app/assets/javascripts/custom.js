$(document).ready(function(){

  var d = new Date();
  var strDate = d.getDate() + "/" +(d.getMonth()+1) +  "/" + d.getFullYear();
  console.log(strDate);

  $('.add-calender').datepicker({
    startDate : strDate,
    format: 'dd-mm-yyyy'
  });  
}); 