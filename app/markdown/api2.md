
#币丰港交易所API（v2.0）

##我们开始吧
欢迎使用币丰港交易所RESTful API，我们提供一系列方便快速的接口，帮助您及时把握市场变化，快速进行交易，以及方便地将币丰港整合进自己的应用中， 通过API，您可以做如下事情：

- 获取市场最新行情
- 获取市场深度和最新成交
- 快速买进卖出
- 获取用户账户信息
- 获取各个虚拟货币相关详细开放数据

要想正确使用币丰港交易所RESTful API, 建议您仔细阅读我们的通用规则，然后再进行具体接口的接入工作。接入过程中，如果遇到任何问题，请联系我们，QQ：3115728063， 电话：（+86）18621741026。

---

##术语约定
- [currency_id]：币种ID。比如：BTC, LTC, CNY，BTSX, XRP, DOGE, GOOC, BLK, DRK, VRC, ZET, NXT。
- [market_id]：交易市场对ID。比如：BTC-CNY, LTC-CNY, BTSX-CNY, XRP-CNY, GOOC-CNY, LTC-BTC, XRP-BTC, BTSX-BTC, DOGE-BTC, BLK-BTC, DRK-BTC, VRC-BTC, ZET-BTC, NXT-BTC。
- [order_id]：订单号。11位数字编号：10000000234。
- [order_status]：订单状态。0表示挂单中，1表示完全成交，2表示部分成交，3表示已取消。
- [user_id]：用户ID。10位数字编号: 1000001023

---

##通用规则
以下规则适用于所有HTTPS RESTful API：

- 所有请求基于HTTPS协议，API URL的前缀均为：`https://exchange.coinport.com`
- 针对读取或者更改用户隐私信息的API，调用时需要做用户数据签名校验，并随其他数据一起发送，签名方法见下面的签名规则。
- URL中的币种ID，市场ID不区分大小写；但返回值JSON中币种和市场ID全部是大写。
- 如果没有特别声明，所有API请求数据为JSON格式（不包括GET请求）。在接口详细说明部分，会在URL前标识该接口的HTTP请求类型。
- 所有API的返回数据[DATA]都被抱在如下结构体中：
  ```
  {
    "code": 0, 
    "time": 12345678012345,
    "data": [DATA]
  }
  ```
  其中：
  - code：错误代码。0表示无错误正常返回，非零表示错误，具体错误码见下面列表说明。在判断API是否正确返回的时候，首先需要判断HTTP status是否为200，然后再判断code是否为0.
  - time：服务器时间，单位是millisecond。
  - data：每个API的数据都作为[DATA]返回。出错情况下，"data"可能是null。



---
##错误代码表

  |code|说明|
  | ------------ | ------------- |
  | 0    | 无错误，正常返回 |
  | 1001 | 缺少的参数说明,参数：{parameter} |
  | 1002 | 超过流量上限 |
  | 1003 | 系统内部错误 |
  | 1004 | 用户不存在   |
  | 1005 | 用户帐号不可用 |
  | 1006 | 签名不匹配 |
  | 1007 | 不正确或多余的参数：参数：{parameter} |
  | 1008 | 余额不足 |
  | 1009 | 超过下单最小数量，最小交易额必须大于等值1元人民币 |
  | 1010 | 不支持的交易对 |
  | 1011 | 订单不存在   |
  | 1012 | 请求url不正确 |
  | 1013 | 币种不存在，币种：{currency}  |


---

##签名规则
- 生成待签名字符串  
  
  按照参数名字母顺序排列，组成类似于这样的序列：参数名1=参数值1＆参数名2=参数值2＆参数名3=参数值3...

```
  请求参数：
  
  {
    "user_id" : 1000001010L
    "type" : "buy"
    "currency" : "btc"
    "price" : 2000
    "amount" : 0.01
    "atestparam" : "123"
  }
  
  组成的待签名序列(注意最后加上secret_key=ksd723jc7j1xjksd3n41, secret_key不参与排序)：
  
  amount=0.01&atestparam=123&currency=btc&price=2000&type=buy&secret_key=ksd723jc7j1xjksd3n41
  
  
```

