$(document).on("change", "#project_id", function(){
  var project = $(this).val();
  $.ajax({
    url: "/project_words",
    method: "GET",  
    dataType: "script",
    data: {project: project}
  });
});

 $(function() {
  $("#selectAll").select_all();
});

 $(function () {
  $('#projects_name').multipleSelect({
    width: 300
  });
});
 