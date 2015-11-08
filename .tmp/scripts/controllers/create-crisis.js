(function() {
  'use strict';

  /**
    * @ngdoc function
    * @name tbcCmsFrontApp.controller:CreateCrisisCtrl
    * @description
    * # CreateCrisisCtrl
    * Controller of the tbcCmsFrontApp
   */
  angular.module('tbcCmsFrontApp').controller('CreateCrisisCtrl', function($scope, $rootScope, $route, Incident) {
    window.testScope = $scope;
    $scope.submitReport = function() {
      var r;
      r = $scope.report;
      if (r && r.type && r.name && r.severity && r.time && r.location && r.location && r.longitude && r.latitude && r.contact && r['contact_name']) {
        console.log($scope.report);
        Incident.postIncident($rootScope.userData.token, r, function(success) {
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
    $scope.$on('$viewContentLoaded', function() {
      return initMapSelector();
    });
    if (!$scope.crisisReportInitialized) {
      Incident.getIncidentTypes($rootScope.userData.token, function(data) {
        $scope.incidentTypes = data;
      });
      createCrisisInit($scope);
      $scope.crisisReportInitialized = true;
    }
  });

}).call(this);

//# sourceMappingURL=create-crisis.js.map
