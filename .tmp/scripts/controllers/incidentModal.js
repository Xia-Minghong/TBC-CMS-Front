(function() {
  angular.module('tbcCmsFrontApp').controller('incidentModalCtrl', function($scope, $modalInstance, items) {
    $scope.items = items;
    $scope.selected = {
      item: "sth"
    };
    $scope.ok = function() {
      $modalInstance.close($scope.selected.item);
    };
    $scope.cancel = function() {
      $modalInstance.dismiss('cancel');
    };
  });

}).call(this);

//# sourceMappingURL=incidentModal.js.map
