'use strict'

###*
 # @ngdoc function
 # @name tbcCmsFrontApp.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the tbcCmsFrontApp
###
angular.module 'tbcCmsFrontApp'
  .controller 'MainCtrl', ($scope, $rootScope, $location, djangoWebsocket, Incident, Agency)->

    $scope.my_collection = {}

    djangoWebsocket.connect($rootScope, 'incidents', 'incidents', ['subscribe-broadcast', 'publish-broadcast']);

    $scope.isActive = (viewLocation) ->
      return (viewLocation == $location.path());

    $rootScope.init = ()->
      #send an empty token and a callback to the Incident Service
      Incident.getIncidents "", (data)->
        # what to do after getting data
        $rootScope.incidents = data;
        return

      Agency.getAgencies "", (data)->
        # what to do after getting data
        $rootScope.agencies = data;
        return

    # Websocket

    $scope.$on '$viewContentLoaded', ->
      setTimeout(initMap, 600)
      return

    return
