angular.module 'tbcCmsFrontApp'
.controller 'mapIncidentModalCtrl', ($scope, $rootScope, $uibModal, $uibModalInstance, incident) ->

  incident.displayType = $rootScope.incidentTypeDict[incident.type]
  $scope.incident = incident


  $scope.selected = item: "sth"

  $scope.ok = ->
    $uibModalInstance.close $scope.selected.item
    return

  $scope.cancel = ->
    $uibModalInstance.dismiss 'cancel'
    return

  initMapIncidentModal($scope)

  return
