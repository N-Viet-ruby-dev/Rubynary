$(document).on("change", "#project_id", function(){
  var project = $(this).val();
  $.ajax({
    url: "/project_words",
    method: "GET",  
    dataType: "script",
    data: {project: project}
  });
});

$(document).ready(function() {
  $('.add-project').select2({
    placeholder: "Select projects",
    allowClear: true,
    maximumSelectionLength: 2
  });
  $('#search_project').select2({
    placeholder: "All projects",
    allowClear: true,
  });
});

$(document).on("change", "#lg_ja_cont, #lg_en_cont, #lg_vi_cont", function(){
  var lg = $(this).val();
  var q = $("#q").val();
  $.ajax({
    url: "/words",
    method: "GET",  
    dataType: "script",
    data: {lg: lg, q: q}
  });
});
