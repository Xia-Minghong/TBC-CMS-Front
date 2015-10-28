angular.module 'tbcCmsFrontApp'
.controller 'incidentModalCtrl', ($scope, $modalInstance, items) ->
  $scope.items = items
  $scope.selected = item: "sth"

  $scope.ok = ->
    $modalInstance.close $scope.selected.item
    return

  $scope.cancel = ->
    $modalInstance.dismiss 'cancel'
    return

  return
