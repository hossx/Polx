(function(document) {
  'use strict';
  var langs = window.navigator.languages || [window.navigator.language || window.navigator.userLanguage];
  var lang = langs[0].split('-')[0];
  if (lang !== 'zh') {
    window.lang = 'en';
  } else {
    window.lang = 'zh';
  }
  //console.log('lang: ' + window.lang);

  if (window.lang === 'zh') {
    document.title = '币丰港';
    $('meta[name="description"]')
      .attr('content', '全透明虚拟货币交易平台 - 代码开源，数据开放，100%可证明准备金。');

  } else {
    document.title = 'Coinport Exchange';
    $('meta[name="description"]')
      .attr('content', 'Crypto-asset exchange for cool people. Coinport features full openness - open source, open data, 100% open reserve.');

  }

/*
  document.addEventListener('polymer-ready', function() {
    // Perform some behaviour
    console.log('Polymer is ready to rock!');
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
*/
  function setupIM() {
    (function(d, s) {
      var z = window.$zopim = function(c) {
        z._.push(c);
      };
      var x = z.s = d.createElement(s);
      var e = d.getElementsByTagName(s)[0];
      z.set = function(o) {
        z.set._.push(o);
      };
      z._ = [];
      z.set._ = [];
      x.async = !0;
      x.setAttribute('charset', 'utf-8');
      x.src = '//v2.zopim.com/?2p7MBUmM53iXkyPP647DjIW7WeuknrJ1';
      z.t = +new Date();
      x.type = 'text/javascript';
      e.parentNode.insertBefore(x, e);
    })(document, 'script');

    if (window.$zopim) {
      window.$zopim(function() {
        var z = window.$zopim;
        if (window.lang === 'zh') {
          z.livechat.setLanguage('zh_CN');
          z.livechat.setGreetings({
            'offline': 'Sorry，币丰港客服不在线上。请留言。',
            'online': '客服MM在线，一起聊聊吧？'
          });
          z.livechat.concierge.setName('币丰港客服');
          z.livechat.concierge.setTitle('有什么可以帮您的？');
        } else {
          z.livechat.setLanguage('en');
          z.livechat.concierge.setTitle('How can I help you?');
        }
      });
    }
  };

  function gaSSDSLoad(acct) {
    var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www."),
      pageTracker,
      s;
    s = document.createElement('script');
    s.src = gaJsHost + 'google-analytics.com/ga.js';
    s.type = 'text/javascript';
    s.onloadDone = false;

    function init() {
      pageTracker = _gat._getTracker(acct);
      pageTracker._trackPageview();
    }
    s.onload = function() {
      s.onloadDone = true;
      init();
    };
    s.onreadystatechange = function() {
      if (('loaded' === s.readyState || 'complete' === s.readyState) && !s.onloadDone) {
        s.onloadDone = true;
        init();
      }
    };
    document.getElementsByTagName('head')[0].appendChild(s);
  }

  setTimeout(function() {
    setupIM();
    if (window.lang != 'zh') {
      gaSSDSLoad('UA-51354545-2');
    }
  }, 2000);

  $('<the-app></the-app>').insertBefore($('#loading'));

  // wrap document so it plays nice with other libraries
  // http://www.polymer-project.org/platform/shadow-dom.html#wrappers
})(wrap(document));
