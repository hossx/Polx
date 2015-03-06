
#币丰港交易平台API

<center>当前版本：2.0</center>

##TODO(xiaolu)

- 很多API的cursor实现不对，而且文档中没有说明cursor是对应返回数据的哪个field。另外cursor是0或者是空字符串的时候API应该正确返回。
- BUG: the hasMore value of /user/deposits is wrong
- BUG? 用已经用过的emai注册，返回值错误码不对。实际上应该明确说明各种错误码，并对密码要求做出说明。
- 增加一个返回huobi,okcoin,coinbase,等其他交易所ticker的api -> /api/v2/external_tickers

---


##我们开始吧
欢迎使用币丰港交易平台REST API，我们提供一系列方便快速的接口，帮助您及时把握市场变化，快速进行交易，以及方便地将币丰港整合进自己的应用中， 通过API，您可以做如下事情：


- 获取市场最新行情
- 获取市场深度和最新成交
- 快速买进卖出
- 获取用户账户信息
- 获取各个虚拟货币相关详细开放数据

要想正确使用币丰港交易平台RESTful API, 建议您仔细阅读我们的「通用规则」，然后再进行具体接口的接入工作。接入过程中，如果遇到任何问题，请联系我们，QQ群：3115-728-063， 电话：（+86）186-2174-1026。


---

