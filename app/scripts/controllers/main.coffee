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

    # websocket
#    djangoWebsocket.connect($rootScope, 'allIncidentDispatches', 'dispatches', ['subscribe-broadcast', 'publish-broadcast'])
#    djangoWebsocket.connect($rootScope, 'allIncidentUpdates', 'inciupdates', ['subscribe-broadcast', 'publish-broadcast'])
#    djangoWebsocket.connect($rootScope, 'incidents', 'incidents', ['subscribe-broadcast', 'publish-broadcast'])
    djangoWebsocket.connect($rootScope, 'pushes', 'pushes', ['subscribe-broadcast', 'publish-broadcast'])

    $rootScope.$watchGroup ['incidents', 'allIncidentUpdates', 'allIncidentDispatches'], ->
      console.log("change")
      $scope.todoList = $scope.compileTodoList()
      console.log($rootScope.allIncidentDispatches)
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

      Incident.allIncidentUpdates "", (data)->
        # what to do after getting data
        $rootScope.allIncidentUpdates = data;
        return

      Incident.allIncidentDispatches "", (data)->
        # what to do after getting data
        $rootScope.allIncidentDispatches = data;
        return

      # load agencies
      Agency.getAgencies "", (data)->
        # what to do after getting data
        $rootScope.agencies = data;
        return
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
      return todo


    # pagination
    $scope.currentPage = 0;
    $scope.pageSize = 10;
    $scope.goPage = (n)->
      $scope.currentPage = n


    # map
    $scope.$on '$viewContentLoaded', ->
      initMap($rootScope)
      return

    # NEA API
    if !$scope.NEAAPIInitialized
      initNEAAPI($scope)
      $scope.NEAAPIInitialized = true


    # System Logs
    $rootScope.systemLogs = []
    $rootScope.$watchCollection 'pushes', ->
      console.log("syslog change")
      if($rootScope.pushes.syslog && $rootScope.systemLogs.length<1 || $rootScope.pushes.syslog && $rootScope.systemLogs.length>=1 && $rootScope.pushes.syslog.id!=$rootScope.systemLogs[$rootScope.systemLogs.length-1].id)
        $rootScope.systemLogs.push($rootScope.pushes.syslog)
        $rootScope.systemLogs[$rootScope.systemLogs.length-1].time = moment($rootScope.systemLogs[$rootScope.systemLogs.length-1].time, "YYYY-MM-DDThh:mm:ssZ").format("DD/MM/YYYY HH:mm:ss")
        return
      return


    # modals
    $rootScope.openMapModal = (id) ->
      incident = Incident.getIncident("", id, (incident)->
        modalInstance = $uibModal.open(
          animation: true
          templateUrl: 'views/mapIncidentModal.html'
          controller: 'mapIncidentModalCtrl'
#          backdrop: "static"
          resolve: incident: ->
            incident
        )
        modalInstance.result.then ((selectedItem) ->
          $scope.selected = selectedItem
          return
        ), ->
          console.log 'Modal dismissed at: ' + new Date
          return
        return
      )

      return

    $scope.open = (type, id) ->
      modalInstance = $uibModal.open(
        animation: true
        templateUrl: 'views/incidentModal.html'
        controller: 'incidentModalCtrl'
#        size: size
#        backdrop: "static"
        resolve:
          id: ->
            id
          type: ->
            type
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
