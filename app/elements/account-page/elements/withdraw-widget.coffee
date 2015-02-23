'use strict'

Polymer 'withdraw-widget',
  msgMap:
    'en':
      withdraw: "Withdraw"
      quantity: "Withdrawal Quantity"
      address: "Destination Address"
      memo: "Memo"
      pubkey: "Public Key"
      pubkeyPlaceholder: "Required when an address is used for the first time."
      emailVCode: "Email Verification Code"
      smsVCode: "SMS Verification Code"
      retrieveEmailVCode: "Get the Code"
      retrieveSmsVCode: "Get the Code"
    'zh':
      withdraw: "提现"
      quantity: "提现数量"
      address: "提现地址"
      memo: "Memo"
      pubkey: "公钥"
      pubkeyPlaceholder: "当一个地址第一次在币丰港时候时需要"
      emailVCode: "邮件验证码"
      smsVCode: "短信验证码"
      retrieveEmailVCode:  "获取邮件验证码"
      retrieveSmsVCode: "获取短信验证码"

  needPubkey: false
  needMemo: false
  ready: () ->
    @M = @msgMap[window.lang]

