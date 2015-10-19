'use strict'

###*
 # @ngdoc overview
 # @name tbcCmsFrontApp
 # @description
 # # tbcCmsFrontApp
 #
 # Main module of the application.
###
angular
  .module 'tbcCmsFrontApp', [
    'ngAnimate',
    'ngCookies',
    'ngMessages',
    'ngResource',
    'ngRoute',
    'ngSanitize',
    'ngTouch',
    'angularMoment',
  ]
  .config ($routeProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'views/index.html'
        controller: 'MainCtrl'
        controllerAs: 'index'

      .when '/public',
        templateUrl: 'views/public.html'
        controller: 'PublicCtrl'
        controllerAs: 'public'

      .when '/about',
        templateUrl: 'views/about.html'
        controller: 'AboutCtrl'
        controllerAs: 'about'

      .otherwise
        redirectTo: '/'

window.App = {}
App.host_addr = "http://localhost:8000"