##接口列表
目前支持的API列表如下：

  |HTTP 方法        | URL                                              | 说明
  | -------------- | -----------------------                           | ------------
  | GET            | /api/v2/reserve_stats                             | 读取平台所有数字资产的准备金统计数据
  | GET            | /api/v2/tickers                                   | 获取所有市场ticker数据 
  | GET            | /api/v2/external_tickers                          | 获取几个外部BTC市场的ticker数据 
  | GET            | /api/v2/*{currency}*/tickers                      | 获取人民币或比特币所有市场的ticker数据
  | GET            | /api/v2/*{currency}*/reserves                     | 读取平台某数字资产的准备金统详细数据
  | GET            | /api/v2/*{currency}*/balance_snapshot_files       | 读取特定币种的资产分布快照数据文件列表
  | GET            | /api/v2/*{currency}*/transfers                    | 读取特定币种的充值提现记录
  | GET            | /api/v2/*{market}*/trades                         | 获取某市场的历史成交记录
  | GET            | /api/v2/*{market}*/ticker                         | 获取某市场的ticker数据 
  | GET            | /api/v2/*{market}*/depth                          | 获取某市场的深度数据
  | GET            | /api/v2/*{market}*/kline                          | 获取某市场的K线数据
  | POST           | /api/v2/register                                  | 新用户注册
  | GET            | /api/v2/login                                     | 用户登录
  | GET            | /api/v2/logout                                    | 用户登出
  | GET            | /api/v2/user/profile                              | 读取授权用户的基本信息
  | GET            | /api/v2/user/balance                              | 读取用户的账户资产
  | GET            | /api/v2/user/trades                               | 读取用户交易记录
  | GET            | /api/v2/user/orders                               | 读取用户历史订单
  | GET            | /api/v2/user/deposits                             | 读取用户充值记录
  | GET            | /api/v2/user/withdrawals                          | 读取用户提现记录
  | GET            | /api/v2/user/deposit_addresses                    | 读取用户虚拟货币充值地址
  | POST           | /api/v2/user/create_deposit_addr/*{currency}*     | 生成虚拟货币充值地址，如果已经存在，将现存的地址返回
  | POST           | /api/v2/user/submit_orders                        | 批量下单
  | POST           | /api/v2/user/cancel_orders                        | 批量取消订单
  | POST           | /api/v2/user/submit_withdrawal                    | 提交一个提现申请
  | POST           | /api/v2/user/cancel_withdrawal                    | 取消一个提现申请
  | POST           | /api/v2/request_password_reset                    | 提交一个重置密码申请
  | GET            | /api/v2/verify_password_reset_token               | 验证重置密码的Token是否有效
  | POST           | /api/v2/reset_password                            | 重置密码
  | POST           | /api/v2/send_activation_code                      | 发送账号激活码（目前是通过发送含有激活链接的邮件）
  | POST           | /api/v2/check_activation_code                     | 验证账号激活码
  | POST           | /api/v2/user/send_verification_code               | 发送一次性邮件或者手机验证码
  | POST           | /api/v2/user/send_mobile_bind_verify_code         | 发送绑定手机用手机验证码
  | POST           | /api/v2/user/verify_realname                      | 实名认证
  | POST           | /api/v2/user/change_pwd                           | 修改密码
  | POST           | /api/v2/user/update_nickname                      | 更新昵称
  | POST           | /api/v2/user/set_email_auth                       | 设置email认证开启或者关闭
  | POST           | /api/v2/user/set_phone_auth                       | 设置手机认证开启或者关闭
  | POST           | /api/v2/user/bind_or_update_mobile                | 绑定或者更新手机号
  | POST           | /api/v2/user/bind_google_auth                     | 绑定Google Auth
  | POST           | /api/v2/user/unbind_google_auth                   | 解绑Google Auth
  | GET            | /api/v2/user/get_google_auth                      | 获取Google Auth Secret 和Url
  | POST           | /api/v2/user/add_bankcard                         | 绑定银行卡或者支付宝
  | POST           | /api/v2/user/delete_bankcard                      | 解绑银行卡或者支付宝
  | GET            | /api/v2/user/query_bankcards                      | 获取已绑定银行卡或者支付宝信息

---

##通用
###术语约定
- currency/currencies：币种ID，目前支持的币种ID是：

  ```
    BTC, LTC, CNY，BTSX, XRP, BLK, DRK, VRC, ZET,
    NXT, DOGE, GOOC
  ```
- market/markets：交易市场对，目前支持的市场交易对是：
  ```
    BTC-CNY, LTC-CNY, BTSX-CNY, XRP-CNY, GOOC-CNY,
    LTC-BTC, XRP-BTC, BTSX-BTC, DOGE-BTC, BLK-BTC, 
    DRK-BTC, VRC-BTC, ZET-BTC, NXT-BTC
  ```

- order/orders：订单号 ，11位数字编号，如：10000000234。

- order_status：订单状态，其中：
  ```
    0 - 挂单中
    1 - 部分成交
    2 - 完全成交
    3 - 已取消
  ```

- uid：用户ID，是个10位数字编号，如: 1000001023。

- 充值提现状态码：
  ```
    0  - 等待中(Pending)
    1  - 已提交(Accepted)
    2  - 确认中(Confirming)
    3  - 已确认(Confirmed)
    4  - 已成功(Succeeded)
    5  - 已失败(Failed)
    6  - 区块链重组中(Re-organizing)
    7  - 区块链已重组(Re-org OK)
    8  - 已取消(Cancelled)
    9  - 已被拒(Rejected)
    10  - 热钱包不足(Insufficient Hot Wallet)
    11  - 处理中(Processing)
    12~17  - 系统错误(Internal Error)

  ```

- cursor和limit：在几个API URL参数中，我们会用cursor和limit来指定返回数据的起始位置和数量。返回数据不包括cursor指向的那条数据（如果存在），如果想返回ID是0的数据，cursor的值应该是1。如果没有说明，cursor默认值是1，limit的默认值是50。每个API对limit可能与上限设置，如果设定的limit值大于这个上限，系统将用该上限作为limit的实际值。

- hasMore：在一些API的返回数据中，hasMore如果是True，代表有更多数据可以返回；如果是False，代表没有更多数据可以返回。

- timestamp：在一些API的返回数据中，如果没有特别说明，timestamp用来表示返回数据的最后一次更新时间，单位是毫秒。

###通用规则
以下通用规则适用于所有RESTful API：

- 所有请求基于HTTPS协议，API URL的前缀均为：
  ```
    https://exchange.coinport.com
  ```

- 币种ID，市场ID不区分大小写；但返回值JSON中币种和市场ID全部是大写。

- 如果没有特别声明，所有API请求数据为JSON格式（不包括GET请求）。在接口详细说明部分，会在URL前标识该接口的HTTPS请求类型。

- 所有API的返回数据（[DATA]）都被抱在如下结构体中：
  ```
    {
      "code": 0, 
      "time": 12345678012345,
      "data": [DATA]
    }
  ```
  其中：
  - code：错误代码。0表示无错误正常返回，非零表示错误，具体错误码见下面「错误代码表」。在判断API是否正确返回的时候，首先需要判断HTTP status是否为200，然后再判断code是否为0。
  - time：服务器时间，单位是millisecond。
  - data：每个API的数据都作为[DATA]返回。出错情况下，"data"可能是null或者是空字符串。

- 所有以"/api/v2/user/"开头的API都是需要进行认证授权的；其它API无需认证授权即可获取数据。

###错误代码表

  |code          |说明            |
  | ------------ | ------------- |
  | 0    | 无错误，正常返回 |
  | 1001 | 缺少的参数说明,参数：{parameter} |
  | 1002 | 超过流量上限 |
  | 1003 | 系统内部错误 |
  | 1004 | 用户不存在   |
  | 1005 | 用户帐号不可用 |
  | 1006 | 签名不匹配 |
  | 1007 | 不正确或多余的参数：参数：{parameter} |
  | 2002 | 余额不足 |
  | 2003 | 超过下单最小数量，最小交易额必须大于等值1元人民币(人民币市场)或0.001比特币(比特币市场), |
  | 1010 | 不支持的交易对 |
  | 1011 | 订单不存在   |
  | 1012 | 请求url不正确 |
  | 1013 | 币种不存在，币种：{currency}  |
  | 1014 | 认证失败 |
  

---

##认证授权
币丰港交易平台目前支持通过HTTP标准的"Authorization Header"进行认证授权，也支持通过Cookie进行认证授权。  

通过Authorization Header认证流程如下：

###1. 基于用户名密码的认证授权
1. 将用户名和sha256加密过的密码用":"连在一起，得到：
  ```
    username:password
  ```
2. 将上述字符串用Base64进行编码，得到： 
  ```
    dXNlcm5hbWU6cGFzc3dvcmQ=
  ```
3. 将"Basic "（带有一个空格）放置到上面编码前，得到：
  ```
    Basic dXNlcm5hbWU6cGFzc3dvcmQ=
  ```
4. 设置HTTP Header "Authorization"：
  ```
    httpRequest.setHeader("Authorization, "Basic dXNlcm5hbWU6cGFzc3dvcmQ=")
  ```

###2. 基于Token和Secret的认证授权
1. 首先，需在币丰港交易平台网页版或者APP，申请API Token和Secret：
  ```
    Token : 92ad7be8cdd59e230f7528fdfe94c
    Secret : e94d592ad7be28fdf41b08730f7528f8
  ```

2. 然后，用申请得到的Secret对业务请求参数或者数据签名，生成一个签名（Signature)字符串。详见下面的「签名规则」。

3. 如果生成的Signature为：
  ```
    be28f28fef41b08787d3092adf75
  ```
  将Token和Signature用":"连在一起，得到：
  ```
    92ad7be8cdd59e230f7528fdfe94c:be28f28fef41b08787d3092adf75
  ```

2. 将上述字符串用Base64进行编码，得到： 
  ```
    OTJhZDdiZThjZGQ1OWUyMzBmNzUyOGZkZmU5NGM6YmUyOGYyOGZlZjQxYjA4Nzg3ZDMwOTJhZGY3NQ==
  ```
3. 将"Token "（带有一个空格）放置到上面编码前，得到：
  ```
    Token OTJhZDdiZThjZGQ1OWUyMzBmNzUyOGZkZmU5NGM6YmUyOGYyOGZlZjQxYjA4Nzg3ZDMwOTJhZGY3NQ==
  ```
4. 设置HTTP Header "Authorization"：
  ```
    httpRequest.setHeader("Authorization,
      "Token OTJhZDdiZThjZGQ1OWUyMzBmNzUyOGZkZmU5NGM6YmUyOGYyOGZlZjQxYjA4Nzg3ZDMwOTJhZGY3NQ==")
  ```

####签名规则

- GET API接口

如果请求是GET类型，首先将URL参数按照英文字母升序排列。举个例子，如果请求为：
  ```
    https://exchange.coinport.com/the/path?param_c=value1&param_b=value2&param_a=value3
  ```
  那么排好序的URL参数字符串为：
  ```
    param_a=value3&param_b=value2&param_c=value1
  ```
  将这个字符串加上
  ```
    &secret=e94d592ad7be28fdf41b08730f7528f8
  ```
  得到：
  ```
    param_a=value3&param_b=value2&param_c=value1&secret=e94d592ad7be28fdf41b08730f7528f8
  ```
  对这个字符串进行32位MD5计算将得到：
  ```
    MD5("param_a=value3&param_b=value2&param_c=value1&secret=e94d592ad7be28fdf41b08730f7528f8")
    == "1fc7b6fc40c7f377dc4cac4e261e87e3"
  ```
  如果URL没有参数，就直接对
  ```
    &secret=e94d592ad7be28fdf41b08730f7528f8
  ```
  进行上述的MD5计算（注意前面有个&）。


- POST API接口

如果请求类型是POST，请求将不支持URL参数，因此需要对POST的数据加上：
  ```
    &secret=e94d592ad7be28fdf41b08730f7528f8
  ```
  进行MD5签名， 比如请求的JSON为：
  ```
    "{'param1': 'value1','param2': 'value2'}"
  ```
  进行32位MD5得到：
  ```
    MD5("{'param1': 'value1','param2': 'value2'}&secret=e94d592ad7be28fdf41b08730f7528f8")
    == "c3b529fa00a8bc8d0b029d4a2e9d6dd8"
  ```

  同样，如果POST请求数据为空，只需对下列字符串进行加密：
  ```
    &secret=e94d592ad7be28fdf41b08730f7528f8
    ```    

####认证失败
  如果认证失败，我们会返回HTTP 401错误
  ```
    {
      "code": 1014, 
      "time": 14423452342,
    }
  ```

###3. 基于Cookie的认证授权
如果Authorization Header为空，我们会检查Cookie进行认证授权。但如果Authorization Header不为空，Cookie就会被忽略。

调用login API成功后，认证授权所用的cookie会被设置。因此为了安全，在应用退出的时候建议客户端删除所有币丰港相关的cookie。


---

##接口详细说明

### GET /api/v2/reserve_stats
读取平台所有数字资产的准备金统计数据。

####URL参数
无

####返回值示例
```
  {
    "DRK"  : [274.08532934,328.04122726,0.0,602.1265566],
    "VRC"  : [13059.45018843,10628.5443864,24.4798,23712.47437483],
    "XRP"  : [301122.108213,0.0,0.0,301122.108213],
    "NXT"  : [26205.01432827,0.0,3.0,26208.01432827],
    "ZET"  : [26906.57422377,19332.05778996,0.0,46238.63201373],
    "LTC"  : [494.53869164,928.63038698,0.0,1423.16907862],
    "BTC"  : [7.05849568,45.66859572,0.0,52.7270914],
    "BC"   : [11200.77066364,18749.39076667,0.0,29950.16143031],
    "DOGE" : [4355087.92647075,4931466.49035176,2129.4304499,9288683.84727241],
    "BTSX" : [917607.06473,0.0,0.0,917607.06473]
   }

```

对于法币和不是基于区块链的资产，该API不返回其储备金情况。

- stats：数组中的数值分别代表 [热钱包中资产数量, 冷钱包中资产数量, 用户充值地址中资产数量, 平台应付款总额]。存备金率 = (热钱包中资产数量 + 冷钱包中资产数量 + 用户充值地址中资产数量) / 平台应付款总额。

####示例

 - [https://exchange.coinport.com/api/v2/reserve_stats](https://exchange.coinport.com/api/v2/reserve_stats)

<br><br>

### GET /api/v2/tickers
获取所有市场ticker数据。
  
####返回值示例
  ```
    {
      "LTC-CNY" : [11.91,12.11,11.16,2902.40675502,0.045654082528533764],
      "NXT-BTC" : [5.116E-5,5.24E-5,5.116E-5,4068.638,-0.02366412213740461],
      "BC-BTC"  : [8.728E-5,8.747E-5,8.25E-5,248.70040274,0.026823529411764687],
      "XRP-BTC" : [8.0E-5,0.0,0.0,0.0,0.0],
      "BTSX-CNY": [0.064,0.0669,0.063,328543.23098442,-0.033232628398791535],
      "BTSX-BTC": [4.43E-5,4.62E-5,4.235E-5,3145.93151424,-0.028508771929824515],
      "ZET-BTC" : [4.5E-6,0.0,0.0,0.0,0.0],
      "DOGE-BTC": [6.3E-7,6.5E-7,6.2E-7,230048.97273492,-0.015625000000000014],
      "XRP-CNY" : [0.083,0.0858,0.081,299436.932516,-0.005988023952095772],
      "LTC-BTC" : [0.0081,0.0081,0.0078,6.55837298,0.025316455696202375],
      "VRC-BTC" : [9.221E-5,0.0,0.0,0.0,0.0],
      "DRK-BTC" : [0.008197,0.0,0.0,0.0,0.0],
      "BTC-CNY" : [1427.26,1540.0,1403.95,38.07539626,-0.0355895211259992],
      "GOOC-CNY": [0.0045,0.0052,0.0037,6944541.44135094,0.2162162162162162]
    }
  ```
返回值中数组中的数字依次代表：[最近成交价，24小时最高价，24小是最低价，24小时成交量, 24小时涨跌幅]。

####示例
 - [https://exchange.coinport.com/api/v2/tickers](https://exchange.coinport.com/api/v2/tickers)

<br><br>


### GET /api/v2/external_btc_tickers
获取几个外部BTC市场的ticker数据。
  
####返回值示例
  ```
    {
      "BTC-CNY": {
        "HUOBI" : [11.91,12.11,11.16,2902.40675502,0.045654082528533764],
        "OKCOIN" : [5.116E-5,5.24E-5,5.116E-5,4068.638,-0.02366412213740461]
        "LAKEBTC" : [5.116E-5,5.24E-5,5.116E-5,4068.638,-0.02366412213740461]
      },
      "BTC-USD": {
        "COINBASE"  : [8.728E-5,8.747E-5,8.25E-5,248.70040274,0.026823529411764687],
        "BITSTAMP" : [8.0E-5,0.0,0.0,0.0,0.0]
      }
    }
  ```
返回值中数组中的数字依次代表：[最近成交价，24小时最高价，24小是最低价，24小时成交量, 24小时涨跌幅]。

####示例
 - [https://exchange.coinport.com/api/v2/tickers](https://exchange.coinport.com/api/v2/tickers)

<br><br>

### GET /api/v2/*{currency}*/tickers
获取人民币或比特币所有市场的ticker数据。
  
