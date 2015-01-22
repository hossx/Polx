
#币丰港交易所API

<center>当前版本：2.0</center>

<div class="todo">
##TODO【小露】
- 每个示例需API实现后用真实数据替换。
- 提交订单的返回值应该包含订单数据。
</div>
---

##我们开始吧
欢迎使用币丰港交易所RESTful API，我们提供一系列方便快速的接口，帮助您及时把握市场变化，快速进行交易，以及方便地将币丰港整合进自己的应用中， 通过API，您可以做如下事情：


- 获取市场最新行情
- 获取市场深度和最新成交
- 快速买进卖出
- 获取用户账户信息
- 获取各个虚拟货币相关详细开放数据

要想正确使用币丰港交易所RESTful API, 建议您仔细阅读我们的「通用规则」，然后再进行具体接口的接入工作。接入过程中，如果遇到任何问题，请联系我们，QQ群：3115-728-063， 电话：（+86）186-2174-1026。

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

- cursor和limit：在几个API URL参数中，我们会用cursor和limit来指定返回数据的起始位置和数量。返回数据不包括cursor指向的那条数据（如果存在），如果想返回ID是0的数据，cursor的值应该是-1。如果没有说明，cursor默认值是-1，limit的默认值是50。每个API对limit可能与上限设置，如果设定的limit值大于这个上限，系统将用该上限作为limit的实际值。

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
  | 1008 | 余额不足 |
  | 1009 | 超过下单最小数量，最小交易额必须大于等值1元人民币 |
  | 1010 | 不支持的交易对 |
  | 1011 | 订单不存在   |
  | 1012 | 请求url不正确 |
  | 1013 | 币种不存在，币种：{currency}  |
  | 1014 | 认证失败 |
  

---

##认证授权
币丰港交易所目前支持通过HTTP标准的"Authorization Header"进行认证授权，也支持通过Cookie进行认证授权。  

通过Authorization Header认证流程如下：

###1. 基于用户名密码的认证授权
1. 将用户名和密码用":"连在一起，得到：
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
1. 首先，需在币丰港交易所网页版或者APP，申请API Token和Secret：
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
  如果认证失败，我们不会返回HTTP 401错误，而是返回一个认证失败的code：
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

##接口列表
目前支持的API列表如下：

  |HTTP 方法        | URL                                             | 说明
  | -------------- | -----------------------                         | ------------
  | GET            | /api/v2/reserve_stats                           | 读取平台所有数字资产的准备金统计数据
  | GET            | /api/v2/tickers                                 | 获取所有市场ticker数据 
  | GET            | /api/v2/*{currency}*/tickers                      | 获取人民币或比特币所有市场的ticker数据
  | GET            | /api/v2/*{currency}*/reserves                     | 读取平台某数字资产的准备金统详细数据
  | GET            | /api/v2/*{currency}*/balance_snapshot_files       | 读取特定币种的资产分布快照数据文件列表
  | GET            | /api/v2/*{currency}*/transfers_files              | 读取特定币种的充值提现记录文件列表
  | GET            | /api/v2/*{market}*/trades                         | 获取某市场的历史成交记录
  | GET            | /api/v2/*{market}*/ticker                         | 获取某市场的ticker数据 
  | GET            | /api/v2/*{market}*/depth                          | 获取某市场的深度数据
  | GET            | /api/v2/*{market}*/kline                          | 获取某市场的K线数据
  | POST           | /api/v2/register                                  | 新用户注册
  | GET            | /api/v2/login                                     | 用户登录
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

---

##接口详细说明

### GET /api/v2/reserve_stats
读取平台所有数字资产的准备金统计数据。

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

- stats：数组中的数值分别代表 [热钱包中资产数量, 冷钱包中资产数量, 用户充值地址中资产数量, 平台应付款总额]。存备金率 = (热钱包中资产数量 + 冷钱包中资产数量 + 用户充值地址中资产数量) / 平台应付款总额。

