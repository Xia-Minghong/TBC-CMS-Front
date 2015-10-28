(function() {
  'use strict';

  /**
    * @ngdoc function
    * @name tbcCmsFrontApp.controller:CrisisUpdateCtrl
    * @description
    * # CrisisUpdateCtrl
    * Controller of the tbcCmsFrontApp
   */
  angular.module('tbcCmsFrontApp').controller('CrisisUpdateCtrl', function($scope) {
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
