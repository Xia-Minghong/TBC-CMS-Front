(function() {
  angular.module('tbcCmsFrontApp').controller('incidentModalCtrl', function($scope, $uibModalInstance, id, type) {
    $scope.ok = function() {
      $uibModalInstance.close($scope.selected.item);
    };
    $scope.cancel = function() {
      $uibModalInstance.dismiss('cancel');
    };
  });

}).call(this);

//# sourceMappingURL=incidentModal.js.map
