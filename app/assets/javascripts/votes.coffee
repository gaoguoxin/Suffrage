$(->
	if window.location.href.indexOf('votes') > 0 
		fingerprint = new Fingerprint().get()
		#初始化省份下拉菜单
		$.each(window.provinces,(k,v)->
			li = $("<li><a href='javascript:void(0);' data-num='#{k}' data-value='#{v.name}'>#{v.name}</a></li>")
			li.appendTo('.province')
		)
	
		#省份变动导致的城市变动
		$('body.mobile .users form ul.province li a').click(->
			prov = $(this).data('value')
			$('#province').text(prov)
			$('input[name="province"]').val(prov)
			change_city($(this).data('num'))
		)
	
		#城市变动导致的区县变动
		$('body.mobile .users form').on('click','ul.city li a',->
			cit = $(this).data('value')
			$('#city').text(cit)
			$('input[name="city"]').val(cit)
			change_town($(this).data('num'))
		)
	
		#区县变动导致的变化
		$('body.mobile .users form').on('click','ul.area li a',->
			tow = $(this).data('value')
			$('#area').text(tow)
			$('input[name="area"]').val(tow)
		)
	
		change_city = (k)->
			$('ul.city').empty()
			$('#city').text('请选择所在市')
			$('#area').text('请选择所在区县')
			$('input[name="city"]').val('')
			$('input[name="area"]').val('')
			cities = window.cities[k]
			$.each(cities,(k,v)->
				$('ul.city').append("<li><a href='javascript:void(0);' data-num='#{v.id}' data-value='#{v.name}'>#{v.name}</a></li>")
			)
	
		change_town = (k)->
			towns = window.towns[k]
			$('ul.area').empty()
			$('#area').text('请选择所在区县')
			$('input[name="area"]').val('')
			$.each(towns,(k,v)->
				$('ul.area').append("<li><a href='javascript:void(0);' data-num='#{v.id}' data-value='#{v.name}'>#{v.name}</a></li>")
			)

			$('body.mobile .users form .btn').click(->
				name = $.trim($('input[name="name"]').val())
				prov = $.trim($('input[name="province"]').val())
				city = $.trim($('input[name="city"]').val())
				area = $.trim($('input[name="area"]').val())
				comp = $.trim($('input[name="company"]').val())
				posi = $.trim($('input[name="position"]').val())
				mobi = $.trim($('input[name="mobile"]').val())
				emai = $.trim($('input[name="email"]').val())
				cont = $.trim($('textarea').val())
				go   = true 
				$.each([name,prov,city,area,comp,posi,mobi,cont],()->
					unless this.length > 0 
						go = false
				)
				if go
					if $.regex.isMobile(mobi) && $.regex.isEmail(emai)
						$.post('/votes',{
								name:name,
								province:prov,
								city:city,
								area:area,
								company:comp,
								position:posi,
								mobile:mobi,
								email:emai,
								content:cont
							},(ret)->
								if ret.success
									$('.regist-modal').modal()
									$('.regist-modal').on('hidden.bs.modal',->
										window.location.href = '/'
									)
								else
									$('.modal span.mobile').text(mobi)
									$('.modal').modal()
						)
			)

		$('.mobile .doctors a.svote').click(->
			doc_id = $(this).attr('id')
			cnt    = $(this).siblings('span.count')
			$.get('/votes/vote',{id:doc_id,finger:fingerprint},(ret)->
				if ret.success
					c = parseInt(cnt.text())
					cnt.text(c + 1 )
				else
					if ret.value.error_code == 'error_04'
						notice = '最多能给24个医生投票'
					else
						notice = '每个医生只能投一票'
					open_vote_modal(notice)
			)
		)


		$('.mobile .doctors-detail .middle .btn').click(->
			doc_id = $(this).attr('id')
			$.get('/votes/vote',{id:doc_id,finger:fingerprint},(ret)->
				if ret.success
					open_success_modal()
				else
					if ret.value.error_code == 'error_04'
						notice = '最多能给24个医生投票'
					else
						notice = '每个医生只能投一票'
					open_vote_modal(notice)
			)			
		)

		open_vote_modal = (notice)->
			$('.notice').text(notice)
			$('.vote-modal').modal()
		open_success_modal = ->
			$('.success-modal').modal()
)