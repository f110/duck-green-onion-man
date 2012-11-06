var loadInProgress = false;
var progressIndex = 0;
var login_mail = "";
var login_passwd = "";

var page = require("webpage").create();
page.viewportSize = {width: 1024, height: 768};
var url = 'http://mixi.jp/';

page.onConsoleMessage = function(msg)  {
	console.log(msg);
};

page.onLoadStarted = function()  {
	loadInProgress = true;
	console.log("load started");
};

page.onLoadFinished = function()  {
	loadInProgress = false;
	console.log("load finished");
};

var steps = [
	// login to mixi.jp
	function() {
		page.open(url, function(status) {
			if (page.url == url) {
				page.evaluate(function(login_mail, login_passwd) {
					document.querySelector('input[name=email]').value = login_mail;
					document.querySelector('input[name=password]').value = login_passwd;
					document.querySelector('form').submit();
				}, login_mail, login_passwd);
			}
			if (page.url+"home.pl" == url) {
				loadInProgress = false;
				return;
			}
		});
	},
	function() {
		console.log("open message");
	}
];

interval = setInterval(function() {
	if (!loadInProgress && typeof steps[progressIndex] == "function") {
		console.log("step " + (progressIndex + 1));
		steps[progressIndex]();
		page.render("step" + (progressIndex + 1) + ".jpg");
		progressIndex++;
	}
	if (!loadInProgress && typeof steps[progressIndex] != "function") {
		console.log("test complete!");
		clearInterval(interval);
		phantom.exit();
	}
}, 50);