####示例

 - [https://exchange.coinport.com/api/v2/reserve_stats](https://exchange.coinport.com/api/v2/reserve_stats)

<br><br>

### GET /api/v2/tickers
获取所有市场ticker数据。
  
####返回值示例
  ```
    {
        "XRP-CNY": [4.53, 5.42, 6.34, 3.34, 5.03, 103234.02],
        "BTC-CNY": [2013.53, 2014.42, 2015.34, 2013.34, 2014.03, 300.34],
        "BTSX-CNY": [4.53, 5.42, 6.34, 3.34, 5.03, 103234.02],
        "LTC-CNY": [4.53, 5.42, 6.34, 3.34, 5.03, 103234.02],
        "XRP-BTC": [4.53, 5.42, 6.34, 3.34, 5.03, 103234.02],
        "BTC-BTC": [2013.53, 2014.42, 2015.34, 2013.34, 2014.03, 300.34],
        "BTSX-BTC": [4.53, 5.42, 6.34, 3.34, 5.03, 103234.02],
        "LTC-BTC": [4.53, 5.42, 6.34, 3.34, 5.03, 103234.02]
    }
  ```
返回值中数组中的数字依次代表：[买1价，卖1价，24小时最高价，24小是最低价，最近成交价，24小时成交量]。

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
        "XRP-CNY": [4.53, 5.42, 6.34, 3.34, 5.03, 103234.02],
        "BTC-CNY": [2013.53, 2014.42, 2015.34, 2013.34, 2014.03, 300.34],
        "BTSX-CNY": [4.53, 5.42, 6.34, 3.34, 5.03, 103234.02],
        "LTC-CNY": [4.53, 5.42, 6.34, 3.34, 5.03, 103234.02]
    }
  ```
返回值中数组中的数字依次代表：[买1价，卖1价，24小时最高价，24小是最低价，最近成交价，24小时成交量]。

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
    "timestamp": 12123213213121,
    "currency": "BTC",
    "stats": [10, 20, 70, 99],
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
- stats中的数字代表：[热钱包中资产数量, 冷钱包中资产数量, 用户充值地址中资产数量, 平台应付款总额]。存备金率 = (热钱包中资产数量 + 冷钱包中资产数量 + 用户充值地址中资产数量) / 平台应付款总额。
- distribution中每个数组代表：[地址，金额，地址属性，原始消息，消息签名]。其中地址属性是"cold"，"hot"，"user"之一。

####举例

- [https://exchange.coinport.com/api/v2/btc/reserves](https://exchange.coinport.com/api/v2/btc/reserves)
- [https://exchange.coinport.com/api/v2/ltc/reserves](https://exchange.coinport.com/api/v2/ltc/reserves)

<br><br>





### GET /api/v2/*{currency}*/balance_snapshots_files
读取特定币种的资产分布快照数据文件列表。

####URL参数
- currency：货币ID。
- cursor：请参考「术语约定」。
- limit：请参考「术语约定」，默认值50，上限100。

####返回值示例
```
{
  "hasMore": true,
  "currency": "BTC",
  "snapshots": [
    [123456, "01-01 15:06:00", "snapshot-10000.json", 121311],
    [123456, "01-01 15:06:00", "snapshot-10000.json", 121311],
    [123456, "01-01 15:06:00", "snapshot-10000.json", 121311],
    [123456, "01-01 15:06:00", "snapshot-10000.json", 121311],
    [123456, "01-01 15:06:00", "snapshot-10000.json", 121311],
    [123456, "01-01 15:06:00", "snapshot-10000.json", 121311],
    [123456, "01-01 15:06:00", "snapshot-10000.json", 121311],
    [123456, "01-01 15:06:00", "snapshot-10000.json", 121311],
    [123456, "01-01 15:06:00", "snapshot-10000.json", 121311],
    [123456, "01-01 15:06:00", "snapshot-10000.json", 121311],
    [123456, "01-01 15:06:00", "snapshot-10000.json", 121311],
    [123456, "01-01 15:06:00", "snapshot-10000.json", 121311]
  ]
}
```

####示例
- [https://exchange.coinport.com/api/v2/ltc/balance_snapshots_files](https://exchange.coinport.com/api/v2/ltc/balance_snapshots_files) - 读取最新50条LTC资产分布快照数据文件列表。
- [https://exchange.coinport.com/api/v2/btc/balance_snapshots_files?cursor=1121321&limit=20](https://exchange.coinport.com/api/v2/btc/balance_snapshots_files?cursor=1121321&limit=20) - 读取1121321之前的20条BTC资产分布快照数据文件列表。

<br><br>

### GET /api/v2/*{currency}*/transfer_files
读取特定币种的充值提现记录文件列表。

####URL参数
- currency：货币ID。
- cursor：请参考「术语约定」。
- limit：请参考「术语约定」，默认值50，上限100。

####返回值示例
```
{
  "timestamp": 126172881818,
  "hasMore": true,
  "currency": "BTC",
  "transfers": [
    [123456, "01-01 15:06:00", "transfer-10000.json", 121311],
    [123456, "01-01 15:06:00", "transfer-10000.json", 121311],
    [123456, "01-01 15:06:00", "transfer-10000.json", 121311],
    [123456, "01-01 15:06:00", "transfer-10000.json", 121311],
    [123456, "01-01 15:06:00", "transfer-10000.json", 121311],
    [123456, "01-01 15:06:00", "transfer-10000.json", 121311],
    [123456, "01-01 15:06:00", "transfer-10000.json", 121311],
    [123456, "01-01 15:06:00", "transfer-10000.json", 121311],
    [123456, "01-01 15:06:00", "transfer-10000.json", 121311],
    [123456, "01-01 15:06:00", "transfer-10000.json", 121311],
    [123456, "01-01 15:06:00", "transfer-10000.json", 121311],
    [123456, "01-01 15:06:00", "transfer-10000.json", 121311]
  ]
}
```

####示例
- [https://exchange.coinport.com/api/v2/ltc/balance_snapshots_files](https://exchange.coinport.com/api/v2/ltc/balance_snapshots_files) - 读取最新50条LTC资产分布快照数据文件列表。
- [https://exchange.coinport.com/api/v2/btc/balance_snapshots_files?cursor=1121321&limit=20](https://exchange.coinport.com/api/v2/btc/balance_snapshots_files?cursor=1121321&limit=20) - 读取1121321之前的20条BTC资产分布快照数据文件列表。

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
    "timestamp": 126172881818,
    "hasMore": true,
    "market": "BTC-CNY",
    "trades": [
      { "trade_id" : 1000000732928,
        "order_id" : 100000007,
        "taker" : "sell",
        "price" : 1000.23,
        "amount" : 0.34,
        "timestamp" : 126172881818
      },
      { "trade_id" : 1000000732929,
        "order_id" : 100000007,
        "taker" : "sell",
        "price" : 1000.26,
        "amount" : 1.12,
        "timestamp" : 126172881818
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
    "XRP-CNY": [4.53, 5.42, 6.34, 3.34, 5.03, 103234.02]
  }
```
返回值中数组中的数字依次代表：[买1价，卖1价，24小时最高价，24小是最低价，最近成交价，24小时成交量]。

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
    "asks": [
      [792, 5],
      [789.68, 0.018],
      [788.99, 0.042],
      [788.43, 0.036]
    ],
    "bids": [
      [787.1, 0.35],
      [787, 12.071],
      [786.5, 0.014],
      [786.2, 0.38],
      [785.04, 5]
    ]
  }
  
