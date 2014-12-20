
class Coin
  constructor: (@id, @json) ->
    console.log("id: " + @id + ", json: " + JSON.stringify(@json))
    @name = @json.name

class Market
  constructor: (@baseCoin, @coin, @json) ->
    @id = @baseCoin.id + "-" + @coin.id
    @shortName = @coin.id + "/" + @baseCoin.id
    @name = @coin.name +"(" + @coin.id + ")/" + @baseCoin.id




`(function(document) {
  'use strict';

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
})(wrap(document));`
