'use strict'

Polymer 'subpage-message',
  msgMap:
    zh:
      login: "登录"
      register: "还没有账号？注册一个吧。"

      checkEmail:
        label: "Check Your Email"
        details: [
          "We just send you an email for your membership confirmation. You need to click on the link in the email to activate your account.",
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

      passwordSent:
        label: "Check Your Email"
        details: [
          "We just send you an email to with a link to reset your password. Your current password is still valid until a new one is set.",
          "Please give the email a couple of minutes to arrive. If you still don't find it in your mailbox after a while, go ahead and check the spam folder."
          "Thank you."]

      passwordChanged:
        label: "Password Changed"
        details: [
          "Your password has bee successfully changed.",
          "Thank you."]

      loggedOut:
        label: "已经登出"
        details: [
          "您已经成功登出系统。",
          "回见。"]

    en:
      login: "Login"
      register: "Register an account?"
      checkEmail:
        label: "Check Your Email"
        details: [
          "We just send you an email for your membership confirmation. You need to click on the link in the email to activate your account.",
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

      passwordSent:
        label: "Check Your Email"
        details: [
          "We just send you an email to with a link to reset your password. Your current password is still valid until a new one is set.",
          "Please give the email a couple of minutes to arrive. If you still don't find it in your mailbox after a while, go ahead and check the spam folder."
          "Thank you."]

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

  label: 'aaa'
  details: []

  ready: () ->
    @M = @msgMap[window.lang]

  msgChanged: (o, n) ->
    if @msg and @M[@msg]
      @label = @M[@msg].label
      @details = @M[@msg].details
