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
    djangoWebsocket.connect($rootScope, 'allIncidentUpdates', 'inciupdates', ['subscribe-broadcast', 'publish-broadcast']);
    djangoWebsocket.connect($rootScope, 'allIncidentDispatches', 'dispatches', ['subscribe-broadcast', 'publish-broadcast']);


    $rootScope.$watchGroup ['incidents', 'allIncidentUpdates', 'allIncidentDispatches'], ->
      console.log("change")
      $scope.todoList = $scope.compileTodoList()
      return

    # check if the tab is active
    $scope.isActive = (viewLocation) ->
      return (viewLocation == $location.path());

    # global initialization
    $rootScope.init = ()->
      # Get incidents, updates and dispatches
      #send an empty token and a callback to the Incident Service
      Incident.getIncidents "", (data)->
        # what to do after getting data
        $rootScope.incidents = data;
        return

#      Incident.getAllIncidentUpdates "", (data)->
#        # what to do after getting data
#        $rootScope.allIncidentUpdates = data;
#        return
#
#      Incident.getAllIncidentDispatches "", (data)->
#        # what to do after getting data
#        $rootScope.allIncidentDispatches = data;
#        return

      # load agencies
      Agency.getAgencies "", (data)->
        # what to do after getting data
        $rootScope.agencies = data;
        return

      # Compile TODO lists

      return

    # Function for generating/updating todo list
    $scope.compileTodoList = ()->
      todo = []

      # add incidents
      for incident in $rootScope.incidents
        todoIncident = angular.copy(incident)
        todoIncident.todoType = "incident"
        todo.push(todoIncident)

      # convert and add updates
      allIncidentUpdates = Object.keys($rootScope.allIncidentUpdates).map((k) ->
        update = angular.copy($rootScope.allIncidentUpdates[k])
        update.todoType = "update"
        return update
      )
      todo = todo.concat(allIncidentUpdates)

      # convert and add dispatches
      allIncidentDispatches = Object.keys($rootScope.allIncidentDispatches).map((k) ->
        dispatch = angular.copy($rootScope.allIncidentDispatches[k])
        dispatch.todoType = "dispatch"
        return dispatch
      )
      todo = todo.concat(allIncidentDispatches)

#      console.log(allIncidentDispatches)


      return todo


    # pagination
    $scope.currentPage = 0;
    $scope.pageSize = 10;
    $scope.goPage = (n)->
      $scope.currentPage = n


    # map
    $scope.$on '$viewContentLoaded', ->
      initMap()
      return

    # NEA API
    if !$scope.NEAAPIInitialized
      initNEAAPI($scope)
      $scope.NEAAPIInitialized = true

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
