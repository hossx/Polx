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
    // wrap document so it plays nice with other libraries
    // http://www.polymer-project.org/platform/shadow-dom.html#wrappers
})(wrap(document));


