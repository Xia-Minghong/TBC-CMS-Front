(function() {
  angular.module('tbcCmsFrontApp').controller('incidentModalCtrl', function($scope, $rootScope, $uibModalInstance, Incident, inci_id, type, id) {
    $scope.object = {};
    $scope.type = type;
    $scope.init = function() {
      console.log(type);
      switch (type) {
        case "incident":
          Incident.getIncident("", inci_id, function(incident) {
            return $scope.object = incident;
          });
          break;
        case "updates":
          Incident.getIncidentUpdate("", inci_id, id, function(update) {
            return $scope.object = update;
          });
          break;
        case "dispatch":
          Incident.getIncidentDispatch("", inci_id, id, function(dispatch) {
            return $scope.object = dispatch;
          });
          break;
        default:
          console.log("error");
      }
    };
    $scope.ok = function() {
      alert("ok");
    };
    $scope.cancel = function() {
      $uibModalInstance.dismiss('cancel');
    };
  });

}).call(this);

//# sourceMappingURL=incidentModal.js.map
