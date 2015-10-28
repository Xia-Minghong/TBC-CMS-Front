(function() {
  'use strict';
  angular.module('tbcCmsFrontApp').service('Incident', function($http) {
    var approveIncident, getIncident, getIncidentDispatch, getIncidentDispatches, getIncidentUpdate, getIncidentUpdates, getIncidents, rejectIncident, syncIncidents;
    getIncidents = function(token, callback) {
      $http({
        url: App.host_addr + "/incidents/",
        method: "GET",
        headers: {
          "Authorization": token
        }
      }).success((function(data, status, headers, config) {
        console.log("getIncidents success");
        callback(data);
      })).error((function(data, status, headers, config) {
        console.log("Process failed");
        callback(false);
      }));
    };
    getIncident = function(token, id, callback) {
      $http({
        url: App.host_addr + "/incidents/" + id + "/",
        method: "GET",
        headers: {
          "Authorization": token
        }
      }).success((function(data, status, headers, config) {
        console.log("getIncident success");
        callback(data);
      })).error((function(data, status, headers, config) {
        console.log("Process failed");
        callback(false);
      }));
    };
    approveIncident = function(token, id, callback) {
      $http({
        url: App.host_addr + "/incidents/" + id + "/approve/",
        method: "GET",
        headers: {
          "Authorization": token
        }
      }).success((function(data, status, headers, config) {
        console.log("approveIncident success");
        callback(data);
      })).error((function(data, status, headers, config) {
        console.log("approveIncident failed");
        callback(false);
      }));
    };
    rejectIncident = function(token, id, callback) {
      $http({
        url: App.host_addr + "/incidents/" + id + "/reject/",
        method: "GET",
        headers: {
          "Authorization": token
        }
      }).success((function(data, status, headers, config) {
        console.log("rejectIncident success");
        callback(data);
      })).error((function(data, status, headers, config) {
        console.log("rejectIncident failed");
        callback(false);
      }));
    };
    syncIncidents = function(token, callback) {
      $http({
        url: App.host_addr + "/incidents/sync/",
        method: "GET",
        headers: {
          "Authorization": token
        }
      }).success((function(data, status, headers, config) {
        console.log("syncIncidents success");
        callback(data);
      })).error((function(data, status, headers, config) {
        console.log("syncIncidents failed");
        callback(false);
      }));
    };
    getIncidentUpdates = function(token, id, callback) {
      $http({
        url: App.host_addr + "/incidents/" + id + "/updates/",
        method: "GET",
        headers: {
          "Authorization": token
        }
      }).success((function(data, status, headers, config) {
        console.log("getIncidentUpdates success");
        callback(data);
      })).error((function(data, status, headers, config) {
        console.log("Process failed");
        callback(false);
      }));
    };
    getIncidentUpdate = function(token, inci_id, update_id, callback) {
      $http({
        url: App.host_addr + "/incidents/" + inci_id + "/updates/" + update_id + "/",
        method: "GET",
        headers: {
          "Authorization": token
        }
      }).success((function(data, status, headers, config) {
        console.log("getIncidentUpdate success");
        callback(data);
      })).error((function(data, status, headers, config) {
        console.log("Process failed");
        callback(false);
      }));
    };
    getIncidentDispatches = function(token, inci_id, callback) {
      $http({
        url: App.host_addr + "/incidents/" + inci_id + "/dispatches/",
        method: "GET",
        headers: {
          "Authorization": token
        }
      }).success((function(data, status, headers, config) {
        console.log("getIncidentDispatches success");
        callback(data);
      })).error((function(data, status, headers, config) {
        console.log("Process failed");
        callback(false);
      }));
    };
    getIncidentDispatch = function(token, inci_id, dispatch_id, callback) {
      $http({
        url: App.host_addr + "/incidents/" + inci_id + "/dispatches/" + dispatch_id + "/",
        method: "GET",
        headers: {
          "Authorization": token
        }
      }).success((function(data, status, headers, config) {
        console.log("getIncidentDispatch success");
        callback(data);
      })).error((function(data, status, headers, config) {
        console.log("Process failed");
        callback(false);
      }));
    };
    return {
      getIncidents: getIncidents,
      getIncident: getIncident,
      approveIncident: approveIncident,
      rejectIncident: rejectIncident,
      getIncidentUpdates: getIncidentUpdates,
      getIncidentUpdate: getIncidentUpdate,
      getIncidentDispatches: getIncidentDispatches,
      getIncidentDispatch: getIncidentDispatch
    };
  });

}).call(this);

//# sourceMappingURL=incidentService.js.map
