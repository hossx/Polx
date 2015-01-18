
#币丰港交易所API（v2.0）

##目录
- Getting Start
- 当前版本
- 通用规则
- 错误代码表
- 字段说明
- 签名规则
- 接口详细说明
    - 读取全局配置
    - /api/open/assets          读取货币资产的统计数据
    - /api/open/reserves/[currency_id]       读取特定币种的详细数据。
    - /api/open/reserve_snapshots/[currency_id]      读取特定币种的资产分布snapshot列表。
    - /api/open/cryptotxs/[currency_id]      读取特定币种与平台相关的blockchain转账记录列表。
    - /api/my/profile               读取用户的profile
    - /api/my/assets                读取用户的assets
    - /api/my/cryptoaddrs           读取用户的虚拟货币deposit地址列表
    - /api/my/cryptoaddr/btc   读取用户的虚拟货币deposit地址，如果没有，系统先生成一个。
    - /api/my/deposits/btc?cursor=xxx&limit=12      读取用户某个币种的deposit记录
    - +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    - /api/open/ticker/[currency_pair]
    - /api/open/depth/[currency_pair]
    - /api/open/trade_history/[currency_pair]
    - /api/my/trade    交易
    - /api/my/batch_trade  批量交易
    - /api/my/cancel_order    取消订单
    - /api/open/order/[order_id]     订单查询
    - /api/my/orders/[currency_pair] 历史订单  
    
---

##Getting Start
- 欢迎使用Coinport Exchange API, 我们提供一系列方便快速的接口，帮助您及时把握市场变化, 快速进行交易，以及方便的将Coinport交易所整合进自己的应用中， 通过API，您可以做如下事情：

    - 获取市场最新行情
    - 获取市场深度和最新成交
    - 快速买进卖出
    - 获取用户账户信息
    - 获取各个虚拟货币相关详细开放数据
    

- 要想正确使用Coinport API, 建议您仔细阅读我们的通用规则，然后再进行具体接口的接入工作。

- 接入过程中，如果遇到任何问题，非常欢迎您联系我们，QQ：3115728063， 电话：+86 18621741026

---

##通用规则

- 所有请求基于HTTPS协议，base domain: [https:exchange.coinport.com](https:exchange.coinport.com)

- 针对交易/获取用户信息等隐私性接口，调用时需要做用户数据签名校验，并随其他数据一起发送，签名方法见下面的签名规则。

- URL中的币种ID用小写，返回值JSON中全部用大写。

- 所有API请求数据为JSON格式(GET请求不需要)，在接口详细说明部分，会在URL前标识该接口是GET还是POST请求以及具体参数说明。

- 所有API的返回数据[DATA]都被抱在如下结构中：

    ```
    {
      "code": 0, // 错误码，0 - 表示正常返回; 其他 - 表示请求失败
      "message": "", // 错误信息, 正常返回时为空; 出错时，为错误信息提示
      "time": 12345678,

      "data": [DATA]
    }
    ```

  接口详细说明部分的 "返回值" 都指的是[DATA].

---
##错误代码表

  |Code|说明|
  | ------------ | ------------- |
  | 0    |  |
  | 1001 | 缺少的参数说明,参数：{parameter} |
  | 1002 | 超过流量上限 |
  | 1003 | 系统内部错误,请联系API客服 |
  | 1004 | 用户不存在, uid:{uid} |
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

##[TODO format]通用字段说明
- currency_id 币种ID，目前支持的币种ID是：BTC, LTC, CNY，BTSX, XRP, DOGE, GOOC, BLK, DRK, VRC, ZET, NXT 
- currency_pair 交易市场对，目前支持的市场交易对是：BTC-CNY, LTC-CNY, BTSX-CNY, XRP-CNY, GOOC-CNY, LTC-BTC, XRP-BTC, BTSX-BTC, DOGE-BTC, BLK-BTC, DRK-BTC, VRC-BTC, ZET-BTC, NXT-BTC
- order_id, 订单号 11位数字编号：10000000234
- order_status， 订单状态：0 - 挂单中; 1 - 完全成交; 2 - 部分成交; 3 - 已取消;
- uid 用户ID， 10位数字编号: 1000001023

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

##接口详细说明

### GET /api/open/config
读取全局配置，包括支持的币种，支持的市场，以及app的参数等等。

- /api/open/config 读取全部配置
- /api/open/config/currencies,marketGroups,refreshIntervals 只读取指定的3个顶级配置组。

