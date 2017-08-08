/*'use strict';

var gulp = require('gulp'),
  gulpProtractorAngular = require('gulp-angular-protractor');

gulp.src('./cucumber-test-results.json')
    .pipe(protractorReport({
        dest: 'reports/'
    }));


// Setting up the test task
gulp.task('protractor', function(callback) {
  gulp
    .src(['features/*.feature'])
    .pipe(gulpProtractorAngular({
      'configFile': 'cucumber.conf.js',
      'debug': true,
      'autoStartStopServer': true
    }))
    .on('error', function(e) {
      console.log(e);
    })
    .on('end', callback);
});*/


var gulp = require('gulp');
var protractor = require("gulp-protractor").protractor;
var reporter = require("gulp-protractor-cucumber-html-report");

/*gulp.task('execute',function () {
        return gulp.src([])
            .pipe(protractor({
                configFile: "cucumber.conf.js"
            }))
            .on('error', function(e) { throw e })
    }
);*/

gulp.task('execute',function () {
        return gulp.src([])
            .pipe(protractor({
                configFile: "cucumber.conf.js",
                args:[
                    '--cucumberOpts.tags', '@smoke'
                ]
            }))
            .on('error', onError)
            .pipe(gulp.dest('dist'));
    }
);

function onError(err) {
    console.log(err);
    this.emit('end');
}

gulp.task('report', ['execute'],function () {
    gulp.src("reports/results.json")
        .pipe(reporter({
            dest: "reports"
        }));

});

gulp.task('default',['execute','report']);
//gulp.task('default',['report']);