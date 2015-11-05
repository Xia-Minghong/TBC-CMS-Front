angular.module 'tbcCmsFrontApp'
.controller 'incidentModalCtrl', ($scope, $rootScope, $uibModalInstance, Incident, todo, inci_id, type, id) ->

  $scope.object = {}
#  $scope.inci_id = inci_id
#  $scope.id = id
  $scope.type = type

  $scope.init = ->
    console.log type
    switch type
      when "incident"
        Incident.getIncident "", inci_id, (incident)->
          $scope.object = incident
          $scope.incident = incident
          initIncidentModalIncident($scope)

      when "updates"
        Incident.getIncidentUpdate "", inci_id, id, (update)->
          $scope.object = update
          initIncidentModalUpdate($scope)

      when "dispatch"
        Incident.getIncidentDispatch "", inci_id, id, (dispatch)->
          $scope.object = dispatch
          initIncidentModalDispatch($scope)

      else
        console.log "error"
    return



  $scope.ok = ->
#    $uibModalInstance.close $scope.selected.item
    alert("ok")
    return

  $scope.cancel = ->
    $uibModalInstance.dismiss 'cancel'
    return

  return
