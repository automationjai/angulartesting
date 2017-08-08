//features/step_definitions/my_step_definitions.js
var homepage = require('../pages/homepage.js');


var chai = require('chai');
var chaiAsPromised = require('chai-as-promised');

chai.use(chaiAsPromised);
var expect = chai.expect;

module.exports = function () {

    this.When(/^I login as admin$/, function() {

        //browser.ignoreSynchronization = true;
        //homepage.go('https://www.sysprd.plumbcenter.co.uk/')
        //homepage.login('ebs8@salmon.com', 'salmon100');
        homepage.go('https://www.audi.co.uk');
    });


    this.Then(/^I should be loggedin$/, function (callback) {
        var logOutButton = homepage.plumbcentreHomepage.logoutBtn;
        //expect(logOutButton.isPresent()).to.eventually.equal(true).and.notify(callback);
    });



};
