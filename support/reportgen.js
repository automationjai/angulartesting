var Cucumber = require('cucumber');
    fs = require('fs');
path = require('path');

var JsonFormatter = Cucumber.Listener.JsonFormatter();

var reportDirectory = 'reports/';
var reportFileName = 'results.json';

var reportDirectoryPath = path.join(__dirname, '../' + reportDirectory);
var reportFilePath = path.join(reportDirectoryPath + reportFileName);

function mkdirp(path, root) {
    var dirs = path.split('/'), dir = dirs.shift(), root = (root || '') + dir + '/';

    try {
        fs.mkdirSync(root);
    } catch (e) {
        if(!fs.statSync(root).isDirectory()) throw new Error(e);
    }

    return !dirs.length || mkdirp(dirs.join('/'), root);
}

module.exports = function JsonOutputHook() {
    JsonFormatter.log = function (json) {
        fs.open(reportFilePath, 'w+', function (err, fd) {
            if (err) {
                mkdirp(reportDirectoryPath);
                fd = fs.openSync(reportFilePath, 'w+');
            }

            fs.writeSync(fd, json);

            console.log('json file location: ' + reportFilePath);
        });
    };

    this.registerListener(JsonFormatter);
};

module.exports = function TakeScreenshot() {
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
};