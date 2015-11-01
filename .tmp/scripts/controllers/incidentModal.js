(function() {
  angular.module('tbcCmsFrontApp').controller('incidentModalCtrl', function($scope, $uibModalInstance, items) {
    $scope.items = items;
    $scope.selected = {
      item: "sth"
    };
    $scope.ok = function() {
      $uibModalInstance.close($scope.selected.item);
    };
    $scope.cancel = function() {
      $uibModalInstance.dismiss('cancel');
    };
  });

}).call(this);

//# sourceMappingURL=incidentModal.js.map
