(function() {
  'use strict';
  angular.module('tbcCmsFrontApp').service('Agency', function($http) {
    var getAgencies, getAgency;
    getAgencies = function(token, callback) {
      $http({
        url: App.host_addr + "/agencies/",
        method: "GET",
        headers: {
          "Authorization": token
        }
      }).success((function(data, status, headers, config) {
        console.log("getAgencies success");
        callback(data);
      })).error((function(data, status, headers, config) {
        console.log("Process failed");
        callback(false);
      }));
    };
    getAgency = function(token, id, callback) {
      $http({
        url: App.host_addr + "/agencies/" + id + "/",
        method: "GET",
        headers: {
          "Authorization": token
        }
      }).success((function(data, status, headers, config) {
        console.log("getAgency success");
        callback(data);
      })).error((function(data, status, headers, config) {
        console.log("Process failed");
        callback(false);
      }));
    };
    return {
      getAgencies: getAgencies,
      getAgency: getAgency
    };
  });

}).call(this);

//# sourceMappingURL=agencyService.js.map
