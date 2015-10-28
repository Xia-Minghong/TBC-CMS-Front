'use strict'

###*
 # @ngdoc function
 # @name tbcCmsFrontApp.controller:CreateCrisisCtrl
 # @description
 # # CreateCrisisCtrl
 # Controller of the tbcCmsFrontApp
###
angular.module 'tbcCmsFrontApp'
.controller 'CreateCrisisCtrl', ($scope)->
    window.testScope = $scope
    $scope.submitReport = ->
        r = $scope.report
        if r and r.type and r.name and r.severity and r.time and r.address and r.location and r.location.longitude and r.location.latitude and r.contact and r.description
            console.log $scope.report
        else
            console.log "Form incomplete!"
        return

    $scope.$on '$viewContentLoaded', ->
        initMap()


    if !$scope.crisisReportInitialized
        createCrisisInit($scope)
        $scope.crisisReportInitialized = true


    return
