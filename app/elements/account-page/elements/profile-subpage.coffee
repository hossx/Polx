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
      twoFactorScanInstruction1: "Scan the following QR code with your Google Authenticator app."
      twoFactorScanInstruction2: "Input the 6-digit code (taggd with COINPORT:%s) from your Google Authenticator app , then click Confirm."
      inputPlaceholder: "6-digit code"
      cancel: "Cancel"
      confirm: "Confirm"
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
      twoFactorScanInstruction1: "请用谷歌Authenticator APP扫描下面的二维码。"
      twoFactorScanInstruction2: "输入谷歌Authenticator APP中标记为 COINPORT:%s 的6位数字，然后点击确认按钮。"
      inputPlaceholder: "6位数字"
      cancel: "取消"
      confirm: "确认"

  ready: () ->
    @M = @msgMap[window.lang]

  toggleEnableGoogleAuth: (e) ->
    this.$.enableGoogleAuthCollapse.toggle()

  profileChanged: (o, n) ->
    @twoFactorScanInstruction2 = @M.twoFactorScanInstruction2.format(@profile.uid)