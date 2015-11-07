'use strict'

###*
 # @ngdoc function
 # @name tbcCmsFrontApp.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the tbcCmsFrontApp
###
angular.module 'tbcCmsFrontApp'
  .controller 'MainCtrl', ($scope, $rootScope, $location, $uibModal, djangoWebsocket, Incident, Agency, User,localStorageService)->



    # websocket
#    djangoWebsocket.connect($rootScope, 'allIncidentDispatches', 'dispatches', ['subscribe-broadcast', 'publish-broadcast'])
#    djangoWebsocket.connect($rootScope, 'allIncidentUpdates', 'inciupdates', ['subscribe-broadcast', 'publish-broadcast'])
#    djangoWebsocket.connect($rootScope, 'incidents', 'incidents', ['subscribe-broadcast', 'publish-broadcast'])
    djangoWebsocket.connect($rootScope, 'pushes', 'pushes', ['subscribe-broadcast'])

    $rootScope.doLogout = ->
      User.logout $rootScope.userData.token, ->
        localStorageService.remove("token")
        $rootScope.userData = {}
        $location.path("/login");
        console.log("logout success")
        return
      return

    # check if the tab is active
    $scope.isActive = (viewLocation) ->
      return (viewLocation == $location.path()) || (viewLocation.length>1 && $location.path().indexOf(viewLocation)>=0);


    # global initialization
    $rootScope.init = ()->
      $rootScope.initialized = false

      if($rootScope.userData==undefined)
        $rootScope.userData = {}
      token = localStorageService.get "token"
      if(token)
        User.getProfile token, (data)->
          $rootScope.userData = data
          $rootScope.userData.token = token

      # Access Control
      if localStorageService.get("token")==null
        $location.path("/public")


    # Get incidents, updates and dispatches
      #send an empty token and a callback to the Incident Service
      Incident.getIncidents $rootScope.userData.token, (data)->
        # what to do after getting data
        $rootScope.pushes.incidents = data;
        initMap($rootScope, resetMarkers)
        return

      Incident.allIncidentUpdates $rootScope.userData.token, (data)->
        # what to do after getting data
        $rootScope.pushes.inciupdates = data;
        return

      Incident.allIncidentDispatches $rootScope.userData.token, (data)->
        # what to do after getting data
        $rootScope.pushes.dispatches = data;
        return

      # load agencies
      Agency.getAgencies $rootScope.userData.token, (data)->
        # what to do after getting data
        $rootScope.agencies = data;
        return

      $rootScope.initialized = true
      return


    # Function for generating/updating todo list
    $scope.compileTodoList = ()->
      todo = []

      # add incidents
      console.log("todo init")
#      console.log($rootScope.pushes.incidents)
      if $rootScope.pushes.incidents
        for incident in $rootScope.pushes.incidents
          incident.todoType = "incident"
          if incident.status!="closed" and incident.status!="rejected"
            todo.push(incident)
#        console.log("todo")

      # convert and add updates
      if $rootScope.pushes.inciupdates
        for update in $rootScope.pushes.inciupdates
          update.todoType = "update"
          if !update.is_approved
            todo.push(update)
#        console.log("todo")
#        $rootScope.initialized = false
#        for index of $rootScope.pushes.inciupdates
#          $rootScope.pushes.inciupdates[index].todoType = "update"
#          if $rootScope.pushes.inciupdates[index].is_approved
#            $rootScope.pushes.inciupdates.splice(index, 1)
#        allIncidentUpdates = Object.keys($rootScope.pushes.inciupdates).map((k) ->
#          update = angular.copy($rootScope.pushes.inciupdates[k])
#          update.todoType = "update"
#          return update
#        )
#        allIncidentUpdates = $rootScope.pushes.inciupdates
#        todo = todo.concat($rootScope.pushes.inciupdates)
#        $rootScope.initialized = true

      # convert and add dispatches
      if $rootScope.pushes.dispatches
        for dispatch in $rootScope.pushes.dispatches
          dispatch.todoType = "dispatch"
          if !dispatch.is_approved
            todo.push(dispatch)
        console.log("todo")
#        $rootScope.initialized = false
#        for index of $rootScope.pushes.dispatches
#          $rootScope.pushes.dispatches[index].todoType = "dispatch"
#          if $rootScope.pushes.dispatches[index].is_approved
#            $rootScope.pushes.dispatches.splice(index, 1)
#        for index of $rootScope.pushes.dispatches
#          if $rootScope.pushes.dispatches[index].is_approved
#            $rootScope.pushes.dispatches.splice(index, 1)
#        allIncidentDispatches = Object.keys($rootScope.pushes.dispatches).map((k) ->
#          dispatch = angular.copy($rootScope.pushes.dispatches[k])
#          dispatch.todoType = "dispatch"
#          return dispatch
#        )
#        todo = todo.concat($rootScope.pushes.dispatches)
#        $rootScope.initialized = true
      return todo


    # pagination
    $scope.currentPage = 0;
    $scope.pageSize = 20;
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


    # Watcher
    $rootScope.systemLogs = []

    $rootScope.$watchCollection 'pushes', ->
      if $rootScope.initialized
        $scope.todoList = $scope.compileTodoList()
        resetMarkers($rootScope)
        console.log("change")

      # system log
      if($rootScope.pushes.syslog && $rootScope.systemLogs.length<1 || $rootScope.pushes.syslog && $rootScope.systemLogs.length>=1 && $rootScope.pushes.syslog.id!=$rootScope.systemLogs[$rootScope.systemLogs.length-1].id)
        $rootScope.systemLogs.push($rootScope.pushes.syslog)
        $rootScope.systemLogs[$rootScope.systemLogs.length-1].time = moment($rootScope.systemLogs[$rootScope.systemLogs.length-1].time, "YYYY-MM-DDThh:mm:ssZ").format("DD/MM/YYYY HH:mm:ss")
        return
      return


    # modals
    $rootScope.openMapModal = (id) ->
      incident = Incident.getIncident($rootScope.userData.token, id, (incident)->
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
