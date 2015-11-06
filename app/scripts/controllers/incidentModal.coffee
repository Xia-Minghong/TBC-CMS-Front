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
        Incident.getIncident $rootScope.userData.token, inci_id, (incident)->
          $scope.object = incident
          $scope.incident = incident
          initIncidentModalIncident($scope)

      when "update"
        Incident.getIncidentUpdate $rootScope.userData.token, inci_id, id, (update)->
          $scope.object = update
          $scope.update = update
          $scope.incident = update.incident
          initIncidentModalUpdate($scope)

      when "dispatch"
        Incident.getIncidentDispatch $rootScope.userData.token, inci_id, id, (dispatch)->
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
    Incident.approveIncident $rootScope.userData.token, $scope.object.id, (data)->
      # if success
      $uibModalInstance.close $rootScope.userData.token
      $rootScope.init()
      return

  $scope.incidentReject = ()->
    Incident.rejectIncident $rootScope.userData.token, $scope.object.id, (data)->
      # if success
      if(data.id)
        $uibModalInstance.close $rootScope.userData.token
      return

  $scope.incidentArchive = ()->
    Incident.archiveIncident $rootScope.userData.token, $scope.object.id, (data)->
      # if success
      if(data.id)
        $uibModalInstance.close $rootScope.userData.token
      return

  $scope.dispatchApprove = ()->
    Incident.approveIncidentDispatch $rootScope.userData.token, $scope.object.incident.id, $scope.object.id, (data)->
      $uibModalInstance.close $rootScope.userData.token
      return

    return

  $scope.dispatchReject = ->
    Incident.rejectIncidentDispatch $rootScope.userData.token, $scope.object.incident.id, $scope.object.id, (data)->
      $uibModalInstance.close $rootScope.userData.token
      return
    return

  $scope.updateApprove = ->
    Incident.approveIncidentUpdate $rootScope.userData.token, $scope.object.incident.id, $scope.object.id, (data)->
      $uibModalInstance.close $rootScope.userData.token
      return
    return

  $scope.updateReject = ->
    Incident.rejectIncidentUpdate $rootScope.userData.token, $scope.object.incident.id, $scope.object.id, (data)->
      $uibModalInstance.close $rootScope.userData.token
      return
    return

  return
