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
    'ng.django.websocket',
  ]
  .config ['djangoWebsocketProvider', '$routeProvider', (djangoWebsocketProvider, $routeProvider) ->

    djangoWebsocketProvider.setURI('ws://localhost:8000/ws/')
    djangoWebsocketProvider.setLogLevel('debug')
    djangoWebsocketProvider.setHeartbeat("--heartbeat--")

    $routeProvider
      .when '/',
        templateUrl: 'views/index.html'
        controller: 'MainCtrl'
        controllerAs: 'index'

      .when '/kdm',
        templateUrl: 'views/kdm.html'
        controller: 'KDMCtrl'
        controllerAs: 'kdm'

      .when '/public',
        templateUrl: 'views/public.html'
        controller: 'PublicCtrl'
        controllerAs: 'public'

      .when '/create-crisis',
        templateUrl: 'views/create-crisis.html'
        controller: 'CreateCrisisCtrl'
        controllerAs: 'create-crisis'

      .when '/crisis-update',
        templateUrl: 'views/crisis-update.html'
        controller: 'CrisisUpdateCtrl'
        controllerAs: 'crisis-update'

      .when '/about',
        templateUrl: 'views/about.html'
        controller: 'AboutCtrl'
        controllerAs: 'about'

      .otherwise
        redirectTo: '/'
  ]

window.App = {}
App.host_addr = "http://localhost:8000"


