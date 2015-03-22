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


## Zopim Workaround
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

## Optimization

A lot of time as spent on website optimization. The major goal is to make `index.html`, `index.js`,`the-app.html`, and `the-app.js` under `dist/` as small as possible. To achieve this, the following have been done:

- In `/bower_components/core-icons/`, `core-icons.html` was renamed to `original-core-icons.html`, and the new `core-icons.html` contains only icons that's used by the app.

- Do NOT import any other files inside `/bower_components/core-icons/`, such as `image-icons.html`. If we use some icons in those files, copy that icon into a file named `selected-icons.html`. This doesn't guarantee to work, test it.

- Do NOT import any other icon libraries, such as 'awesome-fonts'. If you want to use third party SVG file as icon, put it into `other-icons.html`.

- Localization is done by putting message in each language to its own file, such as `messages_zh.json` and `messages_en.json`.
 