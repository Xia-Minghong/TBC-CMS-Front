(function() {
  'use strict';

  /**
    * @ngdoc function
    * @name tbcCmsFrontApp.controller:AboutCtrl
    * @description
    * # AboutCtrl
    * Controller of the tbcCmsFrontApp
   */
  angular.module('tbcCmsFrontApp').controller('PublicCtrl', function($scope, Incident) {
    this.awesomeThings = ['HTML5 Boilerplate', 'AngularJS', 'Karma'];
    $scope.$on('$viewContentLoaded', function() {
      initMap();
    });
  });

}).call(this);

//# sourceMappingURL=public.js.map
