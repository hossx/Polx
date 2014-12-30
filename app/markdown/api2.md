

##显示reserve ratio应该有个API可以拿到所有货币的简单统计

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