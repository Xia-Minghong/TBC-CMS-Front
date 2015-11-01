angular.module 'tbcCmsFrontApp'
.controller 'mapIncidentModalCtrl', ($scope, $rootScope, $uibModal, $modalInstance, incident) ->


  $scope.incident = incident

  $scope.selected = item: "sth"

  $scope.ok = ->
    $modalInstance.close $scope.selected.item
    return

  $scope.cancel = ->
    $modalInstance.dismiss 'cancel'
    return

  initMapIncidentModal($scope)

  return
