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
        case "update":
          Incident.getIncidentUpdate("", inci_id, id, function(update) {
            $scope.object = update;
            $scope.update = update;
            $scope.incident = update.incident;
            return initIncidentModalUpdate($scope);
          });
          break;
        case "dispatch":
          Incident.getIncidentDispatch("", inci_id, id, function(dispatch) {
            $scope.object = dispatch;
            $scope.dispatch = dispatch;
            $scope.incident = dispatch.incident;
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
    $scope.incidentApprove = function() {
      alert("Approve incident");
    };
    $scope.incidentReject = function() {
      alert("Reject incident");
    };
    $scope.incidentArchive = function() {
      alert("Archive incident");
    };
    $scope.dispatchApprove = function() {
      alert("Approve dispatch");
    };
    $scope.dispatchReject = function() {
      alert("Reject dispatch");
    };
    $scope.updateApprove = function() {
      alert("Approve update");
    };
    $scope.updateReject = function() {
      alert("Reject update");
    };
  });

}).call(this);

//# sourceMappingURL=incidentModal.js.map
