'use strict'

Polymer 'subpage-verifying-email',
  msgMap:
    'zh':
      label: "验证Email"
      verifying: "正在验证您的Email..."

    'en':
      label: "Verify Email"
      verifying: "Verifying Email.."

  loading: true
  
  ready: () ->
    @M = @msgMap[window.lang]

  tokenChanged: (o, n) ->
    this.$.ajax.check(@token) if @token

  observe: 
    loading: 'onChange'
    ok: 'onChange'

  onChange: () ->
    if not @loading
      console.log("okkkkkk")
      if @ok
        window.emailVerificationToken = @token
        location.hash == '#/member/email_verified'
      else
        window.emailVerificationToken = null
        location.hash == '#/member/email_verification_failed'