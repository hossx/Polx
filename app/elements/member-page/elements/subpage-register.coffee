'use strict'

Polymer 'subpage-register',
  msgMap:
    'zh':
      register: "注册"
      email: "Email"
      password: "密码"
      password2: "重新输入密码"
      haveRead1: "我已阅读并同意币丰港交易所的"
      haveRead2: "服务条款"
      login: "已有账号登录"

      errProvideEmail: "请输入您的Email"
      errEmailInvalid: "Email地址格式错误"
      errPasswordTooSimple: "您的密码过于简单"
      errPasswordsMisMatch: "两次密码输入不一致"
      errPasswordMissing: "请输入密码"
      errRegisterFailed: "注册失败"

    'en':
      register: "Register"
      email: "Email"
      password: "Passwod"
      password2: "Confirm Password"
      haveRead1: "I have read and agree to Coinport Exchange's "
      haveRead2: "Terms of Service"
      login: "Login"
      errProvideEmail: "Please provide your email"
      errEmailInvalid: "Your email address is invalid"
      errPasswordTooSimple: "Your password is too weak"
      errPasswordsMisMatch: "Passwords do not match"
      errPasswordMissing: "Please provide a password"
      errRegisterFailed: "Registeration Failed!"

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

  ready: () ->
    @M = @msgMap[window.lang]
    @addEventListener 'user-register-failed', (e) ->
      console.debug("------user-register-failed")
      @errorMsg =  @M.errRegisterFailed
      @password = @password2 = ''
      @registerDisabled = true

  registerMe: () ->
    this.$.ajax.register()

  validateRegisterForm: ()->
    if not @email and not @password and not @password2
      @errorMsg = ''
      @registerDisabled = true
    else if not @email
      @errorMsg = @M.errProvideEmail
      @registerDisabled = true
    else if @password and not @validateEmail(@email)
      @errorMsg = @M.errEmailInvalid
      @registerDisabled = true
    else if @password2 and @password.length < 6
      @errorMsg = @M.errPasswordTooSimple
      @registerDisabled = true
    else if @password and @password2 and @password != @password2
      @errorMsg = @M.errPasswordsMisMatch
      @registerDisabled = true
    else
      @errorMsg = ''
      @registerDisabled = not @termsAgreed

  resultChanged: (o, n) ->
    console.log(@result)