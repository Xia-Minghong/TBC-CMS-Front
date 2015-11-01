'use strict'

###*
 # @ngdoc function
 # @name tbcCmsFrontApp.controller:AboutCtrl
 # @description
 # # AboutCtrl
 # Controller of the tbcCmsFrontApp
###
angular.module 'tbcCmsFrontApp'
  .controller 'PublicCtrl', ($scope, Incident) ->
    @awesomeThings = [
      'HTML5 Boilerplate'
      'AngularJS'
      'Karma'
    ]
    $scope.$on '$viewContentLoaded', ->
      initMap($scope)
      return
    # NEA API
    if !$scope.NEAAPIInitialized
      initNEAAPI($scope)
      $scope.NEAAPIInitialized = true
    return
