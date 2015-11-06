(function() {
  angular.module('tbcCmsFrontApp').controller('incidentModalCtrl', function($scope, $rootScope, $uibModalInstance, Incident, todo, inci_id, type, id) {
    $scope.object = {};
    $scope.type = type;
    $scope.init = function() {
      console.log(type);
      switch (type) {
        case "incident":
          Incident.getIncident($rootScope.userData.token, inci_id, function(incident) {
            $scope.object = incident;
            $scope.incident = incident;
            return initIncidentModalIncident($scope);
          });
          break;
        case "update":
          Incident.getIncidentUpdate($rootScope.userData.token, inci_id, id, function(update) {
            $scope.object = update;
            $scope.update = update;
            $scope.incident = update.incident;
            return initIncidentModalUpdate($scope);
          });
          break;
        case "dispatch":
          Incident.getIncidentDispatch($rootScope.userData.token, inci_id, id, function(dispatch) {
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
      return Incident.approveIncident($rootScope.userData.token, $scope.object.id, function(data) {
        $uibModalInstance.close($rootScope.userData.token);
        $rootScope.init();
      });
    };
    $scope.incidentReject = function() {
      return Incident.rejectIncident($rootScope.userData.token, $scope.object.id, function(data) {
        if (data.id) {
          $uibModalInstance.close($rootScope.userData.token);
        }
      });
    };
    $scope.incidentArchive = function() {
      return Incident.archiveIncident($rootScope.userData.token, $scope.object.id, function(data) {
        if (data.id) {
          $uibModalInstance.close($rootScope.userData.token);
        }
      });
    };
    $scope.dispatchApprove = function() {
      Incident.approveIncidentDispatch($rootScope.userData.token, $scope.object.incident.id, $scope.object.id, function(data) {
        $uibModalInstance.close($rootScope.userData.token);
      });
    };
    $scope.dispatchReject = function() {
      Incident.rejectIncidentDispatch($rootScope.userData.token, $scope.object.incident.id, $scope.object.id, function(data) {
        $uibModalInstance.close($rootScope.userData.token);
      });
    };
    $scope.updateApprove = function() {
      Incident.approveIncidentUpdate($rootScope.userData.token, $scope.object.incident.id, $scope.object.id, function(data) {
        $uibModalInstance.close($rootScope.userData.token);
      });
    };
    $scope.updateReject = function() {
      Incident.rejectIncidentUpdate($rootScope.userData.token, $scope.object.incident.id, $scope.object.id, function(data) {
        $uibModalInstance.close($rootScope.userData.token);
      });
    };
  });

}).call(this);

//# sourceMappingURL=incidentModal.js.map
