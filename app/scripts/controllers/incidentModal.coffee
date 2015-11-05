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
  $scope.incidentApprove = ->
    alert("Approve incident")
    return

  $scope.incidentReject = ->
    alert("Reject incident")
    return

  $scope.incidentArchive = ->
    alert("Archive incident")
    return

  $scope.dispatchApprove = ->
    alert("Approve dispatch")
    return

  $scope.dispatchReject = ->
    alert("Reject dispatch")
    return

  $scope.updateApprove = ->
    alert("Approve update")
    return

  $scope.updateReject = ->
    alert("Reject update")
    return

  return
