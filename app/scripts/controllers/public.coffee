'use strict'

###*
 # @ngdoc function
 # @name tbcCmsFrontApp.controller:AboutCtrl
 # @description
 # # AboutCtrl
 # Controller of the tbcCmsFrontApp
###
angular.module 'tbcCmsFrontApp'
  .controller 'PublicCtrl', ($scope) ->
    @awesomeThings = [
      'HTML5 Boilerplate'
      'AngularJS'
      'Karma'
    ]
    $scope.$on '$viewContentLoaded', ->
      initMap()
      return
    return
