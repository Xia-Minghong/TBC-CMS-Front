(function() {
  'use strict';

  /**
    * @ngdoc function
    * @name tbcCmsFrontApp.controller:AboutCtrl
    * @description
    * # AboutCtrl
    * Controller of the tbcCmsFrontApp
   */
  angular.module('tbcCmsFrontApp').controller('KDMCtrl', function($scope, $rootScope, $location, Incident) {
    if ($rootScope.userData === void 0 || $rootScope.userData.concreteuser === void 0) {
      $location.path("/public");
    }
    $scope.$on('$viewContentLoaded', function() {
      initMap($scope, resetMarkers);
      $rootScope.isPublic = false;
    });
    if (!$scope.NEAAPIInitialized) {
      initNEAAPI($scope);
      $scope.NEAAPIInitialized = true;
    }
  });

}).call(this);

//# sourceMappingURL=kdm.js.map
