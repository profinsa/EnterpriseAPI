const puppeteer = require('puppeteer'),
      express = require('express'),
      bodyParser = require('body-parser');

//var baseUrl = 'http://localhost:8080/#!/documentForPrint/89';
function generate(url, filename, cb){
    (async () => {
	const browser = await puppeteer.launch({args: ['--no-sandbox']});
	const page = await browser.newPage();
	await page.goto(url, {waitUntil: 'networkidle2'});
	await page.pdf({path: filename +'.pdf', format: 'A4'});
	console.log("generating pdf for " + url);

	await browser.close();
	cb();
    })();
}

////////////////////////////////////////
//express settings
var app = express();
app.use(bodyParser.json()); // for parsing application/json
app.use(bodyParser.urlencoded({ extended: true })); // for parsing application/x-www-form-urlencoded
app.use(function(req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    next();
});

//test ping pong method
app.get('/date', function (req, res){
    var today = new Date();
    today.setTime(today.getTime() + 1000*60*60*24*10);
    res.end(today.toString());
});

app.get('/generatePdf', function (req, res){
    var url = req.query.url;
    if(!url){
	res.status(400);
	res.setHeader('Content-Type', 'application/json');
	res.send(JSON.stringify({ message : "url is missed"} , null, 3));
	return;
    }

    var filename = url.replace(/[:/\\#\!]/g, "");
    generate(url, filename, function(){
	//console.log("hi");
	res.sendFile(__dirname + '/' + filename + '.pdf');
    });
});

app.listen(3900, function () {
    console.log('Fresenius server listening on port ' + 3900);
});
