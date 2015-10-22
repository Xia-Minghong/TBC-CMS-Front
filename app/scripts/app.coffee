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
    'ui.bootstrap',
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

      .when '/about',
        templateUrl: 'views/about.html'
        controller: 'AboutCtrl'
        controllerAs: 'about'

      .otherwise
        redirectTo: '/'
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
window.App = {}
App.host_addr = "http://localhost:8000"


