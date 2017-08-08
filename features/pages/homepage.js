'use strict';
module.exports = {

    audiHomepage: {
        yourAudiLink: element(by.cssContainingText('strong','youraudi'))
    },

    plumbcentreHomepage: {
        emailField: element(by.css('#WC_AccountDisplay_FormInput_logonId_In_Logon_1')),
        pwdField: element(by.css('#WC_AccountDisplay_FormInput_logonPassword_In_Logon_1')),
        loginBtn: element(by.css('#WC_AccountDisplay_links_2')),
        logoutBtn: element(by.css('#headerLogout'))
    },

    yourAudiHomepage: {
        emailField: element(by.id('loginForm-email')),
        pwdField: element(by.id('loginForm-emapasswordil')),
        loginBtn: element(by.buttonText('Log in')),
        register: element(by.css("a[href*='/account/signup']"))

    },


    go: function(site) {
        browser.get(site);
    },

    goyourAudi: function(){
        var audiHomepage = this.audiHomepage;
        audiHomepage.yourAudiLink.click();
    },

    login: function(email, password) {
        var yourAudiHomepage = this.yourAudiHomepage;
        yourAudiHomepage.emailField.clear();
        yourAudiHomepage.emailField.sendKeys(email);

        yourAudiHomepage.pwdField.clear();
        yourAudiHomepage.pwdField.sendKeys(password);

        yourAudiHomepage.loginBtn.click();

    }
};