```
####示例
 - [https://exchange.coinport.com/api/v2/btc-cny/depth?limit=10](https://exchange.coinport.com/api/v2/btc-cny/depth?limit=10)

<br><br>


### GET /api/v2/*{market}*/kline
获取某市场的K线（OHLC）数据。

####URL参数
- market：市场ID。
- interval：K线数据聚合粒度，必须是"1m, 5m, 15m, 30m, 1h, 2h, 4h, 6h, 1d"的值之一，默认为"5m"。其中m代表分钟，h代表小时，d代表天。
- start：数据时间戳的起始时间（不包含），默认为0.
- end：数据时间戳的结束时间（包含），默认为当前时间。 end必须大于start返回结果才可能非空。

####返回值示例
```
{
  "items": [
    [1421560886, 1934.3, 1993.2, 1923.4, 1946.3, 10.34],
    [1421564531, 1944.3, 2013.2, 1925.4, 1946.3, 16.34],
    [1421568345, 1956.3, 2022.2, 1921.4, 1946.3, 29.34]
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
    "email": "my@gmail.com",
    "pwdhash": "md5ofmypassword"
  }
```
####返回值示例
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
profile中的pwdhash将不会被返回。

<br><br>


### GET /api/v2/user/profile
读取授权用户的基本信息
####URL参数
无
####返回值示例
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

<br><br>



### GET /api/v2/user/balance
读取用户的账户资产。
####URL参数
无
####返回值示例
```
  {
    "DRK": [1,2,3,6],
    "BTC": [1,2,3,6],
    "VRC": [1,2,3,6],
    "LTC": [1,2,3,6],
    "CNY": [1,2,3,6]
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
    TODO
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
    "hasMore": true,
    "orders" : [
      {
        "order_id" :  "1000000732928"
        "type" : "sell",
        "status" : 1,
        "market" : "btc-cny",
        "price" : 2010.3,
        "amount" : 0.23,
        "value" : 0.11,
        "created" : 1421560886,
        "last_updated" : 1421560993,
      },
      {
        "order_id" :  "1000000834523"
        "type" : "buy",
        "status" : 2,
        "market" : "btc-cny",
        "price" : 2010.3,
        "amount" : 0.23,
        "value" : 0,
        "created" : 1421560886,
        "last_updated" : 1421560993,
      }
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
    }]
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
    "hasMore": true,
    "withdrawals": [{
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
    }]
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
    "DRK": "fjdajfdjsalfjdlsafj",
    "BTC": "fjdajfdjsalfjdlsafj",
    "VRC": "fjdajfdjsalfjdlsafj",
    "LTC": "fjdajfdjsalfjdlsafj",
    "CNY": "fjdajfdjsalfjdlsafj",
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
    "BTC": "fjdajfdjsalfjdlsafj"
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
        "type" : "sell",
        "price" : 2100.2,
        "amount" : 0.23
      }, {
        "market" : "xrp-cny",
        "type" : "buy",
        "price" : 1800,
        "amount" : 0.23
      }
    ]
  }
