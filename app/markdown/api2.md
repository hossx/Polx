

##通用

URL中的币ID用小写，返回值JSON中全部用大写。
##读取currency的reserve数据

- 读取所有支持的币种
```/api/open/reserve```

- 读取指定币种
```/api/open/reserve/btc,ltc```

- 返回值
```
{
    "labels": ["total", "hot","cold", "user"],
    "reserves": {
        "BTC": [100, 10, 20, 70],
        "LTC": [12, 10, 1, 1]
    }
}
```
建议数字只保留8位有效数字。

####现状

现在的api是每个货币需要单独去拿，返回值也比较冗余。

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