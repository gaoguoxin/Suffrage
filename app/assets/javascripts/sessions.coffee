$(->
	$('body.session .form-signin .btn').click((e)->
		e.preventDefault()
		email = $.trim($('#email').val())
		pwd   = $.trim($('#password').val())
		if email.length > 0 && pwd.length > 0 
			$.post('/sessions',{email:email,password:pwd},(ret)->
				if ret.success
					window.location.href = '/admin'
				else
					$('h2').text('用户名或密码错误')
			)
	)

	$('body.session .form-signin input').focus(->
		$('h2').text('登录')
	)
)