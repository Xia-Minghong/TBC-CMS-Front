(function() {
  angular.module('tbcCmsFrontApp').controller('incidentModalCtrl', function($scope, $rootScope, $uibModalInstance, Incident, todo, inci_id, type, id) {
    $scope.object = {};
    $scope.type = type;
    $scope.init = function() {
      console.log(type);
      switch (type) {
        case "incident":
          Incident.getIncident("", inci_id, function(incident) {
            $scope.object = incident;
            $scope.incident = incident;
            return initIncidentModalIncident($scope);
          });
          break;
        case "updates":
          Incident.getIncidentUpdate("", inci_id, id, function(update) {
            $scope.object = update;
            return initIncidentModalUpdate($scope);
          });
          break;
        case "dispatch":
          Incident.getIncidentDispatch("", inci_id, id, function(dispatch) {
            $scope.object = dispatch;
            return initIncidentModalDispatch($scope);
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
