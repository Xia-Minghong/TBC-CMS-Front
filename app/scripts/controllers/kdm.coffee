'use strict'

###*
 # @ngdoc function
 # @name tbcCmsFrontApp.controller:AboutCtrl
 # @description
 # # AboutCtrl
 # Controller of the tbcCmsFrontApp
###
angular.module 'tbcCmsFrontApp'
.controller 'KDMCtrl', ($scope, $rootScope, $location, Incident)->
  if $rootScope.userData==undefined || $rootScope.userData.concreteuser==undefined
    $location.path("/public")

  $scope.$on '$viewContentLoaded', ->
    initMap($scope, resetMarkers)
    return
  # NEA API
  if !$scope.NEAAPIInitialized
    initNEAAPI($scope)
    $scope.NEAAPIInitialized = true
  return