```
####返回值示例
```
  {
    "results" : [
      {"order_id" : 1000000732928 },
      {"order_id" : 0, "code" : 1003}
    ]
  }
  
```
返回结果中订单号和下单顺序一致，如果下单失败，order_id为0， 并且会有非零的code。


<br><br>


### POST /api/v2/user/cancel_orders
批量取消订单。

####POST数据JSON格式
```
  {
    "order_ids" : [
      1000000732928，
      1000000732345，
      1000000834534
    ]
  }

```
####返回值示例
```
  {
    "cancelled" :[
      1000000732928，
      1000000732345
    ],
    "failed": {
      1000000834534 : {code: 1200}
    }
  }
  
```
<br><br>



### POST /api/v2/user/submit_withdrawal
提交一个提现申请。

####POST数据JSON格式
```
  {
     "currency" : "BTC",
     "address" ： "1GbJtdiidFnbsGfuC5VtMKrRaoyrP2rRXk",
     "amount" : 0.1
  }
```

####返回值示例
```
  {
    "tranfer_id" : 1000003534734,
    "withdraw_status" : 0
  }
```
<br><br>



### POST /api/v2/user/cancel_withdrawal
提交一个提现申请。

####POST数据JSON格式
```
  {
     "tranfer_id" : 1000003534734
  }
```

####返回值示例
```
  {
    "id": 1000000000320,
    "created": 118271181818,
    "updated": 118271181818,
    "quantity": 10,
    "status": "Succeeded",
    "address": "fdafdsafidsaiofdslafjdasfjafa"
  }
```
如果该提现记录存在，返回该提现记录；否者返回值为空字符串。客户端需要查看code是否为0来判断该API是否成功取消了一个提现申请。
