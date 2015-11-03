(function() {
  'use strict';

  /**
    * @ngdoc function
    * @name tbcCmsFrontApp.controller:CrisisUpdateCtrl
    * @description
    * # CrisisUpdateCtrl
    * Controller of the tbcCmsFrontApp
   */
  angular.module('tbcCmsFrontApp').controller('CrisisUpdateCtrl', function($scope, $route, $routeParams, Incident) {
    $scope.init = function() {
      console.log("init");
      return Incident.getIncident("", $routeParams.incidentId, function(incident) {
        console.log("get");
        console.log(incident);
        $scope.incident = incident;
      });
    };
    $scope.submitUpdate = function() {
      var r;
      r = $scope.update;
      if (r && r.severity && r.time && r.description) {
        console.log($routeParams);
        Incident.postIncidentUpdate("", $routeParams.incidentId, r, function(success) {
          if (success) {
            $scope.errorMsg = "";
            $scope.successMsg = "Submit Success";
            return $route.reload();
          } else {
            return $scope.errorMsg = "Submit Error";
          }
        });
      } else {
        $scope.errorMsg = "Form incomplete!";
      }
    };
    if (!$scope.crisisUpdateInitialized) {
      crisisUpdateInit();
    }
    $scope.crisisUpdateInitialized = true;
  });

}).call(this);

//# sourceMappingURL=crisis-update.js.map
