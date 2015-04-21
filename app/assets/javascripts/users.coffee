$(->
	$('.desktop .users table tr td a').hover(->
		data = $(this).attr('info')
		$(this).webuiPopover({title:'用户病例摘要信息',content:$(this).attr('info'),animation:'pop'})
		$(this).click()
	)
	$('#doctor_avatar').fileinput({'showUpload':false})

)