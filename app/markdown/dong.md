


#Daniel's Developer Notes


##API改进计划

- 显示reserve ratio应该有个API可以拿到所有货币的简单统计

现在的api是每个货币需要单独去拿："/api/open/reserve/btc"，建议支持“/api/open/reserve”显示全部币种。返回值建议为：
```
{
  "labels": ["total", "hot","code", "user"],
  "reserves": {
    "BTC": [100, 10, 20, 70],
    "LTC": [12, 10, 1, 1]
  }
}
```

现在的冗余了，是：
```
{
success: true,
code: 0,
message: "",
data: {
available: {
currency: "BTC",
value_int: 5021767556,
value: 50.21767556,
display: "50.2177",
display_short: "50.22"
},
total: {
currency: "BTC",
value_int: 5021767556,
value: 50.21767556,
display: "50.2177",
display_short: "50.22"
},
user: {
currency: "BTC",
value_int: 0,
value: 0,
display: "0.0000",
display_short: "0.00"
},
hot: {
currency: "BTC",
value_int: 1311834217,
value: 13.11834217,
display: "13.1183",
display_short: "13.12"
},
cold: {
currency: "BTC",
value_int: 3709933339,
value: 37.09933339,
display: "37.0993",
display_short: "37.10"
}
}
}
```
----
----

##URLs
- "login":  "/account/login"
- "profile":  "/account#/accountprofiles"
- "bid":  "/trade/%s/bid"
- "ask":  "/trade/%s/ask"
- "assets":  "/api/account/%s"
- "order":  "/api/user/%s/order/%s"
- CANCEL_ORDER_URL  "/trade/%1$s-%2$s/order/cancel/%3$s"
- TRANSFER_URL  "/api/%1$s/transfer/%2$s"
- TRANSFER_URL = "https://exchange.coinport.com/api/%1$s/transfer/%2$s"
- DEPOSIT_ADDRESS_URL  "/depoaddr/%1$s/%2$s"
- DEPOSIT_ADDRESS_URL = "https://exchange.coinport.com/depoaddr/%1$s/%2$s"
- FEE_URL  "/api/m/fee",
- EMAIL_CODE_URL  "/emailverification"
- WITHDRAWAL_URL  "/account/withdrawal"
- USER_VERIFY_URL  "/account/realnameverify"
- BANK_CARD_URL  "/account/querybankcards"
- ADD_BANK_CARD_URL  "/account/addbankcard"
- RM_BANK_CARD_URL  "/account/deletebankcard"
- CHANGE_PW_URL  "/account/dochangepwd"
- LOGOUT_URL  "/account/logout"
- CAPTCHA_URL  "/captcha"
- REGISTER_URL  "/account/register"

##Questions
- shim-shadowdom
-fire()

---

##URLs
- "login":  "/account/login"
- "profile":  "/account#/accountprofiles"
- "bid":  "/trade/%s/bid"
- "ask":  "/trade/%s/ask"
- "assets":  "/api/account/%s"
- "order":  "/api/user/%s/order/%s"
- CANCEL_ORDER_URL  "/trade/%1$s-%2$s/order/cancel/%3$s"
- TRANSFER_URL  "/api/%1$s/transfer/%2$s"
- TRANSFER_URL = "https://exchange.coinport.com/api/%1$s/transfer/%2$s"
- DEPOSIT_ADDRESS_URL  "/depoaddr/%1$s/%2$s"
- DEPOSIT_ADDRESS_URL = "https://exchange.coinport.com/depoaddr/%1$s/%2$s"
- FEE_URL  "/api/m/fee",
- EMAIL_CODE_URL  "/emailverification"
- WITHDRAWAL_URL  "/account/withdrawal"
- USER_VERIFY_URL  "/account/realnameverify"
- BANK_CARD_URL  "/account/querybankcards"
- ADD_BANK_CARD_URL  "/account/addbankcard"
- RM_BANK_CARD_URL  "/account/deletebankcard"
- CHANGE_PW_URL  "/account/dochangepwd"
- LOGOUT_URL  "/account/logout"
- CAPTCHA_URL  "/captcha"
- REGISTER_URL  "/account/register"

##Questions
- shim-shadowdom
-fire()



##URLs
- "login":  "/account/login"
- "profile":  "/account#/accountprofiles"
- "bid":  "/trade/%s/bid"
- "ask":  "/trade/%s/ask"
- "assets":  "/api/account/%s"
- "order":  "/api/user/%s/order/%s"
- CANCEL_ORDER_URL  "/trade/%1$s-%2$s/order/cancel/%3$s"
- TRANSFER_URL  "/api/%1$s/transfer/%2$s"
- TRANSFER_URL = "https://exchange.coinport.com/api/%1$s/transfer/%2$s"
- DEPOSIT_ADDRESS_URL  "/depoaddr/%1$s/%2$s"
- DEPOSIT_ADDRESS_URL = "https://exchange.coinport.com/depoaddr/%1$s/%2$s"
- FEE_URL  "/api/m/fee",
- EMAIL_CODE_URL  "/emailverification"
- WITHDRAWAL_URL  "/account/withdrawal"
- USER_VERIFY_URL  "/account/realnameverify"
- BANK_CARD_URL  "/account/querybankcards"
- ADD_BANK_CARD_URL  "/account/addbankcard"
- RM_BANK_CARD_URL  "/account/deletebankcard"
- CHANGE_PW_URL  "/account/dochangepwd"
- LOGOUT_URL  "/account/logout"
- CAPTCHA_URL  "/captcha"
- REGISTER_URL  "/account/register"

##Questions
- shim-shadowdom
-fire()



##URLs
- "login":  "/account/login"
- "profile":  "/account#/accountprofiles"
- "bid":  "/trade/%s/bid"
- "ask":  "/trade/%s/ask"
- "assets":  "/api/account/%s"
- "order":  "/api/user/%s/order/%s"
- CANCEL_ORDER_URL  "/trade/%1$s-%2$s/order/cancel/%3$s"
- TRANSFER_URL  "/api/%1$s/transfer/%2$s"
- TRANSFER_URL = "https://exchange.coinport.com/api/%1$s/transfer/%2$s"
- DEPOSIT_ADDRESS_URL  "/depoaddr/%1$s/%2$s"
- DEPOSIT_ADDRESS_URL = "https://exchange.coinport.com/depoaddr/%1$s/%2$s"
- FEE_URL  "/api/m/fee",
- EMAIL_CODE_URL  "/emailverification"
- WITHDRAWAL_URL  "/account/withdrawal"
- USER_VERIFY_URL  "/account/realnameverify"
- BANK_CARD_URL  "/account/querybankcards"
- ADD_BANK_CARD_URL  "/account/addbankcard"
- RM_BANK_CARD_URL  "/account/deletebankcard"
- CHANGE_PW_URL  "/account/dochangepwd"
- LOGOUT_URL  "/account/logout"
- CAPTCHA_URL  "/captcha"
- REGISTER_URL  "/account/register"

##Questions
- shim-shadowdom
-fire()