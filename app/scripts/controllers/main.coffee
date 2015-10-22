'use strict'

###*
 # @ngdoc function
 # @name tbcCmsFrontApp.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the tbcCmsFrontApp
###
angular.module 'tbcCmsFrontApp'
  .controller 'MainCtrl', ($scope, $location, Incident, djangoWebsocket)->

    $scope.my_collection = {}

    djangoWebsocket.connect($scope, 'my_collection', 'my_collection', ['subscribe-broadcast', 'publish-broadcast']);

    $scope.incidents = []

    $scope.isActive = (viewLocation) ->
      return (viewLocation == $location.path());

    $scope.getIncidents = ()->
      #send an empty token and a callback to the Incident Service
      Incident.getIncidents "", (data)->
        # what to do after getting data
        $scope.incidents = data;
        return

    # Websocket

    $scope.$on '$viewContentLoaded', ->
      setTimeout(initMap, 600)
      return

    return
