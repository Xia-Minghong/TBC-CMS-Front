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
    r = $scope.update
    if r and r.severity and r.time and r.description
      console.log $routeParams
      Incident.postIncidentUpdate "", $routeParams.incidentId, r, (success)->
        if success
          $scope.errorMsg = ""
          $scope.successMsg = "Submit Success"
#          Incident.getIncidents()
          $route.reload();
        else
          $scope.errorMsg = "Submit Error"
    else
      $scope.errorMsg = "Form incomplete!"
    return

  if !$scope.crisisUpdateInitialized
      crisisUpdateInit()
  $scope.crisisUpdateInitialized = true


  return
