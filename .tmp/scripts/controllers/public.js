(function() {
  'use strict';

  /**
    * @ngdoc function
    * @name tbcCmsFrontApp.controller:AboutCtrl
    * @description
    * # AboutCtrl
    * Controller of the tbcCmsFrontApp
   */
  angular.module('tbcCmsFrontApp').controller('PublicCtrl', function($scope, $rootScope, Incident) {
    $scope.timeline = [];
    $rootScope.$watchCollection('pushes', function() {
      if ($rootScope.initialized) {
        $scope.timeline = $scope.compileTimeline();
        console.log("compileTimeline");
      }
    });
    $scope.$on('$viewContentLoaded', function() {
      initMap($scope, resetMarkers);
      $rootScope.isPublic = true;
    });
    $scope.compileTimeline = function() {
      var dispatch, incident, timeline, update, _i, _j, _k, _len, _len1, _len2, _ref, _ref1, _ref2;
      timeline = [];
      if ($rootScope.pushes.incidents) {
        _ref = $rootScope.pushes.incidents;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          incident = _ref[_i];
          incident.timelineType = "incident";
          incident.date = moment(incident.time).format("DD MMM. YYYY");
          incident.displayTime = moment(incident.time).format("HH:mm");
          if (incident.status === "approved") {
            timeline.push(incident);
          }
        }
      }
      if ($rootScope.pushes.inciupdates) {
        _ref1 = $rootScope.pushes.inciupdates;
        for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
          update = _ref1[_j];
          update.timelineType = "update";
          update.date = moment(update.time).format("DD MMM. YYYY");
          update.displayTime = moment(update.time).format("HH:mm");
          if (update.is_approved) {
            timeline.push(update);
          }
        }
      }
      if ($rootScope.pushes.dispatches) {
        _ref2 = $rootScope.pushes.dispatches;
        for (_k = 0, _len2 = _ref2.length; _k < _len2; _k++) {
          dispatch = _ref2[_k];
          dispatch.timelineType = "dispatch";
          dispatch.date = moment(dispatch.time).format("DD MMM. YYYY");
          dispatch.displayTime = moment(dispatch.time).format("HH:mm");
          if (dispatch.is_approved) {
            timeline.push(dispatch);
          }
        }
      }
      return timeline;
    };
    if (!$scope.NEAAPIInitialized) {
      initNEAAPI($scope);
      $scope.NEAAPIInitialized = true;
    }
  });

}).call(this);

//# sourceMappingURL=public.js.map
