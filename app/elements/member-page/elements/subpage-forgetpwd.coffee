'use strict'

Polymer 'subpage-forgetpwd',
  msgMap:
    'en':
      title: "Forgot Password?"
      email: "Email"
      login: "Login"
      register: "Don't have an acccount? Register Now"
      reset: "Request Password Reset"
    'zh':
      title: "忘记密码"
      email: "Email"
      login: "登录"
      register: "还没有账号？注册一个吧。"
      reset: "请求重置密码"

  ready: () ->
    @M = @msgMap[window.lang]

  requestResetPasswd: () ->
    this.$.ajax.request(@email) if @email