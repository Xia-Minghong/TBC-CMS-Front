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
                console.log("post success")
              else
                console.log("post fail")

        else
            console.log "Form incomplete!"
        return

    $scope.$on '$viewContentLoaded', ->
        initMap()


    if !$scope.crisisReportInitialized
        createCrisisInit($scope)
        $scope.crisisReportInitialized = true


    return
