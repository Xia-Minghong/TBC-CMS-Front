'use strict'
class App extends App
  constructor: ->
    return [
      'ngResource'
      'ngCookies'
      'ngMessages'
      'ngAnimate'
      'ngTouch'
      'ngSanitize'
      'ngRoute' ]

class Routes extends Config
  constructor: ($routeProvider) ->
    $routeProvider
    .when '/',
      controller: 'homeController'
      templateUrl: 'index.html'
    .otherwise
      redirectTo: '/'

class Home extends Controller
  constructor: ($scope) ->
    $scope.name = 'hello world!'

