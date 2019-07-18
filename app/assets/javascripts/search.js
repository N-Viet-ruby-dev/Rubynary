$(document).on('turbolinks:load', function () {
  $input = $("[data-behavior='autocomplete']")

  var options = {
    getValue: "value",
    url: function(phrase) {
      return "/search.json?q=" + phrase;
    },
    categories: [
      {
        listLocation: "words",
      }
    ]
  }
  $input.easyAutocomplete(options)
});
