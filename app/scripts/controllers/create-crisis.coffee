'use strict'

###*
 # @ngdoc function
 # @name tbcCmsFrontApp.controller:CreateCrisisCtrl
 # @description
 # # CreateCrisisCtrl
 # Controller of the tbcCmsFrontApp
###
angular.module 'tbcCmsFrontApp'
.controller 'CreateCrisisCtrl', ($scope, $rootScope, $route, Incident)->
    window.testScope = $scope
    $scope.submitReport = ->
        r = $scope.report
        if r and r.type and r.name and r.severity and r.time and r.location and r.location and r.longitude and r.latitude and r.contact and r['contact_name']
            console.log $scope.report
            Incident.postIncident $rootScope.userData.token, r, (success)->
              if success
                $scope.errorMsg = ""
                $scope.successMsg = "Submit Success"
#                Incident.getIncidents()
                $route.reload();
              else
                $scope.errorMsg = "Submit Error"
        else
            $scope.errorMsg = "Form incomplete!"
        return

    $scope.$on '$viewContentLoaded', ->
        initMap()


    if !$scope.crisisReportInitialized
        #init crisis types
        Incident.getIncidentTypes $rootScope.userData.token, (data)->
          $scope.incidentTypes = data
          return
        createCrisisInit($scope)
        $scope.crisisReportInitialized = true


    return
