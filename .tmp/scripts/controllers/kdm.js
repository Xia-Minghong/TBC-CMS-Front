(function() {
  'use strict';

  /**
    * @ngdoc function
    * @name tbcCmsFrontApp.controller:AboutCtrl
    * @description
    * # AboutCtrl
    * Controller of the tbcCmsFrontApp
   */
  angular.module('tbcCmsFrontApp').controller('KDMCtrl', function($scope, Incident) {
    this.awesomeThings = ['HTML5 Boilerplate', 'AngularJS', 'Karma'];
    $scope.$on('$viewContentLoaded', function() {
      initMap($scope);
    });
    if (!$scope.NEAAPIInitialized) {
      initNEAAPI($scope);
      $scope.NEAAPIInitialized = true;
    }
  });

}).call(this);

//# sourceMappingURL=kdm.js.map
