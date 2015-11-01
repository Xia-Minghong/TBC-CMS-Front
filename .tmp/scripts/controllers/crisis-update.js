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
      console.log($scope.update);
    };
    if (!$scope.crisisUpdateInitialized) {
      crisisUpdateInit();
    }
    $scope.crisisUpdateInitialized = true;
  });

}).call(this);

//# sourceMappingURL=crisis-update.js.map
