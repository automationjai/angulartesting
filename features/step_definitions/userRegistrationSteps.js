var homepage = require('../pages/homepage.js');

var chai = require('chai');
var chaiAsPromised = require('chai-as-promised');

chai.use(chaiAsPromised);
var expect = chai.expect;


module.exports = function () {

    this.Given(/^I navigate to Audi homepage$/, function (callback) {
        browser.ignoreSynchronization = true;
         homepage.go('http://www.audi.co.uk');
    });

    this.When(/^I click on yourAudi link on homepage$/, function (callback) {
         homepage.goyourAudi();
    });

    this.Then(/^I navigate to yourAudi login homepage$/, function (callback) {
          expect(homepage.yourAudiHomepage.emailField.isPresent()).to.eventually.equal(true).and.notify(callback);
    });

    this.Then(/^I click on register link on yourAudi login page$/, function (callback) {

    });

    this.When(/^I enter all user details successfully$/, function (callback) {

    });

    this.Then(/^user success message is displayed$/, function (callback) {

    });


};
