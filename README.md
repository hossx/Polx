##Initialize the environment
```
bower install
sudo npm install
sudo npm install grunt
sudo npm install grunt-cli
sudo npm install grunt-filerev
```
##Need ruby as well as sass
(install ruby if needed)
```
sudo gem install sass
```

##Run in live-preview mode
```
grunt serve
```

##Compile and run
```
grunt build
cd dist
python -m SimpleHTTPServer 12345
```
Open ```http://localhost:12345```

##Publish
```
grunt publish
```
Open ```http://www.bitvar.com```


## zopim bug fix
zopim is not compatible with polymer on safari by default, but if we change webcomponent.js from:
```
 var frame = document.createElement("iframe");
    frame.style.display = "none";
    function initFrame() {
      frame.initialized = true;
      document.body.appendChild(frame);
      var doc = frame.contentDocument;
      var base = doc.createElement("base");
      base.href = document.baseURI;
      doc.head.appendChild(base);
    }
```

to:

``` 
var frame = document.createElement("iframe");
    frame.style.display = "block";
    function initFrame() {
      frame.initialized = true;
      document.body.appendChild(frame);
      var doc = frame.contentDocument;
      var base = doc.createElement("base");
      base.href = document.baseURI;
      doc.head.appendChild(base);
    }
```

then zopim works with polymer on safari.