####URL参数
- currency：cny或btc。

####返回值示例
  ```
    {
      "LTC-CNY" : [11.91,12.11,11.16,2854.24295615,0.04657293497363805],
      "XRP-CNY" : [0.083,0.0858,0.081,293447.750002,-0.0012033694344163169],
      "BTC-CNY" : [1427.26,1540.0,1403.95,37.38919626,-0.04060712389172335],
      "GOOC-CNY": [0.0045,0.0052,0.0037,6912541.44135094,0.1842105263157895]
      "BTSX-CNY": [0.064,0.0669,0.063,322450.42061992,-0.033232628398791535],
    }
  ```
返回值中数组中的数字依次代表：[最近成交价，24小时最高价，24小是最低价，24小时成交量, 24小时涨跌幅]。

####示例
 - [https://exchange.coinport.com/api/v2/cny/tickers](https://exchange.coinport.com/api/v2/cny/tickers)
 - [https://exchange.coinport.com/api/v2/btc/tickers](https://exchange.coinport.com/api/v2/btc/tickers)
 
<br><br>





### GET /api/v2/*{currency}*/reserves
读取平台某数字资产的准备金统详细数据。

####URL参数
- currency：任何基于区块链的货币ID。

####返回值示例
```
  {
    "timestamp":1423017359101,
    "currency":"BTC",
    "stats":[52.54756817,0.0,6.87897245,45.66859572],
    "distribution":[
      ["15WSBo1FRXQ7qKQms9qAWGvsTMxxRLrHt3",
        0.43030544,
        "hot",
        "coinport",
        "H4FGaDo7P3Hm+HnGMEnb/s8fXEuYJQ2vrlIDqN2H7jlWu2CfmDaC/vSkVtzlvidjgDvDQEeoe3Xovft9pomHpFc="
      ],
      [
        "1E6T55vPxz27kaouY8zcoLyLYqg7aLBv8f",
        0.17774047,
        "hot",
        "coinport",
        "ILQHBgYRiowSjfvOSFz/l008Dks/pcktekh5a+vntxGxLYnbuP6hmvJ1bCgfu0/N9mbe+qp98jKbBjPWMYyphAE="
      ],
      ["1CKScR6b5WBRdMm4BjTqdwiEbbBJzH59Pa",
        0.15424199,
        "hot",
        "coinport",
        "H2MNC+f5a29iTLuWs2yn/5MgOGi3rTev+HY/dX40rZ9t3Xzmyo3Ni12me2S9OIeclJaPcIpe2HBV+u4oq9Fm1j4="
      ],
      [
        "17w6wtD3FHnNTbR27jgiN7fSNp7j1gE4uv",
        1.29283246,
        "hot",
        "coinport",
        "H+2TIX6gXpZYeYT6Hye+ePZVnPDtJk5DjVA82Lnau44fSeEYG3Nvb7boibZN51r6nNHWfmhRKrZFqGZJ3L6nhIU="
      ],
      [
        "1GbJtdiidFnbsGfuC5VtMKrRaoyrP2rRXk",
        45.66859572,
        "cold",
        "coinport",
        "H0YkvkM11/6tVddcu8dr+TEzhKjNuXVTn1ckaJJQOc0IVoAkCrhiA9CUFUWvTXRBL+DwLgPUrWi7gHnD+LBLztw="
      ]
    ]
  }

```
- stats中的数字代表：[热钱包中资产数量, 冷钱包中资产数量, 用户充值地址中资产数量, 平台应付款总额]。存备金率 = (热钱包中资产数量 + 冷钱包中资产数量 + 用户充值地址中资产数量) / 平台应付款总额。
- distribution中每个数组代表：[地址，金额，地址属性，原始消息，消息签名]。其中地址属性是"cold"，"hot"，"user"之一。

####举例

- [https://exchange.coinport.com/api/v2/btc/reserves](https://exchange.coinport.com/api/v2/btc/reserves)
- [https://exchange.coinport.com/api/v2/ltc/reserves](https://exchange.coinport.com/api/v2/ltc/reserves)

<br><br>





### GET /api/v2/*{currency}*/balance_snapshot_files
读取特定币种的资产分布快照数据文件列表。

####URL参数
- currency：货币ID。
- cursor：请参考「术语约定」。该接口cursor为文件列表中时间戳。
- limit：请参考「术语约定」，默认值50，上限100。

####返回值示例
```
{
  "hasMore":true,
  "currency":"btc",
  "path":"https://exchange.coinport.com/download/csv/asset/btc/",
  "items":[
    ["btc_balance_20150204023309.csv",6037,1423017188827],
    ["btc_balance_20150204013232.csv",6045,1423013552511],
    ["btc_balance_20150204123154.csv",6045,1423009914072],
    ["btc_balance_20150203113111.csv",6045,1423006270880],
    ["btc_balance_20150203103032.csv",6017,1423002631863],
    ["btc_balance_20150203092952.csv",6016,1422998992336],
    ["btc_balance_20150203082914.csv",6016,1422995354688],
    ["btc_balance_20150203072838.csv",6016,1422991717938],
    ["btc_balance_20150203062801.csv",6014,1422988081195],
    ["btc_balance_20150203052723.csv",6015,1422984443277]
  ]
}

```

####示例
- [https://exchange.coinport.com/api/v2/ltc/balance_snapshot_files](https://exchange.coinport.com/api/v2/ltc/balance_snapshot_files) - 读取最新50条LTC资产分布快照数据文件列表。
- [https://exchange.coinport.com/api/v2/btc/balance_snapshot_files?cursor=1121321&limit=20](https://exchange.coinport.com/api/v2/btc/balance_snapshot_files?cursor=1121321&limit=20) - 读取1121321之前的20条BTC资产分布快照数据文件列表。

<br><br>

### GET /api/v2/*{currency}*/transfers
读取特定币种的充值提现记录。

####URL参数
- currency：货币ID。
- cursor：请参考「术语约定」。
- limit：请参考「术语约定」，默认值50，上限100。

####返回值示例
```
{
  "hasMore": true,
  "currency": "BTC",
  "transfers": [
    {
      "id": 1000000051345,
      "uid" : 1000001368,
      "amount" : 0.201,
      "status" : 4,
      "created" : 1423038158050
      "updated" : 1423038354650
      "operation" : 1,
      "address" : "1BnNn2LsVbn8DDWx5ABrDF1Vkc2epchf7Z",
      "txid" : "1b94cf14800be1c01d24e0a1341fa3be671e5e15f2f9499dd162af35d9dd4b54"
    },
    {
      "id":"1000000050168",
      "uid":"1000002398",
      "amount":0.00615391,
      "status":4,
      "created":1422967424668,
      "updated":1422968245204,
      "operation":1,
      "address":"1DcM6bDFGAKsAhYthCkXphEZYxBZpmcidc",
      "txid":"74aede0a71d959c2a4b82a88d2ac3fabedb5d84b4ddc7e0d42cca602a7c965f9"
    }
  ],
}

```

####示例
- [https://exchange.coinport.com/api/v2/ltc/transfers](https://exchange.coinport.com/api/v2/ltc/transfers) - 读取最新50条LTC资产分布快照数据文件列表。
- [https://exchange.coinport.com/api/v2/btc/transfers?cursor=1121321&limit=20](https://exchange.coinport.com/api/v2/btc/transfers?cursor=1121321&limit=20) - 读取1121321之前的20条BTC资产分布快照数据文件列表。

<br><br>




### GET /api/v2/*{market}*/trades
获取某市场的历史成交记录。
 

####URL参数
- market：市场ID。
- cursor：请参考「术语约定」，此处值为订单号，即对应返回数据中的"trade_id"项。
- limit：请参考「术语约定」，默认值100，上限200。

####返回值示例
```
  {
    "hasMore":true,
    "market":"btc-cny",
    "trades":[
      {
        "id":"1000001556370001",
        "timestamp":1423015417056,
        "price":1427.26011673,
        "amount":0.0514,
        "maker":"1000001436",
        "taker":"1000001436",
        "isSell":true,
        "taker_order_id":"1000001556370",
        "maker_order_id":"1000001556368"
      },
      {
        "id":"1000001556367001",
        "timestamp":1423015412568,
        "price":1427.25992218,
        "amount":0.0514,
        "maker":"1000001436",
        "taker":"1000001436",
        "isSell":false,
        "taker_order_id":"1000001556367",
        "maker_order_id":"1000001556366"
      }
    ]
  }

```

####示例
- [https://exchange.coinport.com/api/v2/btc-cny/trades](https://exchange.coinport.com/api/v2/btc-cny/trades)

<br><br>


### GET /api/v2/*{market}*/ticker
获取某市场的ticker数据。
  
####URL参数
- market：市场ID。

####返回值示例
```
  {
    "XRP-CNY":[0.083,0.0858,0.081,287460.127894,-0.0071770334928228825]
  }
```
返回值中数组中的数字依次代表：[最近成交价，24小时最高价，24小是最低价，24小时成交量, 24小时涨跌幅]。

####示例
 - [https://exchange.coinport.com/api/v2/btc-cny/ticker](https://exchange.coinport.com/api/v2/btc-cny/ticker)
 
<br><br>


### GET /api/v2/*{market}*/depth
获取某市场的深度数据。

####URL参数
- market：市场ID。
- limit：请参考「术语约定」，默认值100，上限200。

####返回值示例
```

  {
    "asks":[
      [0.0045,49333.33211111],
      [0.0046,30250.71739131],
      [0.0047,82950.0],
      [0.0048,101699.00032501],
      [0.0049,96209.64566734]
    ],
    "bids":[
      [0.0044,71032.56136363],
      [0.0043,155084.43950465],
      [0.0042,140362.0],
      [0.0041,201951.2195],
      [0.004,556350.65]
    ]
  }
  
```
####示例
 - [https://exchange.coinport.com/api/v2/gooc-cny/depth?limit=5](https://exchange.coinport.com/api/v2/gooc-cny/depth?limit=5)

<br><br>


### GET /api/v2/*{market}*/kline
获取某市场的K线（OHLC）数据。

####URL参数
- market：市场ID。
- interval：K线数据聚合粒度，必须是"1m, 5m, 15m, 30m, 1h, 2h, 4h, 6h, 1d"的值之一，默认为"5m"。其中m代表分钟，h代表小时，d代表天。
- start：数据时间戳的起始时间（不包含），默认为end时间戳往前追溯90个interval时间单元的时间戳.
- end：数据时间戳的结束时间（包含），默认为当前时间。 end必须大于start返回结果才可能非空。

####返回值示例
```
{
  "items": [
    [1422992700000,1426.47,1426.47,1426.47,1426.47,0.0966],
    [1422993000000,1430.0,1435.0,1429.83,1435.0,0.14600001],
    [1422993300000,1432.6,1432.6,1432.6,1432.6,0.0976],
    [1422993600000,1432.6,1432.6,1432.6,1432.6,0.0],
    [1422993900000,1432.6,1432.6,1432.6,1432.6,0.0],
  ]
}
  
```
items中的每条数据是一个长度为6的数组，依次表示：[时间戳，开盘价，最高价，最低价，收盘价，成交量]。


####示例
 - [https://exchange.coinport.com/api/v2/btc-cny/kline?interval=1m&start=1421560886](https://exchange.coinport.com/api/v2/btc-cny/kline?interval=1m&start=123456&end=678900)

<br><br>

### POST /api/v2/register
新用户注册。
####URL参数
无
####POST数据JSON格式
```
  {
    "email": "example@coinport.com",
    "pwdhash": "G41DK2iy8OmzdTgpjPKXFvI82wI6CEj/BfaGdfGNDgQ=", // pwdhash 生成方法为：BASE64.encode(SHA256(pwd))
    "exchangeVersion": "v2", // 可选字段，如果要填，目前只支持v2, 为x.coinport.com
    "lang": "zh" // 1. zh 使用中文邮件模板, 2. en 使用英文邮件模板
  }
```
####返回值示例
```
  {
    "uid": 1000008765
  }
```
pwdhash生成方法：本例中登录密码为：cppwdtest, 经过sha256散列后, 再将散列后byte数组进行base64.encode操作得到G41DK2iy8OmzdTgpjPKXFvI82wI6CEj/BfaGdfGNDgQ= 
profile中的pwdhash将不会被返回。
<br><br>

### GET /api/v2/login
用户登录。这个API的主要作用是首先通过基于用户名和密码的认证授权从服务器拿到Cookie，从而可以后续对API进行基于Cookie的认证授权。
对于APP，不建议调用该API。

Authorizaton Header设置请参考签名的「1.基于用户名密码的认证授权」。为了安全，应用在退出的时候，Cookie应该被清空。

####URL参数
无

####POST数据JSON格式
无

####返回值示例
```
  {
    "uid": 1000003723,
    "email":"example@coinport.com"
  }
```
profile中的pwdhash将不会被返回。

<br><br>

### GET /api/v2/logout
清空用户浏览器Cookie，使得用户登出系统。该API无需任何授权。



####URL参数
无


####返回值
无

<br><br>


### GET /api/v2/user/profile
读取授权用户的基本信息
####URL参数
无
####返回值示例
```
  {
    "uid":1000009818,
    "email":"example@coinport.com",
    "mobile":"+8618683748216",
    "apiTokenPairs":[
      ["023487592348963336","2349898b7cf9623ac99f877d7074ea"]
    ],
    "emailVerified":true,
    "mobileVerified":true,
    "googleAuthEnabled":false
  }

```

<br><br>



### GET /api/v2/user/balance
读取用户的账户资产。
####URL参数
无
####返回值示例
```
  {
    "BTC":[0.03820923,12.0650945,0.0,12.10671868],
    "CNY":[16844.23683,4118.18394,0.0,20962.42077]
  }
  
```

返回长度为4的类型数组，依次为：[可用余额，冻结余额，待提现余额，总余额]。

<br><br>




### GET /api/v2/user/trades
读取用户交易记录。

####URL参数
- market：市场ID。如果不设置，将返回所有市场的交易记录。
- cursor：请参考「术语约定」，此处值为交易记录ID，即对应返回数据中的"trade_id"项。
- limit：请参考「术语约定」，默认值100，上限200。
- ids：逗号分隔的成交记录ID列表。该参数如被设置，market，cursor,和limit将被忽略。

####返回值示例
```
  {
    "hasMore":true,
    "market":"",
    "trades":[
      {"id":"1000001559302001","timestamp":1423047779299,"price":1395.0,"amount":0.0513,"maker":"1000001418","taker":"1000001418","isSell":false,"taker_order_id":"1000001559302","maker_order_id":"1000001558499","market":"BTC-CNY"},
      {"id":"1000001559288001","timestamp":1423047600607,"price":1395.0,"amount":0.0123,"maker":"1000001418","taker":"1000001418","isSell":false,"taker_order_id":"1000001559288","maker_order_id":"1000001558499","market":"BTC-CNY"},
      {"id":"1000001559273002","timestamp":1423047426723,"price":1394.99977422,"amount":0.01173707,"maker":"1000001418","taker":"1000001418","isSell":false,"taker_order_id":"1000001559273","maker_order_id":"1000001558499","market":"BTC-CNY"},
      {"id":"1000001559273001","timestamp":1423047426723,"price":1395.00054494,"amount":0.00486293,"maker":"1000001418","taker":"1000001418","isSell":false,"taker_order_id":"1000001559273","maker_order_id":"1000001558465","market":"BTC-CNY"},
      {"id":"1000001559260001","timestamp":1423047244363,"price":1395.0,"amount":0.0141,"maker":"1000001418","taker":"1000001418","isSell":false,"taker_order_id":"1000001559260","maker_order_id":"1000001558465","market":"BTC-CNY"}
    ]
  }

```

<br><br>



###GET /api/v2/user/orders
读取用户历史订单。

####URL参数
- market：市场ID。如果不设置，将返回所有市场的订单记录。
- cursor：请参考「术语约定」，此处值为订单ID，即对应返回数据中的"order_id"项。
- limit：请参考「术语约定」，默认值50，上限200。
- order_status：订单状态码，默认获取所有状态的订单。
- ids：逗号分隔的订单号列表。该参数如被设置，market，cursor,limit和order_status将被忽略。

####返回值示例
```
  {
    "hasMore":true,
    "orders":[
      {"id":"1000001559354","operation":"buy","status":2,"market":"BTC-CNY","price":1410.0,"amount":0.0418,"dealed_amount":0.04180001,"created":1423048326815},
      {"id":"1000001559353","operation":"buy","status":2,"market":"BTC-CNY","price":1405.0,"amount":0.0841,"dealed_amount":0.08410001,"created":1423048324891},
      {"id":"1000001559352","operation":"buy","status":2,"market":"BTC-CNY","price":1395.0,"amount":0.0278,"dealed_amount":0.0278,"created":1423048322451},
      {"id":"1000001559337","operation":"buy","status":2,"market":"BTC-CNY","price":1415.0,"amount":0.0231,"dealed_amount":0.0231,"created":1423048145503},
      {"id":"1000001559335","operation":"buy","status":2,"market":"BTC-CNY","price":1405.0,"amount":0.0777,"dealed_amount":0.0777,"created":1423048143495},
      {"id":"1000001559334","operation":"buy","status":2,"market":"BTC-CNY","price":1400.0,"amount":0.0981,"dealed_amount":0.09810001,"created":1423048141450}
    ]
  }
  
```
返回结果按订单号生成时间降序排列。


####示例
- [https://exchange.coinport.com/api/v2/user/orders?market=btc-cny&cursor=1000000732928&limit=100&order_status=1](https://exchange.coinport.com/api/v2/user/orders?market=btc-cny&cursor=1000000732928&limit=100&order_status=1) - 读取BTC-CNY市场从订单号1000000732928开始往前的100条状态为完全成交的所有订单。
- [https://exchange.coinport.com/api/v2/user/orders?ids=100001,100002](https://exchange.coinport.com/api/v2/user/orders?ids=100001,100002) - 读取ID为100001和100002两个订单的数据。

<br><br>





### GET /api/v2/user/deposits
读取用户充值记录。

####URL参数
- currency：货币ID。如果不设置，将返回所有货币的订单记录。
- cursor：请参考「术语约定」，此处值为充值记录ID，即对应返回数据中的"transfer_id"项。
- limit：请参考「术语约定」，默认值30，上限200。
- ids：逗号分隔的充值记录ID列表。该参数如被设置，currency，cursor,和limit将被忽略。

####返回值示例
```
  {
    "hasMore":false,
    "deposits":[
      {"id":"1000000048316","currency":"BTC","quantity":4.7072,"status":4,"created":1422852175162,"updated":1422852516540,"address":"147vEoThzNZSrrFi9r38s8pPapwzBr8VEF"},
      {"id":"1000000006267","currency":"BTC","quantity":15.0,"status":4,"created":1418041606175,"updated":1418041731709,"address":"147vEoThzNZSrrFi9r38s8pPapwzBr8VEF"},
      {"id":"1000000006265","currency":"CNY","quantity":20000.0,"status":4,"created":1418040570952,"updated":1418040574192,"address":""}
    ]
  }

```

<br><br>





### GET /api/v2/user/withdrawals
读取用户提现记录。

####URL参数
- currency：货币ID。如果不设置，将返回所有货币的订单记录。
- cursor：请参考「术语约定」，此处值为充值记录ID，即对应返回数据中的"transfer_id"项。
- limit：请参考「术语约定」，默认值30，上限200。
- ids：逗号分隔的提现记录ID列表。该参数如被设置，currency，cursor,和limit将被忽略。

####返回值示例
```

  {
    "hasMore":false,
    "withdrawals":[
      {"id":"1000000043734","currency":"BTC","quantity":4.0,"status":4,"created":1422240608809,"updated":1422242067482,"address":"17ZFHKXPqoxeHcCTiJ5CZrKLrUJN1TD7Uj"},
      {"id":"1000000006284","currency":"BTC","quantity":1.0,"status":4,"created":1418108185885,"updated":1418110469452,"address":"138WcJM1RnPLp5TQJwNcTwZgjUJpgQ3pU6"},
      {"id":"1000000006283","currency":"BTC","quantity":1.0,"status":4,"created":1418107690265,"updated":1418108145168,"address":"138WcJM1RnPLp5TQJwNcTwZgjUJpgQ3pU6"}
    ]
  }

```

<br><br>



### GET /api/v2/user/deposit_addresses
读取用户的虚拟货币充值地址。
####URL参数
无
####返回值示例
```

   {
    "GOOC":"",
    "DRK":"Xdyx1saNYDovgjTuPUA7CerJw9uNTAA9ED",
    "VRC":"VDPX7rZN4SSXnsfXjnpdx7cJmsQZwHMirA",
    "XRP":"",
    "NXT":"5108275052447562865//NXT-2Z5K-53Q4-WKWM-6X3TF//4eb53cf353efb667e103fe9bb332737ce52bf2a7816cb9240145078dde78e106",
    "ZET":"ZKAA177LfzFHAKpEXtMr2K55UGVgCwxtAR",
    "LTC":"LNpsrBnWhL7hmzyQgMsGhVJb87NzeE2kWn",
    "BTC":"147vEoThzNZSrrFi9r38s8pPapwzBr8VEF",
    "BC":"BJRHTqbqpp5767Sj7R7uhRU11CsfvmDZ3s",
    "DOGE":"DCXhmCU3tnNEh5kBEHoMkLfeU1Sw47R2XA",
    "BTSX":""
  }

```

<br><br>


### POST /api/v2/user/create_deposit_addr/*{currency}*
生成虚拟货币充值地址，如果已经存在，将现存的地址返回。
####URL参数
- currency：货币ID。

####返回值示例
```
  {
    "BTC":"147vEoThzNZSrrFi9r38s8pPapwzBr8VEF"
  }
```

<br><br>




### POST /api/v2/user/submit_orders
批量下单, 一次请求最多下单量为10个。

####POST数据JSON格式
```
  {
    "orders" : [
      {
        "market" : "btc-cny",
        "operation" : "sell",
        "price" : 2100.2,
        "amount" : 0.23
      }, {
        "market" : "xrp-cny",
        "operation" : "buy",
        "price" : 1800,
        "amount" : 0.23
      }, {
        "market" : "ltc-cny",
        "operation" : "buy",
        "price" : 5,
        "amount" : 0.4
    ]
  }
```
####返回值示例
```
  
  {
    "results":[
      {"order_id":"1000001559603"},
      {"order_id":"0","code":"2003"},
      {"order_id":"1000001559605"}
    ]
  }

```
返回结果中订单号和下单顺序一致，如果下单失败，order_id为0， 并且会有非零的code。


<br><br>
### POST /api/v2/user/cancel_orders
批量取消订单。

####POST数据JSON格式
```
  {"order_ids": [1000000001606, 1000001559603, 1000001559604]}

```
####返回值示例
```
  {
    "cancelled" :[
      1000001559603，
      1000001559604
    ],
    "failed": [
      1000000001606
    ]
  }
  
```
<br><br>



### POST /api/v2/user/submit_withdrawal
提交一个提现申请。
提现根据用户安全设置需要填入email，手机，googleAuth验证码(用户设置的是什么，就要填什么)。
虚拟货币的提现，address填写目标地址，人民币提现参考下面提现人民币地址。
nxt提现，需要指定nxt_public_key字段。
btsx提现，需要指定memo字段。

####POST数据JSON格式

- 提现BTC：

```
  {
     "currency" : "BTC",
     "address" ： "17ZFHKXPqoxeHcCTiJ5CZrKLrUJN1TD7Uj",
     "amount" : 0.1,
     "emailUuid" : "09f1317a-2e57-44ad-a561-2c225ea6f32f",
     "emailCode" : "184762",
     "phoneUuid" : "0d16a76f-ab21-4002-8f71-d75b4c83ee7b",
     "phoneCode" : "837532",
     "googleCode" : "284758"
  }
```

- 提现NXT：

```
  {
     "currency" : "BTC",
     "address" ： "17ZFHKXPqoxeHcCTiJ5CZrKLrUJN1TD7Uj",
     "amount" : 0.1,
     "nxt_public_key" ："NXT-YP69-FGG3-GV6R-3A5BN", // nxt币提现用publicKey，其他币种不需要填写这个字段
     "memo": "btc38-btsx-octo-72722" // BTSX提现memo，其他币种不需要填写这个字段
  }
```

- 提现人民币：

```
  {
    "currency":"CNY",
    "address":"吴小露|cny1@coinport.com|支付宝|,
    "amount": 3
  }

```

####返回值示例
```
  {
    "tranfer_id" : 1000000051916,
    "withdraw_status" : 0
  }
```
<br><br>



### POST /api/v2/user/cancel_withdrawal
提交一个提现申请。

####POST数据JSON格式
```
  {
     "tranfer_id" : 1000000051918
  }
```

####返回值示例
```
  {
    "result":"Ok"
  }

```

### POST /api/v2/request_password_reset
提交一个重置密码申请。

####POST数据JSON格式
```
  {
    "email": "example@coinport.com",
    "exchangeVersion": "v2", // 可选字段，如果要填，目前只支持v2, 为x.coinport.com
    "lang": "zh" // 1. zh 使用中文邮件模板, 2. en 使用英文邮件模板
  }
```

####返回值示例

```
  {
    "result" : true
  }

```

### GET /api/v2/verify_password_reset_token?token={Token}
验证重置密码的Token是否有效

####URL参数
- token：重置密码需要的token

####返回值示例

```
  {
    "result" : true
  }

```

### POST /api/v2/reset_password
重置密码。

####POST数据JSON格式
```
  {
    "token" : "HJ4SFGGKBDGKXSYANTGK45G7LQJXK76M6ZE4C6QK",
    "pwdHash": "tZwid9Lea5GPGPfBBU0xIQIZdnaly2k6fBdGf7plFMA="
  }
```

####返回值示例

```
  {
    "result" : true
  }

```

### POST /api/v2/send_activation_code
发送账号激活码（目前是通过发送含有激活链接的邮件）

####POST数据JSON格式
```
  {
    "email" : "example@coinport.com",
    "exchangeVersion": "v2", // 可选字段，如果要填，目前只支持v2, 为x.coinport.com
    "lang": "zh" // 1. zh 使用中文邮件模板, 2. en 使用英文邮件模板
  }
```

####返回值示例

```
  {
    "result" : true
  }
```

### GET /api/v2/check_activation_code?token={token}
验证账号激活码。

####返回值示例

```
  {
    "result" : true
  }
```

### POST /api/v2/user/send_verification_code
发送一次性邮件或者手机验证码。

####POST数据JSON格式
```
  {
    "toPhone" : true, // 邮箱和手机至少一个
    "toEmail" : false // 邮箱和手机至少一个
  }
```

####返回值示例

```
  {
    "sentToPhone" : true,
    "phoneUuid" : "xsd03-sdfkx-sdkfj-23kjs-23jx7",
    "sentToEmail" : false // 发送成功才会有uuid返回, uuid在校验验证码一并发送给服务器
  }
```

### POST /api/v2/user/send_mobile_bind_verify_code
发送手机绑定用手机验证码。

####POST数据JSON格式
```
  {
    "phone" : "13873647282"
  }
```

####返回值示例

```
  {
    "phoneUuid" : "xsd03-sdfkx-sdkfj-23kjs-23jx7"
  }
```

### POST /api/v2/user/verify_realname
实名认证

####POST数据JSON格式
```
  {
    "realName" : "吴小野",
    "location" : "zh-CN", // 1. zh-CN：中国; 2. USA: 美国; 3. other: 其他
    "identiType" : "idcard" // 1. idcard: 身份证; 2. passport: 护照号
    "idNumber" : "421012198909090813" // 身份证号或者护照号
  }
```

####返回值示例

```
  {
    "result" : true
  }
```

### POST /api/v2/user/change_pwd
修改密码

####POST数据JSON格式
```
  {
    "email" : "cp_test_1@coinport.com",
    "oldPassword" : "FU80PoZJqdWXvKRCiG11uv4s/z8usqqs5+w1w+N3rsU=", // 密码明文先做sha256加密，再做base64加密出来地结果
    "newPassword" : "0Plg7TSi3ahiD6mN4cVbS6WxPvtkgFkXAxkJnnYHHUE=" // 密码明文先做sha256加密，再做base64加密出来地结果
  }
```

####返回值示例

```
  {
    "result" : true
  }
```

### POST /api/v2/user/update_nickname
修改昵称

####POST数据JSON格式
```
  {
    "nickname" : "testnickname"
  }
```

####返回值示例

```
  {
    "result" : true
  }
```

### POST /api/v2/user/set_email_auth
开启或者关闭email认证

####POST数据JSON格式
```
  {
    "uuid" : "xsd03-sdfkx-sdkfj-23kjs-23jx7",
    "emailCode" : "902348",
    "emailPrefer" : "1", // 1, 打开; 0, 关闭
  }
```

####返回值示例

```
  {
    "result" : true
  }
```

### POST /api/v2/user/set_phone_auth
开启或者关闭手机认证

####POST数据JSON格式
```
  {
    "uuid" : "xsd03-sdfkx-sdkfj-23kjs-23jx7",
    "phoneCode" : "902348",
    "phonePrefer" : "1", // 1, 打开; 0, 关闭
  }
```

####返回值示例

```
  {
    "result" : true
  }
```

### POST /api/v2/user/bind_or_update_mobile
绑定或者更新手机号

####POST数据JSON格式
```
  {
    "mobile" : "18747576234", // 要绑定或者更新地手机号
    "verifyCodeUuidOld" : "5cf04b35-9465-4997-9ab3-94c57b3c9afa", // 第一次绑定手机号时，不需要填写
    "verifyCodeOld" : "385573", // 第一次绑定手机号时，不需要填写
    "verifyCodeUuid" : "93488234-sd98j3-123-234kx7-sdkfj",
    "verifyCode" : "734650"
  }
```

####返回值示例

```
  {
    "result" : true
  }
```

### POST /api/v2/user/bind_google_auth
绑定Google Auth

####POST数据JSON格式
```
  {
    "googlesecret" : "FR6YLCDLCJS7ZQX6",
    "googlecode" : "932457"
  }
```

####返回值示例

```
  {
    "result" : true
  }
```

### POST /api/v2/user/unbind_google_auth
解除绑定Google Auth

####POST数据JSON格式
```
  {
    "googlecode" : "932457"
  }
```

####返回值示例

```
  {
    "result" : true
  }
```

### GET /api/v2/user/get_google_auth
获取Google Auth Secret 和 生成二维码Url

####返回值示例

```
  {
    "authUrl" : "otpauth://totp/COINPORT:1000000015?secret=L3KSDNX5FSJCZBGK",
    "secret" : "FR6YLCDLCJS7ZQX6"
  }
```

### POST /api/v2/user/add_bankcard
绑定银行卡或者支付宝

####POST数据JSON格式
```
  {
    "bankName" : "招商银行",
    "U_RN" : "吴三",
    "cardNumber" : "2934723894572398749",
    "branchBankName" : "海淀支行",
    "emailUuid" : "4417aede-b09b-49eb-83be-7b71d86eb6a8",
    "emailCode" : "239048"
  }
```

####返回值示例

```
  {
    "result" : true
  }
```
### POST /api/v2/user/delete_bankcard
删除银行卡或者支付宝

####POST数据JSON格式
```
  {
    "cardNumber" : "2934723894572398749"
  }
```

####返回值示例

```
  {
    "result" : true
  }
```

### GET /api/v2/user/get_google_auth
获取Google Auth Secret 和 生成二维码Url

####返回值示例

```
  [
    {
      "bankName":"中国银行",
      "ownerName":"吴三桂",
      "cardNumber":"293749237598232342",
      "branchBankName":"海淀支行"
    },
    {
      "bankName":"招商银行",
      "ownerName":"吴三",
      "cardNumber":"234234235723894234",
      "branchBankName":"海淀支行2"
    }
  ]
```
