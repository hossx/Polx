'use strict'

Polymer 'subpage-verifying-email',
  msgMap:
    'zh':
      label: "验证邮箱"
      verifying: "正在验证您的邮箱..."

    'en':
      label: "Verify Email"
      verifying: "Verifying Email..."

  loading: true

  ready: () ->
    @M = @msgMap[window.lang]

  tokenChanged: (o, n) ->
    this.$.ajax.verify(@token) if @token
