(function() {
  'use strict';

  /**
    * @ngdoc function
    * @name tbcCmsFrontApp.controller:CreateCrisisCtrl
    * @description
    * # CreateCrisisCtrl
    * Controller of the tbcCmsFrontApp
   */
  angular.module('tbcCmsFrontApp').controller('CreateCrisisCtrl', function($scope) {
    window.testScope = $scope;
    $scope.submitReport = function() {
      var r;
      r = $scope.report;
      if (r && r.type && r.name && r.severity && r.time && r.address && r.location && r.location.longitude && r.location.latitude && r.contact && r.description) {
        console.log($scope.report);
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
