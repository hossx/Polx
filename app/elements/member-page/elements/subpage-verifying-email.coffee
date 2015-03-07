'use strict'

Polymer 'subpage-verifying-email',
  msgMap:
    'zh':
      label: "验证Email"
      verifying: "正在验证您的Email..."

    'en':
      label: "Verify Email"
      verifying: "Verifying Email.."

  ready: () ->
    @M = @msgMap[window.lang]
  