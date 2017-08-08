//var outputDir = 'features';
/*this.After(function(scenario, callback) {
    if (scenario.isFailed()) {
        browser.takeScreenshot().then(function(base64png) {
            var decodedImage = new Buffer(base64png, 'base64').toString('binary');
            scenario.attach(decodedImage, 'image/png');
            callback();
        }, function(err) {
            callback(err);
        });
    } else {
        callback();
    }
});*/

/*module.exports = function TakeScreenshot() {
    this.After(function (scenario, callback) {
        if (scenario.isFailed()) {
            browser.takeScreenshot().then(function (png) {
                var decodedImage = new Buffer(png, 'base64').toString('binary');
                scenario.attach(decodedImage, 'image/png');

                callback();
            });
        } else {
            callback();
        }
    });
};*/

/*module.exports = function TakeScreenshot() {
    this.After(function (scenario, callback) {
        if (scenario.isFailed()) {
            browser.takeScreenshot().then(function (png) {
                var decodedImage = new Buffer(png.replace(/^data:image\/(png|gif|jpeg);base64,/, ''), 'base64');
                scenario.attach(decodedImage, 'image/png');
                callback();
            });
        }
        else {
            callback();
        }
    });
};*/



/*var createHtmlReport = function(sourceJson) {
    var CucumberHtmlReport = require('cucumber-html-report');
    var report = new CucumberHtmlReport({
        source: sourceJson, // source json
        dest: outputDir // target directory (will create if not exists)
    });
    report.createReport();
};

var JsonFormatter = Cucumber.Listener.JsonFormatter();
JsonFormatter.log = function(string) {
    if (!fs.existsSync(outputDir)) {
        fs.mkdirSync(outputDir);
    }

    var targetJson = outputDir + 'cucumber_report.json';
    fs.writeFile(targetJson, string, function(err) {
        if (err) {
            console.log('Failed to save cucumber test results to json file.');
            console.log(err);
        } else {
            createHtmlReport(targetJson);
        }
    });
};

this.registerListener(JsonFormatter);*/