(function() {
  'use strict';

  /**
    * @ngdoc function
    * @name tbcCmsFrontApp.controller:CrisisUpdateCtrl
    * @description
    * # CrisisUpdateCtrl
    * Controller of the tbcCmsFrontApp
   */
  angular.module('tbcCmsFrontApp').controller('CrisisUpdateCtrl', function($scope, $rootScope, $route, $routeParams, $timeout, Upload, Incident) {
    $scope.init = function() {
      console.log("init");
      Incident.getIncidentFromKey($rootScope.userData.token, $routeParams.key, function(incident) {
        if (incident) {
          return $scope.incident = incident;
        } else {

        }
      });
    };
    $scope.submitUpdate = function() {
      var r;
      r = $scope.update;
      if (r && r.severity && r.time && r.description) {
        console.log($routeParams);
        Incident.postIncidentUpdate($rootScope.userData.token, $routeParams.key, r, function(success) {
          if (success) {
            $scope.errorMsg = "";
            $scope.successMsg = "Submit Success";
            return $route.reload();
          } else {
            return $scope.errorMsg = "Submit Error";
          }
        });
      } else {
        $scope.errorMsg = "Form incomplete!";
      }
    };
    $scope.$watch('files', function() {
      $scope.upload($scope.files);
    });
    $scope.$watch('file', function() {
      if ($scope.file !== null) {
        $scope.files = [$scope.file];
      }
    });
    $scope.log = '';
    $scope.upload = function(files) {
      var file, i;
      if (files && files.length) {
        i = 0;
        while (i < files.length) {
          file = files[i];
          if (!file.$error) {
            console.log("start upload");
            console.log(file);
            Upload.upload({
              url: 'http://cms.h5.io:8000/inci_update_photos/',
              data: {
                "photo": file
              }
            }).progress(function(evt) {
              var progressPercentage;
              progressPercentage = parseInt(100.0 * evt.loaded / evt.total);
              $scope.log = 'progress: ' + progressPercentage + '% ' + evt.config.data.file.name + '\n' + $scope.log;
            }).success(function(data, status, headers, config) {
              console.log("success upload");
              console.log(data);
              return $timeout(function() {
                $scope.log = 'file: ' + config.data.file.name + ', Response: ' + JSON.stringify(data) + '\n' + $scope.log;
              });
            }).error(function(data, status, headers, config) {
              console.log("fail upload");
              return console.log(data);
            });
            return;
          }
          i++;
        }
      }
    };
    if (!$scope.crisisUpdateInitialized) {
      crisisUpdateInit();
    }
    $scope.crisisUpdateInitialized = true;
  });

}).call(this);

//# sourceMappingURL=crisis-update.js.map
