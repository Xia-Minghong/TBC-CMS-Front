(function() {
  'use strict';

  /**
    * @ngdoc function
    * @name tbcCmsFrontApp.controller:CreateCrisisCtrl
    * @description
    * # CreateCrisisCtrl
    * Controller of the tbcCmsFrontApp
   */
  angular.module('tbcCmsFrontApp').controller('CreateCrisisCtrl', function($scope, Incident) {
    window.testScope = $scope;
    $scope.submitReport = function() {
      var r;
      r = $scope.report;
      if (r && r.type && r.name && r.severity && r.time && r.address && r.location && r.location.longitude && r.location.latitude && r.contact) {
        console.log($scope.report);
        Incident.postIncident("", r, function(success) {
          if (success) {
            return console.log("post success");
          } else {
            return console.log("post fail");
          }
        });
      } else {
        console.log("Form incomplete!");
      }
    };
    $scope.$on('$viewContentLoaded', function() {
      return initMap();
    });
    if (!$scope.crisisReportInitialized) {
      createCrisisInit($scope);
      $scope.crisisReportInitialized = true;
    }
  });

}).call(this);

//# sourceMappingURL=create-crisis.js.map
