'use strict'

###*
 # @ngdoc function
 # @name tbcCmsFrontApp.controller:CrisisUpdateCtrl
 # @description
 # # CrisisUpdateCtrl
 # Controller of the tbcCmsFrontApp
###
angular.module 'tbcCmsFrontApp'
.controller 'CrisisUpdateCtrl', ($scope, $route, $routeParams, Incident)->

  $scope.init = ()->
    console.log("init")
    Incident.getIncident "", $routeParams.incidentId, (incident)->
      console.log("get")
      console.log(incident)
      $scope.incident = incident
      return

  $scope.submitUpdate = ->
      console.log $scope.update
      return

  if !$scope.crisisUpdateInitialized
      crisisUpdateInit()
  $scope.crisisUpdateInitialized = true


  return
