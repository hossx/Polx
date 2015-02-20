'use strict'

Polymer 'home-page',
  msgMap:
    'en':
      coinport: "Coinport"
      slogan: "Crypto-Asset Exchange for Cool People"
      feature1: "Open-Source"
      explain1_1: "Our matching engine has been "
      explain1_2: "open-sourced on Github"
      explain1_3: ". Visit our public repository to verify our matching code, and feel free to clone it. Coinport Exchange allows clients to have insight to all the internals."
      feature2: "Open-Data"
      explain2: "All non-user private data are available to download as JSON files, including orders, trades, deposits and withdrawals, user account balances, and all crypto-addresses of our cold and hot wallets."
      feature3: "100% Reserves"
      explain3: "We never invest user asset for our own profit. To prove this, our platform publishes new events and system snapshots hourly. You can verify our reserve ratios based on these open data with simple maths."
      mobileReady: "Mobile App Ready for Android"
      download: "Download App"
      support: "Supports Android 2.4.2 and up. iOS App coming soon."
      servedBy: "Powered by Coinport Technology Limited HK"
      #announceWarning: "This is the warning we can make."
      #announceInfo: "This is the info we can make."
    'zh':
      coinport: "币丰港"
      slogan: "全透明数字资产交易平台"
      feature1: "代码开源"
      explain1_1: "我们的交易匹配引擎已"
      explain1_2: "托管在Github上"
      explain1_3: "。 您可以访问我们的代码库获取源代码，查看任何您感兴趣的部分。 我们鼓励用户了解所有细节，并帮助我们不断完善交易系统。"
      feature2: "数据开放"
      explain2: "除用户隐私数据外，平台全部数据均可下载。 全部订单、交易、充值、提现、账户余额、冷热钱包地址等均对用户开放。 您既可以掌控全局，也能够深入细节。"
      feature3: "100%准备金"
      explain3: "如何证明我们没有挪用您托管的资产？ 依靠晦涩难懂的Merkle-tree吗？ 不必那么麻烦。我们直接公开全部账户的余额，以及所有冷热钱包地址。准备金是否充足，您一目了然。"

      mobileReady: "安卓手机有APP可用哦"
      download: "立即下载"
      support: "支持安卓2.4.2及以上版本. iOS App还在开发中。"
      servedBy: "币丰港交易平台由币丰港（香港）网络科技有限公司运营"
      #announceWarning: "This is the warning we can make."
      #announceInfo: "This is the info we can make."


  ready: () ->
    @M = @msgMap[window.lang]
    $(this.$['branding']).backstretch([
       "/images/bg-wooden.jpg"
      ],
      {duration: 3000, fade: 750})
    $(this.$['mobile']).backstretch("/images/bg-desktop.jpg")

