
/**
 *  * Module dependencies.
 *   */

var express = require('express'),
    http = require('http'),
    path = require('path');

var app = express();

// all environments
app.set('port', process.argv[2] || 3000);
app.set('views', __dirname + '/views');
app.use(express.static(path.join(__dirname, '_site')));
//app.use(express.static(__dirname));


app.get('/', function(req, res){
    res.sendFile('index');
});
app.get('/resume', function(req, res){
    res.sendFile('/resume/');
});
app.get('*', function(req, res){
    res.sendFile('index');
});


http.createServer(app).listen(app.get('port'), function(){
    console.log('Express server listening on port ' + app.get('port'));
});
