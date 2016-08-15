// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).on('click', '.remote_image', function(){
  var url = $(this).attr('src');
  $('#myModal').modal('toggle');
  $('#card_remote_image_url').val(url);
  $('#cached_image').attr('src', url);
  $('#hiddenDiv').removeClass('hidden');
  $('#card_image').val('');
});

$(document).on('click', '#card_image', function(){
  $('#card_remote_image_url').val('');
  $('#cached_image').attr('src', '');
  $('#hiddenDiv').addClass('hidden');
  console.log('click');
});
