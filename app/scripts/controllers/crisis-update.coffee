'use strict'

###*
 # @ngdoc function
 # @name tbcCmsFrontApp.controller:CrisisUpdateCtrl
 # @description
 # # CrisisUpdateCtrl
 # Controller of the tbcCmsFrontApp
###
angular.module 'tbcCmsFrontApp'
.controller 'CrisisUpdateCtrl', ($scope)->

  $scope.submitUpdate = ->
      console.log $scope.update
      return

  if !$scope.crisisUpdateInitialized
      crisisUpdateInit()
  $scope.crisisUpdateInitialized = true


  return
