'use strict'

Polymer 'subpage-login',
  msgMap:
    'zh':
      lastPrice: "最新成交价"
      volume: "24小时总成交量"
      change: "24小时价格变化"

    'en':
      lastPrice: "Last Price"
      volume: "24H Volume"
      change: "24H Change"


  observe: {
    email: 'validateLoginForm'
    password: 'validateLoginForm'
  }

  logMeIn: () -> this.$.loginAjax.login()

  validateLoginForm: () ->
    if not @email and not @password 
      @errorMsg = ''
      @buttonDisabled = true
    else if not @email
      @errorMsg = "Please provide your email"
      @buttonDisabled = true
    else if not @validateEmail(@email)
      @errorMsg = "Your email address is invalid"
      @buttonDisabled = true
    else if not @password
      @errorMsg = "Please provide your password"
      @buttonDisabled = true
    else
      @errorMsg = ''
      @buttonDisabled = false

  validateEmail: (email) ->
    re = /^[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,4}$/
    re.test(email)
