

##通用

URL中的币ID用小写，返回值JSON中全部用大写。

---
## /api/config
读取全局配置，包括支持的币种，支持的市场，以及app的参数等等。

- /api/config 读取全部配置
- /api/config/currencies,marketGroups,refreshIntervals 只读取指定的3个顶级配置组。

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

---

## /api/currency/stats
读取货币资产的统计数据，特别是准备金情况。

- /api/currency/stats 读取全部币种统计
- /api/currency/stats/btc,ltc 读取btc和ltc统计

####返回值
```
 {
   "timestamp": "12/12/12",
   "data": {
     "BTC": [10, 20, 70, 99],
     "LTC": [12, 10, 1, 25],
     "GOOC": [ 10, 20, 70, 101],
     "BC": [12, 10, 1, 23],
     "BTSX": [10, 10, 20, 30],
     "XRP": [120, 10, 1, 150]
   }
 }

```
数字分别表示：hot, cold, user, balance。建议数字只保留8位有效数字。 balance >= hot + cold + user。 Resesrve Ratio = (hot + cold + user) / balance

---

## /api/currency/details/[currencyId]
读取特定币种的详细数据。

- /api/currency/details/btc 读取btc详细数据

####返回值
```
{
  "timestamp": "12/12/12",
  "id": "BTC",
  "stats": [10, 20, 70, 99],
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
数字分别表示：hot, cold, user, balance。建议数字只保留8位有效数字。 balance >= hot + cold + user。 Resesrve Ratio = (hot + cold + user) / balance

---