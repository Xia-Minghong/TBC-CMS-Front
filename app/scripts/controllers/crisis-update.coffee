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

  if !$scope.crisisUpdateInitialized
    crisisUpdateInit()
    $scope.crisisUpdateInitialized = true


  return