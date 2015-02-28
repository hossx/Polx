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
