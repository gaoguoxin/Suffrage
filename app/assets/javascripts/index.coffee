$(->
	$('.mobile .rules .content img.tb').click(->
		$('.rule-modal').modal()
	)

	$('.mobile .index >.row .title').click(->
		hig = document.body.clientHeight
		console.log(hig)
		row = $(this).parents('.row')
		row.animate({top:'0px'},500)
		$.each(row.siblings('.row'),(k,v)->
			if hig <= 480
				top = 373 + k * 20
			else if hig <= 568
				top = 373 + k * 30
			else if hig <= 667
				top = 503 + k * 30
			else if hig <= 736
				top = 553 + k * 40
			$(this).animate({top:top + 'px'},500)
		)
	)
)