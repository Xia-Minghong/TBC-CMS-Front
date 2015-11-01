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
    djangoWebsocket.connect($rootScope, 'pushes', 'pushes', ['subscribe-broadcast', 'publish-broadcast']);
    $rootScope.$watchGroup(['incidents', 'allIncidentUpdates', 'allIncidentDispatches'], function() {
      console.log("change");
      $scope.todoList = $scope.compileTodoList();
      console.log($rootScope.allIncidentDispatches);
    });
    $scope.isActive = function(viewLocation) {
      return viewLocation === $location.path();
    };
    $rootScope.init = function() {
      Incident.getIncidents("", function(data) {
        $rootScope.incidents = data;
      });
      Incident.allIncidentUpdates("", function(data) {
        $rootScope.allIncidentUpdates = data;
      });
      Incident.allIncidentDispatches("", function(data) {
        $rootScope.allIncidentDispatches = data;
      });
      Agency.getAgencies("", function(data) {
        $rootScope.agencies = data;
      });
    };
    $scope.compileTodoList = function() {
      var allIncidentDispatches, allIncidentUpdates, incident, todo, todoIncident, _i, _len, _ref;
      todo = [];
      _ref = $rootScope.incidents;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        incident = _ref[_i];
        todoIncident = angular.copy(incident);
        todoIncident.todoType = "incident";
        todo.push(todoIncident);
      }
      allIncidentUpdates = Object.keys($rootScope.allIncidentUpdates).map(function(k) {
        var update;
        update = angular.copy($rootScope.allIncidentUpdates[k]);
        update.todoType = "update";
        return update;
      });
      todo = todo.concat(allIncidentUpdates);
      allIncidentDispatches = Object.keys($rootScope.allIncidentDispatches).map(function(k) {
        var dispatch;
        dispatch = angular.copy($rootScope.allIncidentDispatches[k]);
        dispatch.todoType = "dispatch";
        return dispatch;
      });
      todo = todo.concat(allIncidentDispatches);
      return todo;
    };
    $scope.currentPage = 0;
    $scope.pageSize = 10;
    $scope.goPage = function(n) {
      return $scope.currentPage = n;
    };
    $scope.$on('$viewContentLoaded', function() {
      initMap($rootScope);
    });
    if (!$scope.NEAAPIInitialized) {
      initNEAAPI($scope);
      $scope.NEAAPIInitialized = true;
    }
    $rootScope.systemLogs = [];
    $rootScope.$watchCollection('pushes', function() {
      console.log("syslog change");
      if ($rootScope.pushes.syslog && $rootScope.systemLogs.length < 1 || $rootScope.pushes.syslog && $rootScope.systemLogs.length >= 1 && $rootScope.pushes.syslog.id !== $rootScope.systemLogs[$rootScope.systemLogs.length - 1].id) {
        $rootScope.systemLogs.push($rootScope.pushes.syslog);
        $rootScope.systemLogs[$rootScope.systemLogs.length - 1].time = moment($rootScope.systemLogs[$rootScope.systemLogs.length - 1].time, "YYYY-MM-DDThh:mm:ssZ").format("DD/MM/YYYY hh:mm:ss");
        return;
      }
    });
    $rootScope.openMapModal = function(id) {
      var incident;
      incident = Incident.getIncident("", id, function(incident) {
        var modalInstance;
        modalInstance = $uibModal.open({
          animation: true,
          templateUrl: 'views/mapIncidentModal.html',
          controller: 'mapIncidentModalCtrl',
          resolve: {
            incident: function() {
              return incident;
            }
          }
        });
        modalInstance.result.then((function(selectedItem) {
          $scope.selected = selectedItem;
        }), function() {
          console.log('Modal dismissed at: ' + new Date);
        });
      });
    };
    $scope.open = function(type, id) {
      var modalInstance;
      modalInstance = $uibModal.open({
        animation: true,
        templateUrl: 'views/incidentModal.html',
        controller: 'incidentModalCtrl',
        resolve: {
          id: function() {
            return id;
          },
          type: function() {
            return type;
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
