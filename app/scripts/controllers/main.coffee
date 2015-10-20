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

    djangoWebsocket.connect($scope, 'subscribe_data', 'subscribe_data', ['subscribe-broadcast', 'publish-broadcast']);

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




    return
