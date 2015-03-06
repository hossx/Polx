'use strict'

Polymer 'profile-subpage',
  msgMap:
    'en':
      profile: "Profile"
      userId: "User ID"
      name: "Name"
      cellphone: "Cell Number"
      apiTokens: "API Tokens"
      token: "Token"
      secret: "Secret"
      twoFactorAuth: "Two-factor Auth Enabled"
      cellphoneVerified: "Cellphone Verified"
      emailVerified: "Email Verified"
      identityVerify: "Identity Verification"
      identityVerified: "Verified"
      twoFactorScanInstruction1: "Scan the following QR code with your Google Authenticator app."
      twoFactorScanInstruction2: "Input the 6-digit code (taggd with COINPORT:%s) from your Google Authenticator app , then click Confirm."
      inputPlaceholder: "6-digit code"
      cancel: "Cancel"
      confirm: "Confirm"
      realname: "real name"
      id: "ID"
      country: "China"
      idType: "ID Card"
      china: "China"
      america: "America"
      elseCountry: "Else Country"
      idCard: "ID Card"
      password: "Passport"
      loginPassword: "Login password"
      changePassword: "Change password"
      cancelChangePassword: "Cancel"
      cellphoneNumber: "Phone number"
      bindCellphone: "Bind phone"
      cancelBindCellphone: "Cancel"
      smsCode: "Sms verification code"
      sendSmsCode: "Send sms code"
      oldPw: "Old password"
      newPw: "New password"
      confirmPw: "Confirm new password"
      smsHasBeenSent: "Sms code has been sent, please input the sms code:"
      emailAddress: "Email address"
      bindEmail: "Bind email"
      cancelBindEmail: "Cancel"
      emailCode: "Email code"
      sendEmailCode: "Send email code"
      emailHasBeenSent: "Email code has been sent, please input the email code:"
      bindGoogleAuthError: "Fail to bind google auth"
      unbindGoogleAuthError: "Fail to unbind google auth"
      disableGoogleAuth: "Disable google auth"
      confirmPwFailed: "Password not consitent"
      changePwFailed: "Change password failed"
      identityVerifyError: "Identity verify fail"
    'zh':
      profile: "账户"
      userId: "用户识别号"
      name: "姓名"
      cellphone: "手机号码"
      apiTokens: "API Token列表"
      token: "Token"
      secret: "Secret"
      twoFactorAuth: "二次验证"
      cellphoneVerified: "手机验证"
      emailVerified: "邮箱验证"
      identityVerify: "实名认证"
      identityVerified: "已认证"
      twoFactorScanInstruction1: "请用谷歌Authenticator APP扫描下面的二维码。"
      twoFactorScanInstruction2: "输入谷歌Authenticator APP中标记为 COINPORT:%s 的6位数字，然后点击确认按钮。"
      inputPlaceholder: "6位数字"
      cancel: "取消"
      confirm: "确认"
      realname: "真实姓名"
      id: "证件号码"
      country: "中国"
      idType: "身份证"
      china: "中国"
      america: "美国"
      elseCountry: "其他地区"
      idCard: "身份证"
      passport: "护照"
      loginPassword: "登陆密码"
      changePassword: "修改密码"
      cancelChangePassword: "取消修改"
      cellphoneNumber: "手机号码"
      bindCellphone: "绑定手机"
      cancelBindCellphone: "取消绑定"
      smsCode: "短信验证码"
      sendSmsCode: "发送短信验证码"
      oldPw: "当前密码"
      newPw: "新密码"
      confirmPw: "确认新密码"
      smsHasBeenSent: "验证短信已发送，请输入短信验证码："
      emailAddress: "邮箱地址"
      bindEmail: "绑定手机"
      cancelBindEmail: "取消绑定"
      emailCode: "邮件验证码"
      sendEmailCode: "发送邮件验证码"
      emailHasBeenSent: "验证邮件已发送，请输入邮件验证码："
      bindGoogleAuthError: "绑定谷歌二次验证码失败"
      unbindGoogleAuthError: "解除绑定谷歌二次验证码失败"
      disableGoogleAuth: "解除双重校验绑定"
      confirmPwFailed: "两次输入的密码不一致"
      changePwFailed: "修改密码失败"
      identityVerifyError: "实名验证失败"

  ready: () ->
    @M = @msgMap[window.lang]
    @selectedCountry = "zh-CN"
    @selectedIdType = "idcard"

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
  toggleBindCellphoneCollapse:() ->
      this.$.bindCellphoneCollapse.toggle()

  cancelBindCellphone:() ->
      this.$.bindCellphoneCollapse.toggle()
  confirmBindCellphone:() ->
      this.$.bindCellphoneCollapse.toggle()

  cancelEnableCellphoneVerify:() ->
      this.$.cellphoneToggleButton.checked = !this.$.cellphoneToggleButton.checked
      @toggleEnableCellphoneAuth()

  confirmEnableCellphoneVerify:() ->
      @toggleEnableCellphoneAuth()

  toggleEnableCellphoneAuth: (e) ->
      this.$.cellphoneSmsCodeCollapse.toggle()

  # ============== email =============
  toggleBindEmailCollapse:() ->
      this.$.bindEmailCollapse.toggle()

  cancelBindEmail:() ->
      this.$.bindEmailCollapse.toggle()
  confirmBindEmail:() ->
      this.$.bindEmailCollapse.toggle()

  cancelEnableEmailVerify:() ->
      this.$.emailToggleButton.checked = !this.$.emailToggleButton.checked
      @toggleEnableEmailAuth()

  confirmEnableEmailVerify:() ->
      @toggleEnableEmailAuth()

  toggleEnableEmailAuth: (e) ->
      if not @profile.emailVerified
          this.$.emailVerifyCollapse.toggle()
      else
          this.$.emailCodeCollapse.toggle()

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
      if @newPw != @confirmPw
          @fire('display-message', {error: @M.confirmPwFailed})
      else
          this.$.changePwAjax.changePw(@profile.email, $.sha256b64(@oldPw), $.sha256b64(@newPw))

  onChangePwSuccess: (e) ->
      if e.detail.data.result
          this.$.changepwCollapse.opened = false
      else
          @fire('display-message', {error: @M.changePwFailed})