####返回值
```
{
  "currencies": {
    "CNY": {
      "name": "Chinese Yuan",
      "color": "red",
      "notCripto": true,
      "fee": {
        "deposit": {
          "c": 0.3,
          "p": 0.1
        },
        "withdraw": {
          "c": 0.3,
          "p": 0.1
        }
      }
    },
    "BTC": {
      "name": "Bitcoin",
      "color": "blue",
      "fee": {
        "deposit": {
          "c": 0.3,
          "p": 0.1
        },
        "withdraw": {
          "c": 0.3,
          "p": 0.1
        }
      }
    },
    "LTC": {
      "name": "Litecoin",
      "color": "#f2f000",
      "officialSite": "http://litcoin.org",
      "fee": {
        "deposit": {
          "c": 0.3,
          "p": 0.1
        },
        "withdraw": {
          "c": 0.3,
          "p": 0.1
        }
      },
      "browser": {
        "addr": "https://ltbrowser/addr/%s",
        "tx": "https://ltbrowser/addr/%s"
      }
    },
    "BTSX": {
      "name": "Bitshares"
    },
    "DOGE": {
      "name": "Dogecoin"
    },
    "BC": {
      "name": "Blackcoin"
    },
    "DRK": {
      "name": "Darkcoin"
    },
    "VRC": {
      "name": "VRCCoin"
    },
    "ZET": {
      "name": "Zetacoin"
    },
    "BTSX": {
      "name": "Bitshares"
    },
    "NXT": {
      "name": "NextCoin"
    },
    "XRP": {
      "name": "Ripple"
    },
    "GOOC": {
      "notCripto": true,
      "name": "谷壳"
    }
  },
  "marketGroups": {
    "CNY": {
      "markets": {
        "BTC": {
          "refreshInterval": 1000,
          "precision": 3,
          "minSellAmountmt": 0.001,
          "minBuyAmount": 0.001,
          "fee": {
            "maker": {
              "c": 0.3,
              "p": 0.1
            },
            "taker": {
              "constant": 0.3,
              "percentage": 0.1
            }
          },
          "tags": ["featured"]
        },
        "LTC": {
          "precision": 3,
          "minSellAmountmt": 0.001,
          "minBuyAmount": 0.001,
          "fee": {
            "maker": {
              "c": 0.3,
              "p": 0.1
            },
            "taker": {
              "c": 0.3,
              "p": 0.1
            }
          },
          "tags": ["featured"]
        },
        "BTSX": {
          "precision": 3
        },
        "XRP": {
          "precision": 3
        },
        "GOOC": {
          "precision": 3
        }
      }
    },
    "BTC": {
      "markets": {
        "LTC": {
          "precision": 3,
          "minSellAmountmt": 0.001,
          "minBuyAmount": 0.001,
          "tags": ["featured"]
        },
        "DOGE": {
          "precision": 3
        },
        "BC": {
          "precision": 3
        },
        "DRK": {
          "precision": 3
        },
        "VRC": {
          "precision": 3
        },
        "ZET": {
          "precision": 3,
          "priceUnit": "ZET/CNY"
        },
        "BTSX": {
          "precision": 3
        },
        "NXT": {
          "precision": 3,
          "priceUnit": "NXT/CNY"
        },
        "XRP": {
          "precision": 3
        }
      }
    }
  },
  "api": {
    "base": "https://exchange.coinport.com"
  },
  "refreshIntervals": {
    "depths": 5000,
    "tickers": 3000,
    "reserves": 300000
  },
  "documents": {
    "tos": {
      "label": "Terms of Service",
      "tags": ["legal"]
    },
    "privacy": {
      "label": "Privacy Policies",
      "tags": ["legal"]
    },
    "aml": {
      "label": "AML Policies",
      "tags": ["legal"]
    },
    "jobs": {
      "label": "Jobs",
      "tags": ["about"]
    },
    "team": {
      "label": "Team",
      "tags": ["about"]
    },
    "contactus": {
      "label": "Contact Us",
      "tags": ["about"]
    },
    "roadmap": {
      "label": "Roadmap",
      "tags": ["developer"]
    },
    "dong": {
      "label": "Daniel's Developer Notes",
      "tags": ["developer"]
    },
    "api2": {
      "label": "API 2.0 Brainstorming",
      "tags": ["developer"]
    }
  }
}

```

### GET /api/open/assets
读取货币资产的统计数据，特别是准备金情况。

- /api/open/assets 读取全部币种统计

####返回值
```
 {
   "BTC": [10, 20, 70, 99],
   "LTC": [12, 10, 1, 25],
   "GOOC": [ 10, 20, 70, 101],
   "BC": [12, 10, 1, 23],
   "BTSX": [10, 10, 20, 30],
   "XRP": [120, 10, 1, 150]
 }

```
数字分别表示：hot, cold, user, balance。建议数字只保留8位有效数字。 balance >= hot + cold + user。 Resesrve Ratio = (hot + cold + user) / balance


### GET /api/open/reserves/[currencyId]
读取特定币种的详细数据。

- /api/open/reserves/btc 读取btc详细数据

