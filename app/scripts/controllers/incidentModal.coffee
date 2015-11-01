angular.module 'tbcCmsFrontApp'
.controller 'incidentModalCtrl', ($scope, $uibModalInstance, items) ->
  $scope.items = items
  $scope.selected = item: "sth"

  $scope.ok = ->
    $uibModalInstance.close $scope.selected.item
    return

  $scope.cancel = ->
    $uibModalInstance.dismiss 'cancel'
    return

  return