- 使用32位MD5加密字符串。  

```
  md5加密：
  
    md5("amount=0.01&atestparam=123&currency=btc&price=2000&type=buy&secret_key=ksd723jc7j1xjksd3n41")
  
  结果为：
    
    3770f02dd594efdfe941b087304753a6
  
  也就是说，最终您的请求参数为：
  
    {
      "user_id" : 1000001010L
      "type" : "buy"
      "currency" : "btc"
      "price" : 2000
      "amount" : 0.01
      "atestparam" : "123"
      "secret_key" : "3770f02dd594efdfe941b087304753a6"
    }

```

---

##GET /api/v2/reserves
读取平台数字资产的准备金统计数据。

####URL参数
无

####返回值
```
  {
    "timestamp": 12123213213121,
    "reserves": {
      "BTC" : [10,  20, 70, 99 ],
      "LTC" : [12,  10, 1,  25 ],
      "GOOC": [10,  20, 70, 101],
      "BC"  : [12,  10, 1,  23 ],
      "BTSX": [10,  10, 20, 30 ],
      "XRP" : [120, 10, 1,  150]
    }
  }

```
对于法币和不是基于区块链的资产，该API不返回其储备金情况。

  - timestamp：数据更新时间，单位为millisecond。
  - reserves：数组中的数值分别代表 [热钱包中资产数量, 冷钱包中资产数量, 用户充值地址中资产数量, 平台应付款总额]。存备金率 = (热钱包中资产数量 + 冷钱包中资产数量 + 用户充值地址中资产数量) / 平台应付款总额。



