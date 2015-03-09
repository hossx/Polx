'use strict'

Polymer 'subpage-message',
  msgMap:
    zh:
      login: "登录"
      register: "还没有账号？注册一个吧。"

      checkEmail:
        label: "请检查邮箱"
        details: [
          "感谢您注册币丰港交易所账号。我们刚刚发送了一封email给您，请点击其中的链接对您的邮箱进行验证。",
          "如果您几分钟后依然没收到邮件，请检查下垃圾邮件。"
          "谢谢。"]

      emailVerified:
        label: "邮箱验证完成"
        details: [
          "我们已经验证了您的邮箱。",
          "现在您可以使用币丰港进行各种交易了。"]

      emailVerificationFailed:
        label: "邮箱验证失败"
        details: [
          "您试图使用的邮箱验证令牌无效。",
          "请您重试。"]

      pwresetTokenSent:
        label: "请检查邮箱"
        details: [
          "如果您的email已经在币丰港注册，您将很快收到重置密码的email。请按照其中的指示操作。",
          "如果您几分钟后依然没收到邮件，请检查下垃圾邮件。"
          "谢谢。"]

      activationTokenSent:
        label: "请检查邮箱"
        details: [
          "如果您的email已经在币丰港注册并且还未被验证，您将很快收到激活邮箱的email。请按照其中的指示操作。",
          "如果您几分钟后依然没收到邮件，请检查下垃圾邮件。"
          "谢谢。"]

      pwresetTokenInvalid:
        label: "无法重置密码"
        details: [
          "您试图使用的重置密码令牌无效。",
          "你需要再次请求重置密码。"]

      passwordChanged:
        label: "密码更改成功"
        details: [
          "您的密码已经更改成功。",
          "谢谢。"]

      loggedOut:
        label: "已登出系统"
        details: [
          "您已经成功登出系统。",
          "回见。"]

    en:
      login: "Login"
      register: "Don't have an acccount? Register Now"
      checkEmail:
        label: "Check Your Email"
        details: [
          "We just send you an email for your account confirmation. You need to click on the link in the email to activate your account.",
          "Please give the email a couple of minutes to arrive. If you still don't find it in your mailbox after a while, go ahead and check the spam folder."
          "Thank you."]

      emailVerified:
        label: "Email Verified"
        details: [
          "We have verified your email address.",
          "You can take advantage of all Coinport services."
          "Happy trading!"]

      emailVerificationFailed:
        label: "Email Verification Failed"
        details: [
          "We cannot verify your email address.",
          "You many need to try again."]

      pwresetTokenSent:
        label: "Check Your Email"
        details: [
          "If your email has been registered already, we will send you an email with a link to reset your password. Your current password is still valid until a new one is set.",
          "Please give the email a couple of minutes to arrive. If you still don't find it in your mailbox after a while, go ahead and check the spam folder."
          "Thank you."]

      activationTokenSent:
        label: "Check Your Email"
        details: [
          "If your email has been registered already and your email has not been verified yet, we will send you an email with a link to verify your email.",
          "Please give the email a couple of minutes to arrive. If you still don't find it in your mailbox after a while, go ahead and check the spam folder."
          "Thank you."]

      pwresetTokenInvalid:
        label: "Unable to Reset Password"
        details: [
          "Your token for resetting password is invalid.",
          "You many need to try again."]


      passwordChanged:
        label: "Password Changed"
        details: [
          "Your password has bee successfully changed.",
          "Thank you."]

      loggedOut:
        label: "Logged Out"
        details: [
          "You have successfully logged out.",
          "See you soon."]

  label: ''
  details: []

  ready: () ->
    @M = @msgMap[window.lang]

  msgChanged: (o, n) ->
    if @msg and @M[@msg]
      @label = @M[@msg].label
      @details = @M[@msg].details
