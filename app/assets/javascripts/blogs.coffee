# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(->
  $('#blog_image').fileinput({'showUpload':false})
  $('ul.blog-type li a').click(->
  	type = $(this).data('role')
  	txt  = $(this).text()
  	$('.current-role').text(txt)
  	$('#blog_type').val(type)
  )
)