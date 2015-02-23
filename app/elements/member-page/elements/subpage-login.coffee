'use strict'

Polymer 'subpage-login',
  msgMap:
    'zh':
      email: "Email"
      password: "密码"
      login: "登录"
      register: "还没有账号？注册一个吧。"
      forgetpassword: "忘记密码？"
      emailInvalid: "Email地址格式不正确。"
      invalidEmailOrPasswd: "用户名或密码错误！"

    'en':
      email: "Email"
      password: "Password"
      login: "Login"
      register: "Don't have an acccount? Register Now"
      forgetpassword: "Forget password?"
      emailInvalid: "Your email address is invalid."
      invalidEmailOrPasswd: "Invalid email or password!"
  errorMsg: ' '

  observe: {
    email: 'validateLoginForm'
    password: 'validateLoginForm'
  }

  ready: () ->
    @M = @msgMap[window.lang]
    @addEventListener 'user-access-denied', (e) ->
      @errorMsg = @M.invalidEmailOrPasswd
      @buttonDisabled = true

  logMeIn: () -> 
    this.$.loginAjax.login()

  validateLoginForm: () ->
    if not @email or not @password
      @errorMsg = ' '
      @buttonDisabled = true
    else if not @validateEmail(@email)
      @errorMsg = @M.emailInvalid
      @buttonDisabled = true
    else
      @errorMsg = ' '
      @buttonDisabled = false

  validateEmail: (email) ->
    window.config.emailRe.test(email)

