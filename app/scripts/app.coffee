'use strict'

###*
 # @ngdoc overview
 # @name tbcCmsFrontApp
 # @description
 # # tbcCmsFrontApp
 #
 # Main module of the application.
###

window.App = {}
App.host_addr = "http://128.199.130.155:8000"
App.ws_addr = "ws://128.199.130.155:8000/ws/"

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
    'ui.bootstrap',
    'ngFileUpload',
    'LocalStorageModule',
  'angular.filter'
  ]
  .config ['djangoWebsocketProvider', '$routeProvider', (djangoWebsocketProvider, $routeProvider) ->

    djangoWebsocketProvider.setURI(App.ws_addr)
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

      .when '/crisis-update/:key',
        templateUrl: 'views/crisis-update.html'
        controller: 'CrisisUpdateCtrl'
        controllerAs: 'crisis-update'

      .when '/login',
        templateUrl: 'views/login.html'
        controller: 'UserLoginCtrl'
        controllerAs: 'login'

      .when '/about',
        templateUrl: 'views/about.html'
        controller: 'AboutCtrl'
        controllerAs: 'about'

      .otherwise
        redirectTo: '/login'
  ]

  .filter 'startFrom', ->
    (input, start) ->
      start = +start
      if (!input || !input.length)
        return
      #parse to int
      input.slice start

  .filter 'range', ->
    (input, total) ->
      total = parseInt(total)
      i = 0
      while i < total
        input.push i
        i++
      input

  .filter 'capitalize', ->
    (input) ->
      if ! !input then input.charAt(0).toUpperCase() + input.substr(1).toLowerCase() else ''




