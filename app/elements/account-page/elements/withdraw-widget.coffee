'use strict'

Polymer 'withdraw-widget',
  needPubkey: false
  needMemo: false
  needWithdrawalAddress: true
  needBankAddress: false
  errorMsg: ''

  ready: () ->
    @M = window.M['account']['withdraw-widget']
    @banks = @M.banks
    @bank = @banks[0]
    @isSWBDisable = true

  observe: {
      needGoogleAuth: 'buttonDisabled'
      needEmailAuth: 'buttonDisabled'
      needMobileAuth: 'buttonDisabled'
      googleVCode: 'buttonDisabled'
      emailVCode: 'buttonDisabled'
      smsVCode: 'buttonDisabled'
      address: 'buttonDisabled'
      quantity: 'buttonDisabled'
      needMemo: 'buttonDisabled'
      memo: 'buttonDisabled'
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

  buttonDisabled: () ->
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
