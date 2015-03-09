'use strict'

Polymer 'subpage-resend-activation',
  msgMap:
    'en':
      title: "Re-send activation email"
      email: "Email"
      login: "Login"
      register: "Don't have an acccount? Register Now"
      reset: "Re-send Account Verification Email"
    'zh':
      title: "重发激活邮件"
      email: "Email"
      login: "登录"
      register: "还没有账号？注册一个吧。"
      reset: "再发邮箱验证邮件给我"

  ready: () ->
    @M = @msgMap[window.lang]

  requestResetPasswd: () ->
    console.log(@email)
    this.$.ajax.request(@email) if @email