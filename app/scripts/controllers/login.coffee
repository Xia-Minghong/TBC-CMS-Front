'use strict'

###*
 # @ngdoc function
 # @name tbcCmsFrontApp.controller:AboutCtrl
 # @description
 # # AboutCtrl
 # Controller of the tbcCmsFrontApp
###
angular.module 'tbcCmsFrontApp'
.controller 'UserLoginCtrl', ($scope, Incident)->
  if !$scope.loginInitialized
    initLogin($scope)
    $scope.loginInitialized = true
  return
