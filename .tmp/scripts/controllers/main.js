(function() {
  'use strict';

  /**
    * @ngdoc function
    * @name tbcCmsFrontApp.controller:MainCtrl
    * @description
    * # MainCtrl
    * Controller of the tbcCmsFrontApp
   */
  angular.module('tbcCmsFrontApp').controller('MainCtrl', function($scope, $rootScope, $location, $uibModal, djangoWebsocket, Incident, Agency) {
    djangoWebsocket.connect($rootScope, 'incidents', 'incidents', ['subscribe-broadcast', 'publish-broadcast']);
    $scope.isActive = function(viewLocation) {
      return viewLocation === $location.path();
    };
    $rootScope.init = function() {
      Incident.getIncidents("", function(data) {
        $rootScope.incidents = data;
      });
      return Agency.getAgencies("", function(data) {
        $rootScope.agencies = data;
      });
    };
    $scope.currentPage = 0;
    $scope.pageSize = 10;
    $scope.goPage = function(n) {
      return $scope.currentPage = n;
    };
    $scope.$on('$viewContentLoaded', function() {
      initMap();
    });
    $scope.open = function(size) {
      var modalInstance;
      modalInstance = $uibModal.open({
        animation: true,
        templateUrl: 'views/incidentModal.html',
        controller: 'incidentModalCtrl',
        size: size,
        backdrop: "static",
        resolve: {
          items: function() {
            return $scope.items;
          }
        }
      });
      modalInstance.result.then((function(selectedItem) {
        $scope.selected = selectedItem;
      }), function() {
        console.log('Modal dismissed at: ' + new Date);
      });
    };
    $scope.toggleAnimation = function() {
      $scope.animationsEnabled = !$scope.animationsEnabled;
    };
  });

}).call(this);

//# sourceMappingURL=main.js.map
