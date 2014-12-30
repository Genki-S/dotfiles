var http = require('http');
var fs = require('fs');

http.createServer(function (req, res) {
  if (req.method !== 'POST') {
    res.writeHead(404);
    res.end();
    return;
  }

  var dataStr = '';
  req.on('data', function(chunk) {
    dataStr += chunk.toString();
  });

  req.on('end', function() {
    var data = JSON.parse(dataStr);
    var file = process.env.HOME + '/unknown_words.txt';
    fs.appendFile(file, data.word + "\n", function(error) {
      console.log('APPENDED!');
    });
  });

  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end('word saved.\n');
}).listen(1337, '127.0.0.1');
