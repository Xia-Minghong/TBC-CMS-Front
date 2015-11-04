angular.module 'tbcCmsFrontApp'
.controller 'incidentModalCtrl', ($scope, $rootScope, $uibModalInstance, Incident, inci_id, type, id) ->

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

      when "updates"
        Incident.getIncidentUpdate $rootScope.userData.token, inci_id, id, (update)->
          $scope.object = update

      when "dispatch"
        Incident.getIncidentDispatch $rootScope.userData.token, inci_id, id, (dispatch)->
          $scope.object = dispatch

      else
        console.log "error"
    return



  $scope.ok = ->
    $uibModalInstance.close $scope.selected.item
    return

  $scope.cancel = ->
    $uibModalInstance.dismiss 'cancel'
    return

  return
