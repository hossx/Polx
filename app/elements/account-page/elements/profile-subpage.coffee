'use strict'

Polymer 'profile-subpage',
  ready: () ->
    @M = window.M['account']['profile']
    @selectedCountry = "zh-CN"
    @selectedIdType = "idcard"
    @selectedPhoneCountry = "zh-CN"
    @sendingBindPhoneCode = false
    @isCPWDisable = true
    @errorMsg = ""

  observe: {
      oldPw: 'checkChangePw'
      newPw: 'checkChangePw'
      confirmPw: 'checkChangePw'
  }

  # ============== google auth =============
  cancelEnableGoogleAuth:() ->
      this.$.googleAuthToggleButton.checked = false
      this.$.enableGoogleAuthCollapse.opened = false

  confirmEnableGoogleAuth:() ->
      this.$.bindGoogleAuthAjax.bindGoogleAuth(@secret, @enGACode)

  cancelDisableGoogleAuth: () ->
      this.$.googleAuthToggleButton.checked = true
      this.$.disableGoogleAuthCollapse.opened = false

  confirmDisableGoogleAuth: () ->
      this.$.unbindGoogleAuthAjax.unbindGoogleAuth(@disGACode)

  toggleEnableGoogleAuth: (e) ->
      if @profile.googleAuthEnabled
          this.$.disableGoogleAuthCollapse.toggle()
      else
          this.$.enableGoogleAuthCollapse.toggle()

  onBindGASuccess: (e) ->
      if e.detail.data.result
          @profile.googleAuthEnabled = true
          this.$.googleAuthToggleButton.checked = true
          this.$.enableGoogleAuthCollapse.opened = false
      else
          @fire('display-message', {error: @M.bindGoogleAuthError})

  onUnbindGASuccess: (e) ->
      if e.detail.data.result
          @profile.googleAuthEnabled = false
          this.$.googleAuthToggleButton.checked = false
          this.$.disableGoogleAuthCollapse.opened = false
      else
          @fire('display-message', {error: @M.unbindGoogleAuthError})

  # ============== cell phone =============
  regularMobileNumber: (location, number) ->
      numberTrimed = number.trim()
      if (location == 'zh-CN')
          if (numberTrimed.indexOf("+86") == 0)
              "+86" + numberTrimed.substring(3).trim()
          else if (numberTrimed.indexOf("0086") == 0)
              "+86" + numberTrimed.substring(4).trim()
          else
              "+86" + numberTrimed
      else
          numberTrimed

  validateMobileNumber: (location, number) ->
      if (location && number)
          numberTrimed = number.trim()
          if (location == 'zh-CN')
              ((numberTrimed.indexOf("+86") == 0) && (numberTrimed.substring(3).trim().length == 11)) || ((numberTrimed.indexOf("0086") == 0) && (numberTrimed.substring(4).trim().length == 11)) || (numberTrimed.length == 11)
          else if (location == 'USA')
              numberTrimed.length >= 9
          else if (location == 'other')
              numberTrimed.length >= 9
          else
              false
      else
          false

  toggleBindCellphoneCollapse:() ->
      this.$.bindCellphoneCollapse.toggle()

  cancelBindCellphone:() ->
      this.$.bindCellphoneCollapse.opened = false

  confirmBindCellphone:() ->
      regularPhoneNumber = @regularMobileNumber(@selectedPhoneCountry, @phoneNumber)
      if (@validateMobileNumber(@selectedPhoneCountry, @phoneNumber))
          this.$.bindUpdatePhoneAjax.bindUpdatePhone(regularPhoneNumber, "", "", @bindPhoneUuid, @bindPhoneCode)
      else
          @fire('display-message', {error: @M.badPhoneNumber})

  cancelEnableCellphoneVerify:() ->
      ctb = document.querySelectorAll("paper-shadow /deep/ #cellphoneToggleButton")[0]
      ctb.checked = !ctb.checked
      this.$.cellphoneSmsCodeCollapse.opened = false

  confirmEnableCellphoneVerify:() ->
      enableAuth = if @profile.mobileAuthEnabled then "0" else "1"
      this.$.setPhoneAuthAjax.setPhoneAuth(@phoneAuthUuid, @smsVerifyCode, enableAuth)

  toggleEnableCellphoneAuth: (e) ->
      if !this.$.cellphoneSmsCodeCollapse.opened
          this.$.getCodeForPhoneAuthAjax.getCode(true, false)
      this.$.cellphoneSmsCodeCollapse.toggle()

  sendBindPhoneCode: () ->
      regularPhoneNumber = @regularMobileNumber(@selectedPhoneCountry, @phoneNumber)
      if (@validateMobileNumber(@selectedPhoneCountry, @phoneNumber))
          this.$.sendBindPhoneCodeAjax.requireCode(regularPhoneNumber)
      else
          @fire('display-message', {error: @M.badPhoneNumber})

  onBindUpdatePhoneSuccess: (e) ->
      if e.detail.data.result
          @profile.mobileVerified = true
          this.$.bindCellphoneCollapse.opened = false
      else
          @fire('display-message', {error: @M.bindUpdatePhoneError})

  onSetPhoneAuthSuccess: (e) ->
      if e.detail.data.result
          @profile.mobileAuthEnabled = !@profile.mobileAuthEnabled
          this.$.cellphoneSmsCodeCollapse.opened = false
      else
          @fire('display-message', {error: @M.changePhoneAuthError})

  # ============== email =============
  toggleBindEmailCollapse:() ->
      this.$.bindEmailCollapse.toggle()

  cancelBindEmail:() ->
      this.$.bindEmailCollapse.toggle()
  confirmBindEmail:() ->
      this.$.bindEmailCollapse.toggle()

  cancelEnableEmailVerify:() ->
      etb = document.querySelectorAll("paper-shadow /deep/ #emailToggleButton")[0]
      etb.checked = !etb.checked
      this.$.emailCodeCollapse.toggle()

  confirmEnableEmailVerify:() ->
      enableAuth = if @profile.emailAuthEnabled then "0" else "1"
      this.$.setEmailAuthAjax.setEmailAuth(@emailAuthUuid, @emailVerifyCode, enableAuth)

  toggleEnableEmailAuth: (e) ->
      if !this.$.emailCodeCollapse.opened
          this.$.getCodeForEmailAuthAjax.getCode(false, true)
      this.$.emailCodeCollapse.toggle()

  onSetEmailAuthSuccess: (e) ->
      if e.detail.data.result
          @profile.emailAuthEnabled = !@profile.emailAuthEnabled
          this.$.emailCodeCollapse.opened = false
      else
          @fire('display-message', {error: @M.changeEmailAuthError})

  # ============== identity verify =============
  toggleEnableIdentityVerify:() ->
      this.$.identityVerifyCollapse.toggle()

  cancelEnableIdentityVerify: () ->
      this.$.identityVerifyCollapse.opened = false
      this.$.identityVerifyToggle.checked = false

  confirmEnableIdentityVerify: () ->
      this.$.identityVerifyAjax.identityVerify(@realName, @selectedCountry, @selectedIdType, @idNumber)

  onIdentityVerifySuccess: (e) ->
      if e.detail.data.result
          @profile.realName = @realName
          this.$.identityVerifyCollapse.opened = false
          this.$.identityVerifyToggle.checked = true
      else
          @fire('display-message', {error: @M.identityVerifyError})

  # ============== pw changed =============
  toggleChangePw: () ->
      this.$.changepwCollapse.toggle()

  profileChanged: (o, n) ->
      @twoFactorScanInstruction2 = @M.twoFactorScanInstruction2.format(@profile.uid)

  cancelChangePw: () ->
      @toggleChangePw()

  confirmChangePw: () ->
      if @newPw == @confirmPw
          this.$.changePwAjax.changePw(@profile.email, $.sha256b64(@oldPw), $.sha256b64(@newPw))

  checkChangePw: () ->
      @isCPWDisable = !@oldPw || !@newPw || !@confirmPw || (@newPw != @confirmPw)
      if @isCPWDisable
          if !@oldPw || !@newPw || !@confirmPw
              @errorMsg = @M.pwInputError1
          else if @newPw != @confirmPw
              @errorMsg = @M.pwInputError2
      else
          @errorMsg = ""

  onChangePwSuccess: (e) ->
      if e.detail.data.result
          this.$.changepwCollapse.opened = false
      else
          @fire('display-message', {error: @M.changePwFailed})

  addApiToken: () ->
      this.$.addApiTokenAjax.go()

  deleteApiToken: (e) ->
      this.$.deleteApiTokenAjax.deleteApiToken(e.target.getAttribute("tokenId"))

  onAddApiTokenSuccess: (e) ->
      if e.detail.data && e.detail.data.token
          @fire('display-message', {message: @M.addApiTokenSuccess})
          @profile.apiTokenPairs.push [e.detail.data.token, e.detail.data.secret]
      else
          @fire('display-message', {error: @M.addApiTokenError})

  onDeleteApiTokenSuccess: (e) ->
      if e.detail.data && e.detail.data.token
          @fire('display-message', {message: @M.deleteApiTokenSuccess})
          @profile.apiTokenPairs = @profile.apiTokenPairs.filter (t) -> t[0] isnt e.detail.data.token
      else
          @fire('display-message', {error: @M.deleteApiTokenError})
