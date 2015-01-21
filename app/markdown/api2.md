
#币丰港交易所API

<center>当前版本：2.0</center>


##我们开始吧
欢迎使用币丰港交易所RESTful API，我们提供一系列方便快速的接口，帮助您及时把握市场变化，快速进行交易，以及方便地将币丰港整合进自己的应用中， 通过API，您可以做如下事情：


- 获取市场最新行情
- 获取市场深度和最新成交
- 快速买进卖出
- 获取用户账户信息
- 获取各个虚拟货币相关详细开放数据

要想正确使用币丰港交易所RESTful API, 建议您仔细阅读我们的「通用规则」，然后再进行具体接口的接入工作。接入过程中，如果遇到任何问题，请联系我们，QQ群：3115-728-063， 电话：（+86）186-2174-1026。

---

##术语约定
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
    1 - 完全成交
    2 - 部分成交
    3 - 已取消
  ```

- uid：用户ID，是个10位数字编号，如: 1000001023。

- withdraw_status：提现状态码，其中：
  ```
    0 - 待处理（pending）
    1 - 处理中（processing）
    2 - 处理完成，等待网络确认（comfirming）
    3 - 已取消（pending）
    4 - 成功（successed）
    5 - 失败（failed）
  ```

---

##通用规则
以下通用规则适用于所有RESTful API：

- 所有请求基于HTTPS协议，API URL的前缀均为：
  ```
    https://exchange.coinport.com
  ```

- 针对交易/获取用户信息等隐私性接口，调用时需要做用户认证，币丰港交易所支持的校验方法是Basic Authentication， 具体认证方式见下面的「认证方式」部分。

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

- 所有多单词参数命名均为小写并用下划线连接，如：order_id，currency_pair

- 每个API接口会标记为"PUBLIC"或"PRIVATE", PUBLIC接口不需要认证，PRIVATE接口需要在Http Header中提供认证信息，认证信息请参考「认证方式」。

---
##错误代码表

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
  | 1008 | 余额不足 |
  | 1009 | 超过下单最小数量，最小交易额必须大于等值1元人民币 |
  | 1010 | 不支持的交易对 |
  | 1011 | 订单不存在   |
  | 1012 | 请求url不正确 |
  | 1013 | 币种不存在，币种：{currency}  |
  | 1014 | 认证失败 |
  

---

##认证方式
币丰港交易所目前只支持Basic Authentication认证方式，未来我们会支持OAuth 2.0。  

Basic Authentication认证流程如下：

1. 首先，需在币丰港交易所网页版或者APP，申请API Token和SecretKey：
  ```
    Token : 92ad7be8cdd59e230f7528fdfe94c
    SecretKey : e94d592ad7be28fdf41b08730f7528f8
  ```

2. 然后，用申请得到的SecretKey对业务请求参数或者数据签名，生成一个签名（Signature)字符串。详见下面的「签名规则」。

3. 将Token和Signature放到Http Header中，随业务请求数据一起发送到服务器：
  ```
    httpRequest.setHeader("auth", "[TOKEN]:[signature]")
  ```

  如果Token为：
  ```
    92ad7be8cdd59e230f7528fdfe94c
  ```

  签名（Signature）为：
  ```
    be28f28fef41b08787d3092adf75
  ```

  最终Http Header将为：
  ```
    httpRequest.setHeader("auth", "92ad7be8cdd59e230f7528fdfe94c:be28f28fef41b08787d3092adf75")

  ```

  请注意：如果认证失败，我们不会返回HTTP 401错误，而是返回一个认证失败的code：
  ```
    {
      "code": 1014, 
      "time": 14423452342,
    }
  ```

以上认证方式只适用于PRIVATE API接口。对于PUBLIC API，"auth" Header将被忽略。


###签名规则

####POST API

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


####GET API

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
---

##接口列表
详细说明文档，描述了接入具体接口所需要的所有信息，目前支持的API列表如下：

  |类型       |Http 方法         | URL                                             | 说明
  | --------- | -------------- | -----------------------                         | ------------
  | PUBLIC    | GET            | /api/v2/reserve_stats                           | 读取平台所有数字资产的准备金统计数据
  | PUBLIC    | GET            | /api/v2/[currency]/tickers                      | 获取btc或者cny市场各个币种ticker信息 
  | PUBLIC    | GET            | /api/v2/[currency]/balance_snapshots            | 读取特定币种的资产分布快照数据文件列表
  | PUBLIC    | GET            | /api/v2/[currency]/reserves                     | 读取平台某数字资产的准备金统详细数据
  | PUBLIC    | GET            | /api/v2/[market]/trades                         | 获取历史成交
  | PUBLIC    | GET            | /api/v2/[market]/ticker                         | 获取btc或者cny市场各个币种ticker信息 
  | PUBLIC    | GET            | /api/v2/[market]/depth                          | 获取深度数据
  | PUBLIC    | GET            | /api/v2/[market]/kline                          | 按市场对，时间区间获取K线数据
  | PRIVATE   | GET            | /api/v2/user/profile                      | 读取用户的基本信息资料
  | PRIVATE   | GET            | /api/v2/user/balance                      | 读取用户的资产
  | PRIVATE   | GET            | /api/v2/user/trades                       | 查询单个/多个订单详情
  | PRIVATE   | GET            | /api/v2/user/orders                       | 查询单个/多个订单详情
  | PRIVATE   | GET            | /api/v2/user/deposits                     | 读取用户某个币种的充值记录
  | PRIVATE   | GET            | /api/v2/user/deposit_addresses            | 读取用户的虚拟货币充值地址
  | PRIVATE   | POST           | /api/v2/user/new_deposit_address          | 读取用户的虚拟货币充值地址，如果没有，系统生成一个
  | PRIVATE   | POST           | /api/v2/user/withdrawals                  | 提交提现申请
  | PRIVATE   | POST           | /api/v2/user/submit_orders                | 批量交易
  | PRIVATE   | POST           | /api/v2/user/cancel_orders                | 取消一个/多个订单
  | PRIVATE   | POST           | /api/v2/user/submit_withdrawal            | 提交提现申请
  | PRIVATE   | POST           | /api/v2/user/cancel_withdrawal            | 提交提现申请

---

##接口详细说明
###GET /api/v2/reserve_stats
读取平台数字资产的准备金统计数据。

####URL参数
无

####返回值示例
```
  {
    "timestamp": 12123213213121,
    "stats": {
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
- stats：数组中的数值分别代表 [热钱包中资产数量, 冷钱包中资产数量, 用户充值地址中资产数量, 平台应付款总额]。存备金率 = (热钱包中资产数量 + 冷钱包中资产数量 + 用户充值地址中资产数量) / 平台应付款总额。

####示例

 - [https://exchange.coinport.com/api/v2/reserve_stats](https://exchange.coinport.com/api/v2/reserve_stats)

---

### GET /api/v2/[currency]/tickers
获取btc或者cny市场各个币种ticker信息

- 目标市场只能选择btc或者cny，支持的目标币种见__`通用字段说明`__

- 省略btc/cny和currency，则获取所有市场所有ticker

- 省略currency，则获取目标市场所有ticker

- 返回值依次是：买1价，卖1价，24小时最高价，24小是最低价，最近成交价，24小时成交量

  ####请求示例
  ```
  获取xrp-cny市场的ticker信息：
  
    GET /api/ticker/cny?currency=xrp
    
  获取cny市场的所有ticker信息：

    GET /api/ticker/cny

  获取所有市场的ticker信息：

    GET /api/ticker

  ```
  
  ####返回值
  ```
    {
        "XRP-CNY": [4.53, 5.42, 6.34, 3.34, 5.03, 103234.02],
        "BTC-CNY": [2013.53, 2014.42, 2015.34, 2013.34, 2014.03, 300.34],
        "BTSX-CNY": [4.53, 5.42, 6.34, 3.34, 5.03, 103234.02],
        "LTC-CNY": [4.53, 5.42, 6.34, 3.34, 5.03, 103234.02]
    }
  ```
  

---

### GET /api/v2/reserves/[currency]
读取平台某数字资产的准备金统详细数据。

####URL参数
无

####返回值示例
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
- timestamp的时间是数据更新时间，单位为millisecond。
- reserves中的数字代表：[热钱包中资产数量, 冷钱包中资产数量, 用户充值地址中资产数量, 平台应付款总额]。存备金率 = (热钱包中资产数量 + 冷钱包中资产数量 + 用户充值地址中资产数量) / 平台应付款总额。
- distribution中每个数组代表：[地址，金额，地址属性，原始消息，消息签名]。其中地址属性是"cold"，"hot"，"user"之一。

####举例

- [https://exchange.coinport.com/api/v2/reserves/btc](https://exchange.coinport.com/api/v2/reserves/btc)
- [https://exchange.coinport.com/api/v2/reserves/ltc](https://exchange.coinport.com/api/v2/reserves/ltc)

---

### GET /api/v2/balance_snapshots/[currency]
读取特定币种的资产分布快照数据文件列表

####URL参数
- cursor：前一条snapshot记录的ID。这个snapshot记录将不包括在返回值内。
- limit：读取数据条目数，默认值50。

####返回值示例
```
{
  "timestamp": 126172881818,
  "hasMore": true,
  "currency": "BTC",
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
- hasMore：如果返回值最后一条之后再无记录可以返回，hasMore会被设置为false。
- timestamp的时间是数据更新时间，单位为millisecond。

####示例
- [https://exchange.coinport.com/api/v2/reserve_snapshots/ltc](https://exchange.coinport.com/api/v2/reserve_snapshots/ltc) - 读取最新50条btc详细数据。
- [https://exchange.coinport.com/api/v2/reserve_snapshots/btc?cursor=1121321&limit=40](https://exchange.coinport.com/api/v2/reserve_snapshots/btc?cursor=1121321&limit=40) - 读取从1121321的下一条记录开始，往前的40条详细数据。

---

### GET /api/v2/profile
读取用户的基本信息资料
####返回值
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
### GET /api/v2/assets
读取用户的资产情况

- 返回长度为4的类型数组，依次为：[可用余额，冻结余额，待提现余额，总余额]

####返回值
```

{
  "DRK": [1,2,3,6], // [available, locked, pendingwithdrawal, total]
  "BTC": [1,2,3,6],
  "VRC": [1,2,3,6],
  "LTC": [1,2,3,6],
  "CNY": [1,2,3,6]
}
```
---
### GET /api/v2/cryptoaddrs
读取用户的虚拟货币充值地址

####返回值
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
### POST /api/v2/cryptoaddr/[currency]
读取用户的虚拟货币deposit地址，如果没有，系统生成一个

- currency参数必填，且只能为有充值地址的币种
```
{
  "BTC": "fjdajfdjsalfjdlsafj"
}
```

---
### GET /api/v2/deposits/[currency]?cursor=[cursor]&limit=[limit]
读取用户某个币种的充值记录

- currency，必须指定

- cursor，可选字段，值为deposit_id，表示往前追溯limit条数

- limit，可选参数，默认50条
####返回值
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
### GET /api/v2/depth/[currency_pair]?limit=[limit]
获取深度数据, 默认返回前30条深度, 最大200条, 通过limit指定条数

####请求示例
```
  /api/depth/btc_cny // 默认返回30条深度
  /api/depth/btc_cny?limit=50 // 返回50条深度
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

### GET /api/v2/kline/[currency_pair]?interval=[interval]&since=[since]
按市场对，时间区间获取K线数据

- currency_pair, 市场对，例子：btc_cny

- since，时间戳，表示返回这个时间戳之后的数据，例子：1421560886

- interval, 时间区间，分钟为单位，例子：1，代表1分钟；120, 代表2小时，目前支持的区间是：
  ```
  1 min, 3 min, 5 min, 15 min, 30 min, 

  1 hour, 2 hour, 4 hour, 6 hour, 12 hour
 
  ```
- 返回值说明，返回值为items，items里面有n条数据，每条数据是一个长度为6的数组，依次是下列数据项：[时间戳]

####请求示例
```
  获取从1421560886开始，时间区间是15分钟的K线数据：

    /api/kline/btc_cny?interval=15&since=1421560886
```

####返回值
```
"data":{
  "items": [
    [1421560886, 1934.3, 1993.2, 1923.4, 1946.3, 10.34],
    [1421564531, 1944.3, 2013.2, 1925.4, 1946.3, 16.34],
    [1421568345, 1956.3, 2022.2, 1921.4, 1946.3, 29.34],
    ....
  ]
}
  
```
---
### GET /api/v2/open/trade_history/[currency_pair]?since=[order_id]
 获取历史成交, 默认获取最新200条成交记录
 
 - 如果提供since参数，则从since订单号开始，向前追溯200条返回

####返回值
```
"data":{
  "count": 200，
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
### POST /api/v2/trade
交易，提交一个订单

- post参数中所有参数均为必填项

####POST参数
```
  {
    "currency_pair" : "btc-cny",
    "type" : "sell",
    "price" : 2100.2,
    "amount" : 0.23
  }

```
####返回值
```
  "data":{
    "order_id" : "1000000732928"
  }
  
```
---
### POST /api/v2/submit_orders
批量下单, 每次最大下单量为10

- 返回结果中订单号和下单顺序一致，如果下单失败，会有error_code，不会返回订单号

####请求参数
```
  {
    "orders" : [
      {
        "currdency_pair" : "btc-cny",
        "type" : "sell",
        "price" : 2100.2,
        "amount" : 0.23
      },
      {
        "currdency_pair" : "xrp-cny",
        "type" : "buy",
        "price" : 1800,
        "amount" : 0.23
      }
      ....
    ],
  }

```
####返回值
```
  "data":{
    "results" : [
      {"order_id" : 1000000732928 },
      {"error_code" : 1003, "message" : "lake of balance : btc" }
      ....
    ]
  }
  
```

---
### POST /api/v2/cancel_orders
- 取消一个/多个订单

####POST参数
```
  {
    "order_ids" : [
      "1000000732928"，
      "1000000732345"，
      "1000000834534"
    ]
  }

```
####返回值
```
  "data":{
    "result" : [
      true,
      false,
      true
    ]
  }
  
```
---
### GET /api/v2/orders?ids=[order_id1,order_id2,order_id3,or...]
查询单个/多个订单详情

####请求示例
```
查询单个订单1000000732928详情：

  GET /api/orders?ids=1000000732928

查询多个订单1000000732928，1000000732223，1000000732234详情：

  GET /api/orders?ids=1000000732928,1000000732223,1000000732234

注意，逗号之间没有空格
```
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
### [Private] GET /api/v2/order_history/[market]
查询历史订单.

####URL参数
- cursor：游标，表示从cursor指定的订单号开始往前追溯，默认为最新一条订单号
- limit：每次查询最大条数限制，默认50条
- order_status：订单状态码，默认获取所有状态的订单

####请求示例
```
查询市场对btc_cny从订单号1000000732928开始往前的100条状态为dealed的所有订单：

  GET /api/history_orders?currency_pair=btc_cny&cursor=1000000732928&limit=100&order_status=1

从最新一条开始查询所有历史订单：

  GET /api/history_orders

从最新一条开始查询所有状态为canceled的历史订单，每次查询90条：

  GET /api/history_orders?limit=90&order_status=2
```

####返回值示例
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
返回结果按订单号生成时间排列，最新的排在第一条。

---

###[Private] POST /api/v2/withdraw
提交提现申请。

####POST数据格式
```
  {
     "currency" : "BTC",
     "address" ： "1GbJtdiidFnbsGfuC5VtMKrRaoyrP2rRXk",
     "amount" : 0.1
  }
```
三个参数均需填写。

####返回值示例
```
  {
    "tranfer_id" : 1000003534734,
    "withdraw_status" : 0
  }
  
```
