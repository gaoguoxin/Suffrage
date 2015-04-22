$(->
	$(window).on('navigate',(e,d)->
		direct = d.state.direction
		if direct == 'back'
			console.log '----back-------'
		if direct == 'forward'
			console.log '----forward-------'
	)
	$('.mobile .rules .content img.tb').click(->
		$('.rule-modal').modal()
	)

	$('.mobile .index >.row').click(->
		hig = document.body.clientHeight
		row = $(this)
		if $(this).hasClass('cuttle')
			$.each($('.mobile .index >.row'),(k,v)->
				ori = $(this).attr('origin')
				$(this).removeClass('cuttle').animate({top:ori},500)
			)			
		else
			ori = row.css('top')
			row.addClass('active').attr('origin',ori).animate({top:'0px'},500)
			$.each(row.siblings('.row'),(k,v)->
				if hig <= 480
					top = 373 + k * 10
				else if hig <= 568
					top = 373 + k * 30
				else if hig <= 667
					top = 503 + k * 20
				else if hig <= 736
					top = 553 + k * 20
				origin = $(this).css('top')
				$(this).attr('origin',origin).removeClass('active').addClass('cuttle').animate({top:top + 'px'},500)
			)
	)


	# $('.mobile .index >.row .title').click(->
	# 	hig = document.body.clientHeight
	# 	console.log(hig)
	# 	row = $(this).parents('.row')
	# 	row.animate({top:'0px'},500)
	# 	$.each(row.siblings('.row'),(k,v)->
	# 		if hig <= 480
	# 			top = 373 + k * 10
	# 		else if hig <= 568
	# 			top = 373 + k * 30
	# 		else if hig <= 667
	# 			top = 503 + k * 20
	# 		else if hig <= 736
	# 			top = 553 + k * 20
	# 		$(this).animate({top:top + 'px'},500)
	# 	)
	# )
)