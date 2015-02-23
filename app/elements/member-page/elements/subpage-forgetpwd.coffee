'use strict'

Polymer 'subpage-forgetpwd',
  msgMap:
    'en':
      title: "Forgot Password?"
      email: "Email"
      login: "Login"
      register: "Register"
      reset: "Reset Password"
    'zh':
      title: "忘记密码"
      email: "Email"
      login: "登录"
      register: "注册"
      reset: "重置密码"

  ready: () ->
    @M = @msgMap[window.lang]
