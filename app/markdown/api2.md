

##通用

URL中的币ID用小写，返回值JSON中全部用大写。

---
## /api/currency/stats
读取货币资产的统计数据，特别是准备金情况。

- /api/currency/stats
- /api/currency/stats/btc,ltc

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

## /api/currency/[currencyId]
读取特定币种的详细数据。

- /api/currency/btc

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