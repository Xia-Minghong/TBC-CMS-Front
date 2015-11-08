'use strict'

###*
 # @ngdoc function
 # @name tbcCmsFrontApp.controller:AboutCtrl
 # @description
 # # AboutCtrl
 # Controller of the tbcCmsFrontApp
###
angular.module 'tbcCmsFrontApp'
  .controller 'PublicCtrl', ($scope, $rootScope, Incident) ->

  # Watcher
    $scope.timeline = []

    $rootScope.$watchCollection 'pushes', ->
      if $rootScope.initialized
        $scope.timeline = $scope.compileTimeline()
        console.log("compileTimeline")
      return

    $scope.$on '$viewContentLoaded', ->
      initMap($scope, resetMarkers)
      $rootScope.isPublic = true
      return

    $scope.compileTimeline = ->
      timeline = []

      if $rootScope.pushes.incidents
        for incident in $rootScope.pushes.incidents
          incident.timelineType = "incident"
          incident.date = moment(incident.time).format("DD MMM. YYYY")
          incident.displayTime = moment(incident.time).format("HH:mm")
          if incident.status=="approved"
            timeline.push(incident)

      if $rootScope.pushes.inciupdates
        for update in $rootScope.pushes.inciupdates
          update.timelineType = "update"
          update.date = moment(update.time).format("DD MMM. YYYY")
          update.displayTime = moment(update.time).format("HH:mm")
          if update.is_approved
            timeline.push(update)

      if $rootScope.pushes.dispatches
        for dispatch in $rootScope.pushes.dispatches
          dispatch.timelineType = "dispatch"
          dispatch.date = moment(dispatch.time).format("DD MMM. YYYY")
          dispatch.displayTime = moment(dispatch.time).format("HH:mm")
          if dispatch.is_approved
            timeline.push(dispatch)


      return timeline

    # NEA API
    if !$scope.NEAAPIInitialized
      initNEAAPI($scope)
      $scope.NEAAPIInitialized = true
    return


