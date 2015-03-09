'use strict'

Polymer 'withdraw-widget',
  msgMap:
    'en':
      withdraw: "Withdraw"
      quantity: "Withdrawal Quantity"
      address: "Destination Address"
      memo: "Memo"
      pubkey: "Public Key"
      pubkeyPlaceholder: "Public Key(Required when an address is used for the first time)"
      emailVCode: "Email Verification Code"
      smsVCode: "SMS Verification Code"
      retrieveEmailVCode: "Get the Code"
      retrieveSmsVCode: "Get the Code"
      googleVCode: "Google auth code"
      chooseBankCard: "Choose bank card"
      chooseBank: "Choose bank"
      withdrawSuccess: "Withdraw success"
      withdrawError: "Withdraw failed"
      notValidWithdrawAmount: "Quantity can't less than limit or greater than balance"
      removeBankcard: "Remove this card"
      addBankcard: "Add card"
      account: "Account"
      branch: "Branch(optional)"
      cancel: "Cancel"
      confirm: "Confirm"
      removeCardError: "Remove card failed"
      addCardError: "Add card failed"
    'zh':
      withdraw: "提现"
      quantity: "提现数量"
      address: "提现地址"
      memo: "Memo"
      pubkey: "公钥"
      pubkeyPlaceholder: "Public Key(地址首次使用需要填写)"
      emailVCode: "邮件验证码"
      smsVCode: "短信验证码"
      retrieveEmailVCode:  "获取邮件验证码"
      retrieveSmsVCode: "获取短信验证码"
      googleVCode: "二次验证码"
      chooseBankCard: "选择银行卡"
      chooseBank: "选择银行"
      withdrawSuccess: "提现成功"
      withdrawError: "提现出错，请检查地址或验证码是否输入正确"
      notValidWithdrawAmount: "提现金额不能小于最小限制，也不能大于余额"
      removeBankcard: "删除此银行卡"
      addBankcard: "添加银行卡"
      account: "账号"
      branch: "开户支行（可选）"
      cancel: "取消"
      confirm: "确认"
      removeCardError: "删除银行卡失败"
      addCardError: "删除银行卡失败, 请确保验证码输入正确"

  banksMap:
      'en': [
          'China Construction Bank',
          'Alipay',
          'Industrial & Commercial Bank of China',
          'Agricultural Bank of China',
          'Bank of China',
          'Bank of Communications',
          'Guangdong Development Bank',
          'china minsheng bank',
          'CITIC Industrial Bank',
          'Shenzhen Ping An Bank',
          'Industrial Bank',
          'China Everbright Bank',
          'Shanghai Pudong Development Bank',
          'The Import-Export Bank of China',
          'Huaxia Bank',
          'China Development Bank',
          'China Merchants Bank']
      'zh': [
          '建设银行',
          '支付宝',
          '工商银行',
          '农业银行',
          '中国银行',
          '交通银行',
          '广发银行',
          '民生银行',
          '中信银行',
          '平安银行',
          '兴业银行',
          '光大银行',
          '浦发银行',
          '进出口银行',
          '华夏银行',
          '国家开发银行',
          '招商银行']

  needPubkey: false
  needMemo: false
  needWithdrawalAddress: true
  needBankAddress: false
  errorMsg: ''

  ready: () ->
    @M = @msgMap[window.lang]
    @banks = @banksMap[window.lang]
    @bank = @banks[0]
    @isSWBDisable = true

  observe: {
      needGoogleAuth: 'submitButtonIsDisabled'
      needEmailAuth: 'submitButtonIsDisabled'
      needMobileAuth: 'submitButtonIsDisabled'
      googleVCode: 'submitButtonIsDisabled'
      emailVCode: 'submitButtonIsDisabled'
      smsVCode: 'submitButtonIsDisabled'
      address: 'submitButtonIsDisabled'
      quantity: 'submitButtonIsDisabled'
      needMemo: 'submitButtonIsDisabled'
      memo: 'submitButtonIsDisabled'
  }

  bankCardToString:(card) ->
      if (!card)
          ''
      else
          card.ownerName + ' | ' + card.cardNumber + ' | ' + card.bankName + ' | ' + (card.branchBankName || '')
  toggleAddBankCardCollapse:() ->
      this.$.addBankCardCollapse.toggle()

  retrieveEmailCode:() ->
      this.$.getEmailCodeAjax.getCode(false, true)

  retrievePhoneCode:() ->
      this.$.getPhoneCodeAjax.getCode(true, false)

  submitButtonIsDisabled: () ->
      @isSWBDisable = ((@needGoogleAuth && !@googleVCode) || (@needEmailAuth && !@emailVCode) || (@needMobileAuth && !@smsVCode) || (@currency != 'CNY' && !@address) || (@currency == 'CNY' && !@cnyAddress) || !@quantity || (@needMemo && !@memo) || (@quantity > @balance) || (@quantity < @limit))
      if (@quantity > @balance || @quantity < @limit)
          @errorMsg = @M.notValidWithdrawAmount
      else
          @errorMsg = ''

  submitWithdrawal:() ->
      if @quantity && @quantity <= @balance && @quantity >= @limit
          adds = if @currency == 'CNY' then @cnyAddress else @address
          this.$.submitWithdrawalAjax.withdraw(@currency, adds, @quantity, @emailUuid, @emailVCode, @phoneUuid,
              @smsVCode, @googleVCode, @pubkey, @memo, "v2", window.lang)

  onSubmitWithdrawalSuccess:(e) ->
      if e.detail.data && e.detail.data.withdraw_status == 0
          @quantity = 0
          @fire('display-message', {message: @M.withdrawSuccess})
          @fire('withdraw-succeed', {data: e.detail.data})
      else
          @fire('display-message', {error: @M.withdrawError})

  cardsChanged:(o, n) ->
      if @cards && @cards.length > 0
          @cnyAddress = @bankCardToString(@cards[0])
      else
          @cnyAddress = @M.chooseBankCard

  cancelAddCard: () ->
      this.$.addBankCardCollapse.opened = false

  removeBankCard: () ->
      account = @cards[@cardIndex]
      ajaxObj = document.querySelectorAll("paper-shadow /deep/ #removeBankCardAjax")[0]
      ajaxObj.removeCard(account.cardNumber)

  removeBankCardSuccess: (e) ->
      if e.detail.data.result
          queryCardsAjax = document.querySelectorAll("paper-shadow /deep/ #queryCardsAjax")[0]
          queryCardsAjax.go()
      else
          @fire('display-message', {error: @M.removeCardError})

  retrieveEmailCodeForAddCard: () ->
      this.$.getEmailCodeForAddCardAjax.getCode(false, true)

  confirmAddCard: () ->
      this.$.addBankCardAjax.addCard(@bank, @realname, @account, @branch, @emailUuidForAddCard, @emailVCodeForAddCard)

  addBankCardSuccess: (e) ->
      if e.detail.data.result
          queryCardsAjax = document.querySelectorAll("paper-shadow /deep/ #queryCardsAjax")[0]
          this.$.addBankCardCollapse.opened = false
          queryCardsAjax.go()
      else
          @fire('display-message', {error: @M.addCardError})
