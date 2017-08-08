exports.config = {
    //seleniumAddress: 'http://127.0.0.1:4444/wd/hub',
    getPageTimeout: 100000,
    allScriptsTimeout: 1000000,
    framework: 'custom',
    // path relative to the current config file
    frameworkPath: require.resolve('protractor-cucumber-framework'),

    capabilities: {
        'browserName': 'chrome'
    },

    // Spec patterns are relative to this directory.
    specs: [
        'features/*.feature'
    ],

   // baseURL: 'https://www.audi.co.uk',

    cucumberOpts: {
        require: ['env.js','features/step_definitions/*.js','support/*.js'],
        tags: true,
        //resultJsonOutputFile: 'report.json',
        //format: ['json:reports/results.json','pretty'],
        //format: ['pretty'],
        profile: false,
        keepAlive: false,
        'no-source': true
    },

    onPrepare: function(){
        browser.manage().window().maximize();
    },

    ignoreUncaughtExceptions: true
};