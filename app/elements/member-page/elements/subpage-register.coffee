'use strict'

Polymer 'subpage-register',
  msgMap:
    'zh':
      lastPrice: "最新成交价"
      volume: "24小时总成交量"
      change: "24小时价格变化"

    'en':
      lastPrice: "Last Price"
      volume: "24H Volume"
      change: "24H Change"

  ## register
  validateEmail: (email) ->
   re = /^[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,4}$/
   re.test(email)

  observe: {
    email: 'validateRegisterForm'
    password: 'validateRegisterForm'
    password2: 'validateRegisterForm'
    termsAgreed: 'validateRegisterForm'

  }

  email: ''
  termsAgreed: false
  registerDisabled: true

  registerMe: () -> this.$.ajax.go()

  validateRegisterForm: ()->
    if not @registerEmail and not @registerPassword and not @registerPassword2
      @errorMsg = ''
      @registerDisabled = true
    else if not @registerEmail
      @errorMsg = "Please provide your email"
      @registerDisabled = true
    else if not @validateEmail(@registerEmail)
      @errorMsg = "Your email address is invalid"
      @registerDisabled = true
    else if not @registerPassword and not @registerPassword2
      @errorMsg = "Please provide a password"
      @registerDisabled = true
    else if @registerPassword.length < 6
      @errorMsg = "Your password is too weak"
      @registerDisabled = true
    else if  @registerPassword != @registerPassword2
      @errorMsg = "Passwords do not match"
      @registerDisabled = true
    else
      @errorMsg = ''
      @registerDisabled = not @termsAgreed
