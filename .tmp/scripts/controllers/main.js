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
    djangoWebsocket.connect($rootScope, 'pushes', 'pushes', ['subscribe-broadcast']);
    $scope.isActive = function(viewLocation) {
      return (viewLocation === $location.path()) || (viewLocation.length > 1 && $location.path().indexOf(viewLocation) >= 0);
    };
    $rootScope.init = function() {
      Incident.getIncidents("", function(data) {
        $rootScope.pushes.incidents = data;
        initMap($rootScope, resetMarkers);
      });
      Incident.allIncidentUpdates("", function(data) {
        $rootScope.pushes.inciupdates = data;
      });
      Incident.allIncidentDispatches("", function(data) {
        $rootScope.pushes.dispatches = data;
      });
      Agency.getAgencies("", function(data) {
        $rootScope.agencies = data;
      });
    };
    $rootScope.$watchGroup(['pushes'], function() {
      console.log("change");
      $scope.todoList = $scope.compileTodoList();
    });
    $scope.compileTodoList = function() {
      var allIncidentDispatches, allIncidentUpdates, incident, todo, todoIncident, _i, _len, _ref;
      todo = [];
      console.log("todo init");
      if ($rootScope.pushes.incidents) {
        _ref = $rootScope.pushes.incidents;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          incident = _ref[_i];
          todoIncident = angular.copy(incident);
          todoIncident.todoType = "incident";
          todo.push(todoIncident);
          console.log("todo");
        }
      }
      if ($rootScope.pushes.inciupdates) {
        allIncidentUpdates = Object.keys($rootScope.pushes.inciupdates).map(function(k) {
          var update;
          update = angular.copy($rootScope.pushes.inciupdates[k]);
          update.todoType = "update";
          return update;
        });
        todo = todo.concat(allIncidentUpdates);
      }
      if ($rootScope.pushes.dispatches) {
        allIncidentDispatches = Object.keys($rootScope.pushes.dispatches).map(function(k) {
          var dispatch;
          dispatch = angular.copy($rootScope.pushes.dispatches[k]);
          dispatch.todoType = "dispatch";
          return dispatch;
        });
        todo = todo.concat(allIncidentDispatches);
      }
      return todo;
    };
    $scope.currentPage = 0;
    $scope.pageSize = 10;
    $scope.goPage = function(n) {
      return $scope.currentPage = n;
    };
    $scope.$on('$viewContentLoaded', function() {
      if (!$scope.mapInitialized) {
        initMap($rootScope, resetMarkers);
        $scope.mapInitialized = true;
      }
    });
    initNEAAPI($scope);
    $rootScope.systemLogs = [];
    $rootScope.$watchCollection('pushes', function() {
      console.log("syslog change");
      $scope.todoList = $scope.compileTodoList();
      if ($rootScope.pushes.syslog && $rootScope.systemLogs.length < 1 || $rootScope.pushes.syslog && $rootScope.systemLogs.length >= 1 && $rootScope.pushes.syslog.id !== $rootScope.systemLogs[$rootScope.systemLogs.length - 1].id) {
        $rootScope.systemLogs.push($rootScope.pushes.syslog);
        $rootScope.systemLogs[$rootScope.systemLogs.length - 1].time = moment($rootScope.systemLogs[$rootScope.systemLogs.length - 1].time, "YYYY-MM-DDThh:mm:ssZ").format("DD/MM/YYYY HH:mm:ss");
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
    $scope.open = function(type, inci_id, id, todo) {
      var modalInstance;
      modalInstance = $uibModal.open({
        animation: true,
        templateUrl: 'views/incidentModal.html',
        controller: 'incidentModalCtrl',
        resolve: {
          todo: function() {
            return todo;
          },
          inci_id: function() {
            return inci_id;
          },
          type: function() {
            return type;
          },
          id: function() {
            return id;
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
