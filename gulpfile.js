var gulp = require('gulp');
var uglify = require('gulp-uglify');
var concat = require('gulp-concat');
var coffee = require('gulp-coffee');
var es = require('event-stream');
var ngClassify = require('gulp-ng-classify');
var fileinclude = require('gulp-file-include');
var bower = require('gulp-bower');
var sass = require('gulp-sass');
var sourcemaps = require('gulp-sourcemaps');
var minifyCSS = require('gulp-minify-css');

var config = {
  src: 'src',
  dist: 'public'
}

gulp.task('default', ['html', 'js', 'sass', 'lib'], function () {
});

gulp.task('sass', function() {
  return gulp.src(config.src + '/scss/*.scss')
  .pipe(sourcemaps.init())
  .pipe(sass())
  .pipe(sourcemaps.write())
  .pipe(minifyCSS())
  .pipe(gulp.dest(config.dist + '/static/css'));
});

gulp.task('js', function () {
  return gulp.src(config.src + '/js/*.coffee')
  .pipe(ngClassify())
  .pipe(coffee({bare: true}))
//  .pipe(uglify())
  .pipe(gulp.dest(config.dist + '/static/js'));
});

gulp.task('lib', function() {
  return bower()
  .pipe(gulp.dest(config.dist + '/static/libs'));
});

gulp.task('html', function() {
  return gulp.src([config.src + '/index.html'])
  .pipe(fileinclude({
    prefix: '@@',
    basepath: '@file'
  }))
  .pipe(gulp.dest(config.dist));
});

gulp.task('watch', function() {
  gulp.watch(config.src + '/js/*.coffee', ['js']);
  gulp.watch(config.src + '/scss/*.scss', ['sass']);
  gulp.watch(config.src + '/*.html', ['html']);
  gulp.watch(config.src + '/**/*.html', ['html']);
});
