angular.module 'tbcCmsFrontApp'
.controller 'incidentModalCtrl', ($scope, $uibModalInstance) ->

  $scope.ok = ->
    $uibModalInstance.close $scope.selected.item
    return

  $scope.cancel = ->
    $uibModalInstance.dismiss 'cancel'
    return

  return
