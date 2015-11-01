'use strict'

###*
 # @ngdoc function
 # @name tbcCmsFrontApp.controller:CreateCrisisCtrl
 # @description
 # # CreateCrisisCtrl
 # Controller of the tbcCmsFrontApp
###
angular.module 'tbcCmsFrontApp'
.controller 'CreateCrisisCtrl', ($scope, Incident)->
    window.testScope = $scope
    $scope.submitReport = ->
        r = $scope.report
        if r and r.type and r.name and r.severity and r.time and r.address and r.location and r.location.longitude and r.location.latitude and r.contact
            console.log $scope.report
            Incident.postIncident "", r, (success)->
              if success
                successMsg = "Submit Success"
              else
                errorMsg = "Submit Error"

        else
            console.log "Form incomplete!"
        return

    $scope.$on '$viewContentLoaded', ->
        initMap()


    if !$scope.crisisReportInitialized
        #init crisis types
        Incident.getIncidentTypes "", (data)->
          $scope.incidentTypes = data
          return
        createCrisisInit($scope)
        $scope.crisisReportInitialized = true


    return
