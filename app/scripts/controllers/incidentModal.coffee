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

      when "update"
        Incident.getIncidentUpdate "", inci_id, id, (update)->
          $scope.object = update
          $scope.update = update
          $scope.incident = update.incident
          initIncidentModalUpdate($scope)

      when "dispatch"
        Incident.getIncidentDispatch "", inci_id, id, (dispatch)->
          $scope.object = dispatch
          $scope.dispatch = dispatch
          $scope.incident = dispatch.incident
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

  # Modal submit functions
  $scope.incidentApprove = ()->
    Incident.approveIncident "", $scope.object.id, (data)->
      # if success
      $uibModalInstance.close ""
      $rootScope.init()
      return

  $scope.incidentReject = ()->
    Incident.rejectIncident "", $scope.object.id, (data)->
      # if success
      if(data.id)
        $uibModalInstance.close ""
      return

  $scope.incidentArchive = ()->
    Incident.archiveIncident "", $scope.object.id, (data)->
      # if success
      if(data.id)
        $uibModalInstance.close ""
      return

  $scope.dispatchApprove = ()->
    Incident.approveIncidentDispatch "", $scope.object.incident.id, $scope.object.id, (data)->
      $uibModalInstance.close ""
      return

    return

  $scope.dispatchReject = ->
    Incident.rejectIncidentDispatch "", $scope.object.incident.id, $scope.object.id, (data)->
      $uibModalInstance.close ""
      return
    return

  $scope.updateApprove = ->
    Incident.approveIncidentUpdate "", $scope.object.incident.id, $scope.object.id, (data)->
      $uibModalInstance.close ""
      return
    return

  $scope.updateReject = ->
    Incident.rejectIncidentUpdate "", $scope.object.incident.id, $scope.object.id, (data)->
      $uibModalInstance.close ""
      return
    return

  return
