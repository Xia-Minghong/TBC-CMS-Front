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
    djangoWebsocket.connect($rootScope, 'pushes', 'pushes', ['subscribe-broadcast'])


    # check if the tab is active
    $scope.isActive = (viewLocation) ->
      return (viewLocation == $location.path()) || (viewLocation.length>1 && $location.path().indexOf(viewLocation)>=0);


    # global initialization
    $rootScope.init = ()->
      # Get incidents, updates and dispatches
      #send an empty token and a callback to the Incident Service
      Incident.getIncidents "", (data)->
        # what to do after getting data
        $rootScope.pushes.incidents = data;
        initMap($rootScope, resetMarkers)
        return

      Incident.allIncidentUpdates "", (data)->
        # what to do after getting data
        $rootScope.pushes.inciupdates = data;
        return

      Incident.allIncidentDispatches "", (data)->
        # what to do after getting data
        $rootScope.pushes.dispatches = data;
        return

      # load agencies
      Agency.getAgencies "", (data)->
        # what to do after getting data
        $rootScope.agencies = data;
        return
      return


    $rootScope.$watchGroup ['pushes'], ->
      console.log("change")
      $scope.todoList = $scope.compileTodoList()
      return

    # Function for generating/updating todo list
    $scope.compileTodoList = ()->
      todo = []

      # add incidents
      console.log("todo init")
#      console.log($rootScope.pushes.incidents)
      if $rootScope.pushes.incidents
        for incident in $rootScope.pushes.incidents
          todoIncident = angular.copy(incident)
          todoIncident.todoType = "incident"
          todo.push(todoIncident)
          console.log("todo")

      # convert and add updates
      if $rootScope.pushes.inciupdates
        allIncidentUpdates = Object.keys($rootScope.pushes.inciupdates).map((k) ->
          update = angular.copy($rootScope.pushes.inciupdates[k])
          update.todoType = "update"
          return update
        )
        todo = todo.concat(allIncidentUpdates)

      # convert and add dispatches
      if $rootScope.pushes.dispatches
        allIncidentDispatches = Object.keys($rootScope.pushes.dispatches).map((k) ->
          dispatch = angular.copy($rootScope.pushes.dispatches[k])
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
      if !$scope.mapInitialized
        initMap($rootScope, resetMarkers)
        $scope.mapInitialized = true
      return

    # NEA API
    initNEAAPI($scope)


    # System Logs
    $rootScope.systemLogs = []
    $rootScope.$watchCollection 'pushes', ->
      console.log("syslog change")
      $scope.todoList = $scope.compileTodoList()
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

    $scope.open = (type, inci_id, id, todo) ->
      modalInstance = $uibModal.open(
        animation: true
        templateUrl: 'views/incidentModal.html'
        controller: 'incidentModalCtrl'
#        size: size
#        backdrop: "static"
        resolve:
          todo: ->
            todo
          inci_id: ->
            inci_id
          type: ->
            type
          id: ->
            id
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
