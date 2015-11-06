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
      return Incident.approveIncident("", $scope.object.id, function(data) {
        $uibModalInstance.close("");
        $rootScope.init();
      });
    };
    $scope.incidentReject = function() {
      return Incident.rejectIncident("", $scope.object.id, function(data) {
        if (data.id) {
          $uibModalInstance.close("");
        }
      });
    };
    $scope.incidentArchive = function() {
      return Incident.archiveIncident("", $scope.object.id, function(data) {
        if (data.id) {
          $uibModalInstance.close("");
        }
      });
    };
    $scope.dispatchApprove = function() {
      Incident.approveIncidentDispatch("", $scope.object.incident.id, $scope.object.id, function(data) {
        $uibModalInstance.close("");
      });
    };
    $scope.dispatchReject = function() {
      Incident.rejectIncidentDispatch("", $scope.object.incident.id, $scope.object.id, function(data) {
        $uibModalInstance.close("");
      });
    };
    $scope.updateApprove = function() {
      Incident.approveIncidentUpdate("", $scope.object.incident.id, $scope.object.id, function(data) {
        $uibModalInstance.close("");
      });
    };
    $scope.updateReject = function() {
      Incident.rejectIncidentUpdate("", $scope.object.incident.id, $scope.object.id, function(data) {
        $uibModalInstance.close("");
      });
    };
  });

}).call(this);

//# sourceMappingURL=incidentModal.js.map
