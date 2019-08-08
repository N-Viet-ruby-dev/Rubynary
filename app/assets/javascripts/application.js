// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require lib/jquery.dataTables.min
//= require lib/dataTables.bootstrap4.min
//= require activestorage
//= require toastr
//= require bootstrap-sprockets
//= require owl.carousel
//= require custom
//= require select2
//= require select2-full
//= require jquery.easy-autocomplete
//= require search

function initDataTable(){
  $('#project').DataTable({
    destroy: true,
    order: []
  });
}

function initDataTableUser(){
  $('#user').DataTable({
    destroy: true,
    order: []
  });
}

function initDataTableWordProjects(){
  $('#word-projects').DataTable({
    destroy: true,
    order: []
  });
}

function initDataTableSuggestedWord(){
  $('#suggested-word').DataTable({
    destroy: true,
    order: []
  });
}

$(document).ready(function() {
  $('#zero_config').DataTable();
  $('#project').DataTable();
  $('#user').DataTable();
  $('#word-projects').DataTable();
  $('#suggested-word').DataTable();
  initDataTable();
  initDataTableUser();
  initDataTableWordProjects();
  initDataTableSuggestedWord();
});
