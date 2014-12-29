
      ###
      "login":  "/account/login"
      "profile":  "/account#/accountprofiles"
      "bid":  "/trade/%s/bid"
      "ask":  "/trade/%s/ask"
      "assets":  "/api/account/%s"
      "order":  "/api/user/%s/order/%s"
      CANCEL_ORDER_URL  "/trade/%1$s-%2$s/order/cancel/%3$s"
      TRANSFER_URL  "/api/%1$s/transfer/%2$s"
      TRANSFER_URL = "https://exchange.coinport.com/api/%1$s/transfer/%2$s"
      DEPOSIT_ADDRESS_URL  "/depoaddr/%1$s/%2$s"
      DEPOSIT_ADDRESS_URL = "https://exchange.coinport.com/depoaddr/%1$s/%2$s"
      FEE_URL  "/api/m/fee",
      EMAIL_CODE_URL  "/emailverification"
      WITHDRAWAL_URL  "/account/withdrawal"
      USER_VERIFY_URL  "/account/realnameverify"
      BANK_CARD_URL  "/account/querybankcards"
      ADD_BANK_CARD_URL  "/account/addbankcard"
      RM_BANK_CARD_URL  "/account/deletebankcard"
      CHANGE_PW_URL  "/account/dochangepwd"
      LOGOUT_URL  "/account/logout"
      CAPTCHA_URL  "/captcha"
      REGISTER_URL  "/account/register"
      ###


- shim-shadowdom
-fire()