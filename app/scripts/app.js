(function(document) {
  'use strict';
  var langs = window.navigator.languages || [window.navigator.language || window.navigator.userLanguage];
  var lang = langs[0].split('-')[0];
  if (lang !== 'zh') {
    window.lang = 'en';
  } else {
    window.lang = 'zh';
  }
  console.log('lang: ' + window.lang);

  if (window.lang === 'zh') {
    document.title = '币丰港';
    $('meta[name="description"]')
      .attr('content', '全透明虚拟货币交易平台 - 代码开源，数据开放，100%可证明准备金。');

  } else {
    document.title = 'Coinport Exchange';
    $('meta[name="description"]')
      .attr('content', 'Crypto-asset exchange for cool people. Coinport features full openness - open source, open data, 100% open reserve.');

  }

  document.addEventListener('polymer-ready', function() {
    // Perform some behaviour
    console.log('Polymer is ready to rock!');
  });

  $zopim(function() {
    if (window.lang === 'zh') {
      $zopim.livechat.setLanguage('zh_CN');
      $zopim.livechat.setGreetings({
        'offline': '对不起，币丰港客服不在线上。请留言，我们将尽快回复您。',
        'online': '客服MM在线，一起聊聊吧？'
      });
      $zopim.livechat.concierge.setName('币丰港');
      $zopim.livechat.concierge.setTitle('今天你买卖什么币了吗？');
    } else {
      $zopim.livechat.setLanguage('en');
      $zopim.livechat.concierge.setTitle('Did you trade today?');
    }
  });

  window.logAndContinue = function() {
    var missing = Polymer.waitingFor();
    if (missing.length) {
      missing.forEach(function(el) {
        console.warn('Waiting for: ' + el.getAttribute('name'));
      });
      console.warn('Forcing element registration.');
      Polymer.forceReady();
    }
  };
  // wrap document so it plays nice with other libraries
  // http://www.polymer-project.org/platform/shadow-dom.html#wrappers
})(wrap(document));
