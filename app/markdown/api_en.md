
#Coinport Exchange API

<center>Version: 1.1</center>

---

## Document Not Ready Yet
We opened our exchange APIs, but haven't had time to translate this document into English yet. Sorry about that. 

##API List


  |HTTP Method     | URL                                               | 
  | -------------- | -----------------------                           | 
  | GET            | /api/v2/reserve_stats                             | 
  | GET            | /api/v2/tickers                                   | 
  | GET            | /api/v2/*{currency}*/external_tickers             | 
  | GET            | /api/v2/*{currency}*/tickers                      | 
  | GET            | /api/v2/*{currency}*/reserves                     | 
  | GET            | /api/v2/*{currency}*/balance_snapshot_files       | 
  | GET            | /api/v2/*{currency}*/transfers                    | 
  | GET            | /api/v2/*{market}*/trades                         | 
  | GET            | /api/v2/*{market}*/ticker                         | 
  | GET            | /api/v2/*{market}*/depth                          | 
  | GET            | /api/v2/*{market}*/kline                          | 
  | POST           | /api/v2/register                                  | 
  | GET            | /api/v2/login                                     | 
  | GET            | /api/v2/logout                                    | 
  | GET            | /api/v2/user/profile                              | 
  | GET            | /api/v2/user/balance                              | 
  | GET            | /api/v2/user/trades                               | 
  | GET            | /api/v2/user/orders                               | 
  | GET            | /api/v2/user/deposits                             | 
  | GET            | /api/v2/user/withdrawals                          | 
  | GET            | /api/v2/user/deposit_addresses                    | 
  | POST           | /api/v2/user/create_deposit_addr/*{currency}*     | 
  | POST           | /api/v2/user/submit_orders                        | 
  | POST           | /api/v2/user/cancel_orders                        | 
  | POST           | /api/v2/user/submit_withdrawal                    | 
  | POST           | /api/v2/user/cancel_withdrawal                    | 
  | POST           | /api/v2/request_password_reset                    | 
  | POST           | /api/v2/reset_password                            | 
  | POST           | /api/v2/send_activation_code                      | 
  | POST           | /api/v2/verify_activation_code                    | 
  | POST           | /api/v2/user/send_verification_code               | 
  | POST           | /api/v2/user/send_mobile_bind_verify_code         | 
  | POST           | /api/v2/user/verify_realname                      | 
  | POST           | /api/v2/user/change_pwd                           | 
  | POST           | /api/v2/user/update_nickname                      | 
  | POST           | /api/v2/user/set_email_auth                       | 
  | POST           | /api/v2/user/set_phone_auth                       | 
  | POST           | /api/v2/user/bind_or_update_mobile                | 
  | POST           | /api/v2/user/bind_google_auth                     | 
  | POST           | /api/v2/user/unbind_google_auth                   | 
  | GET            | /api/v2/user/get_google_auth                      | 
  | POST           | /api/v2/user/add_bankcard                         | 
  | POST           | /api/v2/user/delete_bankcard                      | 
  | GET            | /api/v2/user/query_bankcards                      | 
  | POST           | /api/v2/user/add_api_token                        |
  | POST           | /api/v2/user/delete_api_token                     | 

In case you have any questions, please drop us a line [exchange-support@coinport.com](mailto:exchange-support@coinport.com).