####示例

 - [https://exchange.coinport.com/api/v2/reserves](https://exchange.coinport.com/api/v2/reserves)

---

## GET /api/v2/reserves/[currencyId]
读取平台某数字资产的准备金统详细数据。

####URL参数
无

####返回值
```
  {
    "timestamp": 12123213213121,
    "currency": "BTC",
    "reserves": [10, 20, 70, 99],
    "distribution": [
      ["1N9eMy14zYA6H7Rpn7dpErxgmdbjLk6iW4",
        12.1121, 
        "hot",
        "coinport", 
        "H5mC9Q4ILstd0PxROJn/gEDjutY7HIW8zZ9EmpMcTikvOrP0VeGWQI8iMIuQu2ByChF+uc0gLelHl49Bi9e+Y1M="],
      ["1N9eMy14zYA6H7Rpn7dpErxgmdbjLk6iW4",
        12.1121, 
        "hot",
        "coinport", 
        "H5mC9Q4ILstd0PxROJn/gEDjutY7HIW8zZ9EmpMcTikvOrP0VeGWQI8iMIuQu2ByChF+uc0gLelHl49Bi9e+Y1M="],
      ["1N9eMy14zYA6H7Rpn7dpErxgmdbjLk6iW4",
        12.1121, 
        "cold",
        "coinport", 
        "H5mC9Q4ILstd0PxROJn/gEDjutY7HIW8zZ9EmpMcTikvOrP0VeGWQI8iMIuQu2ByChF+uc0gLelHl49Bi9e+Y1M="],
      ["1N9eMy14zYA6H7Rpn7dpErxgmdbjLk6iW4",
        12.1121, 
        "cold",
        "coinport", 
        "H5mC9Q4ILstd0PxROJn/gEDjutY7HIW8zZ9EmpMcTikvOrP0VeGWQI8iMIuQu2ByChF+uc0gLelHl49Bi9e+Y1M="],
      ["1N9eMy14zYA6H7Rpn7dpErxgmdbjLk6iW4",
        12.1121, 
        "user",
        "coinport", 
        "H5mC9Q4ILstd0PxROJn/gEDjutY7HIW8zZ9EmpMcTikvOrP0VeGWQI8iMIuQu2ByChF+uc0gLelHl49Bi9e+Y1M="]
    ]
  }
```
timestamp的时间是数据更新时间，单位为millisecond。

reserves中的数字代表：[热钱包中资产数量, 冷钱包中资产数量, 用户充值地址中资产数量, 平台应付款总额]。存备金率 = (热钱包中资产数量 + 冷钱包中资产数量 + 用户充值地址中资产数量) / 平台应付款总额。

distribution中每个数组代表：[地址，金额，地址属性，原始消息，消息签名]。其中地址属性是"cold"，"hot"，"user"之一。

####举例

- [https://exchange.coinport.com/api/v2/reserves/btc](https://exchange.coinport.com/api/v2/reserves/btc)
- [https://exchange.coinport.com/api/v2/reserves/btc](https://exchange.coinport.com/api/v2/reserves/ltc)


---
## GET /api/v2/asset_snapshots/[currencyId]
读取特定币种的资产分布快照数据文件列表。

####URL参数
无

####返回值

```
{
  "timestamp": "12/12/12",
  "currency": "BTC",
  "hasMore": true,
  "snapshots": [
    [123456, "01-01 15:06:00", "file-aaf-fafaf.json", 121311],
    [123456, "01-01 15:06:00", "file-aaf-fafaf.json", 121311],
    [123456, "01-01 15:06:00", "file-aaf-fafaf.json", 121311],
    [123456, "01-01 15:06:00", "file-aaf-fafaf.json", 121311],
    [123456, "01-01 15:06:00", "file-aaf-fafaf.json", 121311],
    [123456, "01-01 15:06:00", "file-aaf-fafaf.json", 121311],
    [123456, "01-01 15:06:00", "file-aaf-fafaf.json", 121311],
    [123456, "01-01 15:06:00", "file-aaf-fafaf.json", 121311],
    [123456, "01-01 15:06:00", "file-aaf-fafaf.json", 121311],
    [123456, "01-01 15:06:00", "file-aaf-fafaf.json", 121311],
    [123456, "01-01 15:06:00", "file-aaf-fafaf.json", 121311],
    [123456, "01-01 15:06:00", "file-aaf-fafaf.json", 121311]
  ]
}
```

timestamp的时间是数据更新时间，单位为millisecond。

####举例

- /api/open/asset_snapshots/btc?limit=50 读取btc详细数据
- /api/open/asset_snapshots/btc?cursor=1121321&limit=50 读取btc详细数据


---
## GET /api/v2/cryptotxs/[currencyId]
读取特定币种与平台相关的blockchain转账记录列表。

- /api/open/cryptotxs/btc?limit=50 读取btc详细数据
- /api/open/cryptotxs/btc?cursor=1121321&limit=50 读取btc详细数据

####返回值
```
{
  "timestamp": "12/12/12",
  "currency": "BTC",
  "hasMore": true,
  "txs": [
    [123456, "01-01 15:06:00", "121321312", "deposit", 2012, "dfjdajfdlajfldjsalfjdajffdjsfalj", "1xfdasfsafdasafea"],
    [123456, "01-01 15:06:00", "121321312", "deposit", 2012, "dfjdajfdlajfldjsalfjdajffdjsfalj", "1xfdasfsafdasafea"],
    [123456, "01-01 15:06:00", "121321312", "deposit", 2012, "dfjdajfdlajfldjsalfjdajffdjsfalj", "1xfdasfsafdasafea"],
    [123456, "01-01 15:06:00", "121321312", "deposit", 2012, "dfjdajfdlajfldjsalfjdajffdjsfalj", "1xfdasfsafdasafea"],
    [123456, "01-01 15:06:00", "121321312", "deposit", 2012, "dfjdajfdlajfldjsalfjdajffdjsfalj", "1xfdasfsafdasafea"],
    [123456, "01-01 15:06:00", "121321312", "deposit", 2012, "dfjdajfdlajfldjsalfjdajffdjsfalj", "1xfdasfsafdasafea"],
    [123456, "01-01 15:06:00", "121321312", "deposit", 2012, "dfjdajfdlajfldjsalfjdajffdjsfalj", "1xfdasfsafdasafea"],
    [123456, "01-01 15:06:00", "121321312", "deposit", 2012, "dfjdajfdlajfldjsalfjdajffdjsfalj", "1xfdasfsafdasafea"],
    [123456, "01-01 15:06:00", "121321312", "deposit", 2012, "dfjdajfdlajfldjsalfjdajffdjsfalj", "1xfdasfsafdasafea"],
    [123456, "01-01 15:06:00", "121321312", "deposit", 2012, "dfjdajfdlajfldjsalfjdajffdjsfalj", "1xfdasfsafdasafea"],
    [123456, "01-01 15:06:00", "121321312", "deposit", 2012, "dfjdajfdlajfldjsalfjdajffdjsfalj", "1xfdasfsafdasafea"],
    [123456, "01-01 15:06:00", "121321312", "deposit", 2012, "dfjdajfdlajfldjsalfjdajffdjsfalj", "1xfdasfsafdasafea"],
    [123456, "01-01 15:06:00", "121321312", "deposit", 2012, "dfjdajfdlajfldjsalfjdajffdjsfalj", "1xfdasfsafdasafea"]
  ]
}
```

---
## GET /api/v2/ticker/[currency_pair]
获取行情数据

####返回值
```
  "data":{ 
  "buy":"7.79",  //买1价
  "sell":"7.83", //卖1价
  "high":"8.28", //24小时内最高价
  "low":"7.51",  //24小时内最低价
  "last":"7.74", //最近成交价
  "vol":"6662.6767"  //24小时成交量
  }
  
```

---
## GET /api/v2/depth/[currency_pair]?limit=[limit]
获取深度数据, 默认返回前30条深度, 最大200条, 通过limit指定条数

####请求示例
```
  /api/open/depth/btc-cny // 默认返回30条深度
  /api/open/depth/btc-cny?limit=50 // 返回50条深度
```

####返回值
```
"data":{
  "asks": [
    [792, 5],
    [789.68, 0.018],
  [788.99, 0.042],
  [788.43, 0.036],
  [787.2...  //此处省略其余数据
  ],
  "bids": [
  [787.1, 0.35],
  [787, 12.071],
  [786.5, 0.014],
  [786.2, 0.38],
  [785.04, 5... //此处省略其余数据
  ]
}
  
```

---
## GET /api/v2/trades/[currency_pair]?since=[start_timestamp]
获取历史成交, 默认获取最新200条成交记录，如果提供since参数，则从since时间戳开始，向前追溯200条返回

####返回值
```
"data":{
  "count": 200
  "items": [
    {
      "type" : "sell", // 交易类型
      "price" : 1000.23,
      "amount" : 0.34,
      "order_id" : 1000000732928,
      "date" : 1421560886 // 交易时间
    }
  ]
}
  
```

---
## GET /api/v2/user/profile
读取用户的profile
```
{
  "uid": 12345678,
  "name": "wangdong",
  "email": "dong77@gmail.com",
  "mobile": "+86 18817728171",
  "apiToken": "8c0781b2402a9907af4e68cb8f982767",
  "emailVerified": true,
  "mobileVerified": true,
  "googleAuthEnabled": false
}
```

---
## GET /api/v2/user/assets
读取用户的assets
```
{
  "DRK": [1,2,3,6],
  "BTC": [1,2,3,6],
  "VRC": [1,2,3,6],
  "LTC": [1,2,3,6],
  "CNY": [1,2,3,6]
}
```

[available, locked, pendingwithdrawal, total]

---
## GET /api/v2/user/cryptoaddrs
读取用户的虚拟货币deposit地址

```
{
  "DRK": "fjdajfdjsalfjdlsafj",
  "BTC": "fjdajfdjsalfjdlsafj",
  "VRC": "fjdajfdjsalfjdlsafj",
  "LTC": "fjdajfdjsalfjdlsafj",
  "CNY": "fjdajfdjsalfjdlsafj",
}
```

---
## POST /api/v2/user/cryptoaddr

```
{
  currencies: ["BTC", "LTC"]
}
```

读取用户的虚拟货币deposit地址，如果没有，系统先生成一个。
```
{
  "BTC": "fjdajfdjsalfjdlsafj"
}
```

### GET /api/v2/user/deposits?currency=btc&cursor=xxx&limit=12
读取用户某个币种的deposit记录
```
  "data": {
    "hasMore": true,
    "deposits": [{
      "id": 1000000000320,
      "created": 118271181818,
      "updated": 118271181818,
      "quantity": 10,
      "status": "Succeeded",
      "address": "fdafdsafidsaiofdslafjdasfjafa"
    }, {
      "id": 1000000000320,
      "created": 118271181818,
      "updated": 118271181818,
      "quantity": 10,
      "status": "Succeeded",
      "address": "fdafdsafidsaiofdslafjdasfjafa"
    }, {
      "id": 1000000000320,
      "created": 118271181818,
      "updated": 118271181818,
      "quantity": 10,
      "status": "Succeeded",
      "address": "fdafdsafidsaiofdslafjdasfjafa"
    }, {
      "id": 1000000000320,
      "created": 118271181818,
      "updated": 118271181818,
      "quantity": 10,
      "status": "Succeeded",
      "address": "fdafdsafidsaiofdslafjdasfjafa"
    }, {
      "id": 1000000000320,
      "created": 118271181818,
      "updated": 118271181818,
      "quantity": 10.9,
      "status": "Succeeded",
      "address": "fdafdsafidsaiofdslafjdasfjafa"
    }, {
      "id": 1000000000320,
      "created": 118271181818,
      "updated": 118271181818,
      "quantity": 10,
      "status": "Succeeded",
      "address": "fdafdsafidsaiofdslafjdasfjafa"
    }]
  }
```

---
## POST /api/v2/user/order
交易

####POST参数
```
  {
    "user_id" : 1000000001,
    "currdency_pair" : "btc-cny",
    "orders" : [
      {
        "type" : "sell",
        "price" : 2100.2,
        "amount" : 0.23
      },
      {
        "type" : "buy",
        "price" : 1800,
        "amount" : 0.23
      }
      ....
    ],
    "sign" : "3770f02dd594efdfe941b087304753a6"
  }

```
####返回值
```
  "data":{
    "results" : [
      {"order_id" : 1000000732928 }
      {"error_code" : 1003, "order_id" -1 }
      ....
    ]
  }
  
```

---
## DEL /api/user/order
取消订单

####DEL参数
```
  {
    "user_id" : 1000000001,
    "order_id" : "1000000732928",
    "sign" : "3770f02dd594efdfe941b087304753a6"
  }

```
####返回值
```
  "data":{
    "result" : true
  }
  
```

---
## GET /api/v2/user/order?ids=[id1,id2]
查询订单详情

####返回值
```
  "data":{
    "order_id" :  "1000000732928"
    "type" : "sell",
    "status" : 1,
    "currency_pair" : "btc-cny",
    "price" : 2010.3,
    "amount" : 0.23,
    "dealed_amount" : 0.11,
    "create_time" : 1421560886,
    "last_update_time" : 1421560993,
  }
  
```

---
## GET /api/v2/user/orders?market=[trading-pair]&start=[order-id]&limit=[limit]&status=[status]
查询个人订单, 默认返回50条,如果超过50条，通过分页获取，page默认值为1，status代表订单状态码

####返回值
```
  "data":{
    "orders" : [
      {
        "order_id" :  "1000000732928"
        "type" : "sell",
        "status" : 1,
        "currency_pair" : "btc-cny",
        "price" : 2010.3,
        "amount" : 0.23,
        "dealed_amount" : 0.11,
        "create_time" : 1421560886,
        "last_update_time" : 1421560993,
      },
      {
        "order_id" :  "1000000834523"
        "type" : "buy",
        "status" : 2,
        "currency_pair" : "btc-cny",
        "price" : 2010.3,
        "amount" : 0.23,
        "dealed_amount" : 0,
        "create_time" : 1421560886,
        "last_update_time" : 1421560993,
      }
      ...
    ]
  }    
  
```
