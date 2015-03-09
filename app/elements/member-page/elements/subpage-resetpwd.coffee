'use strict'

Polymer 'subpage-resetpwd',
  msgMap:
    'en':
      password: "New pasword"
      password2: "Repeat new password"
      login: "Login"
      register: "Don't have an acccount? Register Now"
      reset: "Reset Password"
      resend: "Re-send me a password reset email."
      errors:
        loggedIn: "You have logged in."
        noToken: "You need to click the link in your email."
        notMatch: "Passwords do not match"
    'zh':
      password: "新密码"
      password2: "确认新密码"
      login: "登录"
      register: "还没有账号？注册一个吧。"
      reset: "重置密码"
      resend: "重新发送重置密码的邮件给我。"
      errors:
        loggedIn: "登录状态无法重置密码。"
        noToken: "请您点击重置密码邮件中的链接。"
        notMatch: "密码不匹配"

  observe:
    token: 'onChange'
    password: 'onChange'
    password2: 'onChange'

  formEnabled: false
  errorMsg: ''

  created: () ->
    @M = @msgMap[window.lang]
    @profile = window.profile

  onChange: () ->
    if @password and @password2
      if @password != @password2
        @errorMsg = @M.errors.notMatch
      else
        @errorMsg = ''
    else 
      @errorMsg = ''

    @formEnabled = not @profile and @token
    @enabled = @formEnabled and not @errorMsg

  resetPasswd: () ->
    this.$.ajax.resetPasswd(@token, @password) if @enabled
