'use strict'

###*
 # @ngdoc function
 # @name tbcCmsFrontApp.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the tbcCmsFrontApp
###
angular.module 'tbcCmsFrontApp'
  .controller 'MainCtrl', ($scope, $rootScope, $location, $uibModal, djangoWebsocket, Incident, Agency)->

    # connect websocket
    djangoWebsocket.connect($rootScope, 'incidents', 'incidents', ['subscribe-broadcast', 'publish-broadcast']);

    # check if the tab is active
    $scope.isActive = (viewLocation) ->
      return (viewLocation == $location.path());

    # global initialization
    $rootScope.init = ()->
      #send an empty token and a callback to the Incident Service
      Incident.getIncidents "", (data)->
        # what to do after getting data
        $rootScope.incidents = data;
        return

      # load agencies
      Agency.getAgencies "", (data)->
        # what to do after getting data
        $rootScope.agencies = data;
        return

    # pagination
    $scope.currentPage = 0;
    $scope.pageSize = 10;
    $scope.goPage = (n)->
      $scope.currentPage = n


    # map
    $scope.$on '$viewContentLoaded', ->
      setTimeout(initMap, 600)
      return


    # modal
    $scope.open = (size) ->
      modalInstance = $uibModal.open(
        animation: true
        templateUrl: 'views/incidentModal.html'
        controller: 'incidentModalCtrl'
        size: size
        backdrop: "static"
        resolve: items: ->
          $scope.items
      )
      modalInstance.result.then ((selectedItem) ->
        $scope.selected = selectedItem
        return
      ), ->
        console.log 'Modal dismissed at: ' + new Date
        return
      return

    $scope.toggleAnimation = ->
      $scope.animationsEnabled = !$scope.animationsEnabled
      return

    return
