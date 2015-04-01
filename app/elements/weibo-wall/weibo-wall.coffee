'use strict'

Polymer 'weibo-wall',
  height: 920 
  content: ''
  tags: "no-tag"

  currencyChanged: () ->
    if @currency
      if @currency.json.tags
        tags = @currency.json.tags
      else
        tags = @currency.name
      tags = tags + ",币丰港"

      @content = 
      '<html xmlns:wb="http://open.weibo.com/wb">
      <head>
        <script src="https://tjs.sjs.sinajs.cn/open/api/js/wb.js"></script>
      </head>
      <body>
       <wb:topic uid="1904178193" topmid="C7dJbdvTw" column="n" border="n" width="728"
        height="'+ (@height) + '"
        tags="' + encodeURIComponent(tags) + '"
        color="333333%2Cffffff%2C00b8d4%2Cf5f5f5%2C333333%2Cfafeff%2C0078b6%2Ccccccc%2Cffffff%2Cf5f5f5"
        language="zh_cn" version="base" appkey="2WElLa" footbar="y"
        url="http%3A%2F%2Fexchange.coinport.com%2F%23%2Fcurrency%2F'+ @currency.id + '"
        filter="y" ></wb:topic>
       </body>
      </html>
      '