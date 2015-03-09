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
      errRegisterFailed:
        0: "未知错误 - 请联系客服。" 
        1001: "注册失败：该email已经注册。"

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
      errRegisterFailed:
        0: "Unknown error! Please contact our customer service." 
        1001: "Registeration Failed: Email already registered."

  ## register
  validateEmail: (email) ->
   window.config.emailRe.test(email)

  observe: {
    email: 'validateRegisterForm'
    password: 'validateRegisterForm'
    password2: 'validateRegisterForm'
    termsAgreed: 'validateRegisterForm'
  }

  email: ''
  termsAgreed: false
  registerDisabled: true
  errorMsg: ''

  ready: () ->
    @M = @msgMap[window.lang]
    @addEventListener 'user-register-failed', (e) -> 
      @errorMsg =  @M.errRegisterFailed[e.detail.code]
      console.debug("------user-register-failed", e.detail.code, @errorMsg)
      @registerDisabled = true

  registerMe: () ->
    if not @registerDisabled
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