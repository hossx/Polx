'use strict'

Polymer 'tweet-wall',
  height: 820 
  content: ''
  tags: "no-tag"

  currencyChanged: () ->
    if @currency
      console.log(@currency)
      @content = 
      '<html>
      <head>
<style type="text/css">
iframe[id^="twitter-widget-"]{ width:100% !important;}
</style>
      </head>
      <body>
        <a class="twitter-timeline" href="https://twitter.com/hashtag/' + @currency.name + '" data-widget-id="' + @currency.json.twitterWidgetId + '">#'+@currency.name+' Tweets</a>
        <script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?"http":"https";if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+"://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>
      </body>
      </html>'