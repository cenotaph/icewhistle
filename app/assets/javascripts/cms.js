//= require jquery2
//= require jquery_ujs
//= require ckeditor/init
//= require jquery_nested_form
//= require flatpickr

document.addEventListener('DOMContentLoaded', function() {
  flatpickr('.datetime', {
    enableTime: true
  })
})