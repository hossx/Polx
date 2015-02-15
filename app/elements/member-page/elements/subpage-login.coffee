'use strict'

Polymer 'subpage-login',
  msgMap:
    'zh':
      email: "email"
      password: "密码"
      login: "登录"
      register: "注册"
      forgetpassword: "忘记密码？"
      emailInvalid: ""

    'en':
      email: "email"
      password: "password"
      login: "Login"
      register: "Register"
      forgetpassword: "Forget password?"
      emailInvalid: "Your email address is invalid"

  observe: {
    email: 'validateLoginForm'
    password: 'validateLoginForm'

    profile: 'checkResult'
    loading: 'checkResult'
  }

  ready: () ->
    @M = @msgMap[window.lang]

  logMeIn: () -> 
    this.$.loginAjax.login()


  validateLoginForm: () ->
    if not @email or not @password
      @errorMsg = ''
      @buttonDisabled = true
    else if not @validateEmail(@email)
      @errorMsg = @M.emailInvalid
      @buttonDisabled = true
    else
      @errorMsg = ''
      @buttonDisabled = false

  validateEmail: (email) ->
    re = /^[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,4}$/
    re.test(email)