####返回值
```
{
  "timestamp": "12/12/12",
  "id": "BTC",
  "assets": [10, 20, 70, 99],
  "reserves": [{
    "label": "cold",
    "addresses": [
      ["1N9eMy14zYA6H7Rpn7dpErxgmdbjLk6iW4", 12.1121,
      "coinport", "H5mC9Q4ILstd0PxROJn/gEDjutY7HIW8zZ9EmpMcTikvOrP0VeGWQI8iMIuQu2ByChF+uc0gLelHl49Bi9e+Y1M="],
      ["1N9eMy14zYA6H7Rpn7dpErxgmdbjLk6iW4", 12.1121,
      "coinport", "H5mC9Q4ILstd0PxROJn/gEDjutY7HIW8zZ9EmpMcTikvOrP0VeGWQI8iMIuQu2ByChF+uc0gLelHl49Bi9e+Y1M="],
      ["1N9eMy14zYA6H7Rpn7dpErxgmdbjLk6iW4", 12.1121, 
      "coinport", "H5mC9Q4ILstd0PxROJn/gEDjutY7HIW8zZ9EmpMcTikvOrP0VeGWQI8iMIuQu2ByChF+uc0gLelHl49Bi9e+Y1M="],
      ["1N9eMy14zYA6H7Rpn7dpErxgmdbjLk6iW4", 12.1121, 
      "coinport", "H5mC9Q4ILstd0PxROJn/gEDjutY7HIW8zZ9EmpMcTikvOrP0VeGWQI8iMIuQu2ByChF+uc0gLelHl49Bi9e+Y1M="],
      ["1N9eMy14zYA6H7Rpn7dpErxgmdbjLk6iW4", 12.1121, 
      "coinport", "H5mC9Q4ILstd0PxROJn/gEDjutY7HIW8zZ9EmpMcTikvOrP0VeGWQI8iMIuQu2ByChF+uc0gLelHl49Bi9e+Y1M="],
      ["1N9eMy14zYA6H7Rpn7dpErxgmdbjLk6iW4", 12.1121, 
      "coinport", "H5mC9Q4ILstd0PxROJn/gEDjutY7HIW8zZ9EmpMcTikvOrP0VeGWQI8iMIuQu2ByChF+uc0gLelHl49Bi9e+Y1M="]
    ]
  }, {
    "label": "hot",
    "addresses": [
      ["1N9eMy14zYA6H7Rpn7dpErxgmdbjLk6iW4", 12.1121, 
      "coinport", "H5mC9Q4ILstd0PxROJn/gEDjutY7HIW8zZ9EmpMcTikvOrP0VeGWQI8iMIuQu2ByChF+uc0gLelHl49Bi9e+Y1M="],
      ["1N9eMy14zYA6H7Rpn7dpErxgmdbjLk6iW4", 12.1121, 
      "coinport", "H5mC9Q4ILstd0PxROJn/gEDjutY7HIW8zZ9EmpMcTikvOrP0VeGWQI8iMIuQu2ByChF+uc0gLelHl49Bi9e+Y1M="]
    ]
  }]
}


```

addresses中每一项为[地址，金额，原始消息，消息签名]


### GET /api/open/reserve_snapshots/[currencyId]
读取特定币种的资产分布snapshot列表。

- /api/open/reserve_snapshots/btc?limit=50 读取btc详细数据
- /api/open/reserve_snapshots/btc?cursor=1121321&limit=50 读取btc详细数据

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


### GET /api/open/cryptotxs/[currencyId]
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


### GET /api/my/profile
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


### GET /api/my/assets
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


### GET /api/my/cryptoaddrs
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


### POST /api/my/cryptoaddr/btc
读取用户的虚拟货币deposit地址，如果没有，系统先生成一个。
```
{
  "BTC": "fjdajfdjsalfjdlsafj"
}
```

### GET /api/my/deposits/btc?cursor=xxx&limit=12
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

### GET /api/open/ticker/[currency_pair]
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

### GET /api/open/depth/[currency_pair]?limit=[limit]
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

### GET /api/open/trade_history/[currency_pair]?since=[start_timestamp]
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

### POST /api/my/trade
交易

####POST参数
```
  {
    "user_id" : 1000000001,
    "currency_pair" : "btc-cny",
    "type" : "sell",
    "price" : 2100.2,
    "amount" : 0.23,
    "sign" : "3770f02dd594efdfe941b087304753a6"
  }

```
####返回值
```
  "data":{
    "order_id" : "1000000732928"
  }
  
```

### POST /api/my/batch_trade
批量下单, 每次最大下单量为10  
说明：订单号和下单顺序一致，如果下单失败，会有error_code，订单号为-1

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

### POST /api/my/cancel_order
取消订单

####POST参数
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

### GET /api/open/order/[order_id]
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

## GET /api/my/orders/[user_id]/[currency_pair]?page=[page]&limit=[limit]&status=[status]
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
