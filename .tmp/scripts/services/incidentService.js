(function() {
  'use strict';
  angular.module('tbcCmsFrontApp').service('Incident', function($http) {
    var approveIncident, getIncident, getIncidentDispatch, getIncidentDispatches, getIncidentTypes, getIncidentUpdate, getIncidentUpdates, getIncidents, postIncident, postIncidentUpdate, rejectIncident, syncIncidents;
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
    postIncident = function(token, report, callback) {
      $http({
        url: App.host_addr + "/incidents/",
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "Authorization": token
        },
        data: {
          "type": report.type,
          "name": report.name,
          "severity": report.severity,
          "time": report.time,
          "location": report.location,
          "contact": report.contact,
          "description": report.description
        }
      }).success((function(data, status, headers, config) {
        console.log("postIncident success");
        callback(data);
      })).error((function(data, status, headers, config) {
        console.log(data);
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
    postIncidentUpdate = function(token, id, report, callback) {
      $http({
        url: App.host_addr + "/incidents/" + id + "/updates/",
        method: "PUT",
        headers: {
          "Content-Type": "application/json",
          "Authorization": token
        },
        data: {
          "agency": report.agency,
          "is_approved": report.is_approved,
          "updated_severity": report.severity,
          "time": report.time,
          "description": report.description
        }
      }).success((function(data, status, headers, config) {
        console.log("postIncidentUpdate success");
        callback(data);
      })).error((function(data, status, headers, config) {
        console.log(data);
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
    getIncidentTypes = function(token, callback) {
      $http({
        url: App.host_addr + "/incidents/types/",
        method: "GET",
        headers: {
          "Authorization": token
        }
      }).success((function(data, status, headers, config) {
        console.log("get inci types success");
        callback(data);
      })).error((function(data, status, headers, config) {
        console.log("inci types failed");
        callback(false);
      }));
    };
    return {
      getIncidents: getIncidents,
      getIncident: getIncident,
      postIncident: postIncident,
      approveIncident: approveIncident,
      rejectIncident: rejectIncident,
      getIncidentUpdates: getIncidentUpdates,
      getIncidentUpdate: getIncidentUpdate,
      postIncidentUpdate: postIncidentUpdate,
      getIncidentDispatches: getIncidentDispatches,
      getIncidentDispatch: getIncidentDispatch,
      getIncidentTypes: getIncidentTypes
    };
  });

}).call(this);

//# sourceMappingURL=incidentService.js.map
