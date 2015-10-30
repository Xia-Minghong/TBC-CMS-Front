'use strict'


angular.module 'tbcCmsFrontApp'
  .service 'Incident', ($http) ->


    getIncidents = (token, callback) ->
      $http(
        url: App.host_addr + "/incidents/"
        method: "GET"
        headers:
          "Authorization":token
      )

      .success ((data, status, headers, config) ->
        console.log("getIncidents success")
        callback(data)
        return
      )

      .error ((data, status, headers, config) ->
        console.log("Process failed")
        callback(false)
        return
      )
      return

    getIncident = (token, id, callback) ->
      $http(
        url: App.host_addr + "/incidents/" + id + "/"
        method: "GET"
        headers:
          "Authorization":token
      )

      .success ((data, status, headers, config) ->
        console.log("getIncident success")
        callback(data)
        return
      )

      .error ((data, status, headers, config) ->
        console.log("Process failed")
        callback(false)
        return
      )
      return

    postIncident = (token, report, callback) ->
      $http(
        url: App.host_addr + "/incidents/"
        method: "POST"
        headers:
          "Content-Type":"application/json"
          "Authorization":token
        data:
          "type":report.type
          "name":report.name
          "severity":report.severity
          "time":report.time
          "location":report.location
          "contact":report.contact
          "description":report.description
      )

      .success ((data, status, headers, config) ->
        console.log("postIncident success")
        callback(data)
        return
      )

      .error ((data, status, headers, config) ->
        console.log(data)
        callback(false)
        return
      )
      return

    approveIncident = (token, id, callback) ->
      $http(
        url: App.host_addr + "/incidents/" + id + "/approve/"
        method: "GET"
        headers:
          "Authorization":token
      )

      .success ((data, status, headers, config) ->
        console.log("approveIncident success")
        callback(data)
        return
      )

      .error ((data, status, headers, config) ->
        console.log("approveIncident failed")
        callback(false)
        return
      )
      return


    rejectIncident = (token, id, callback) ->
      $http(
        url: App.host_addr + "/incidents/" + id + "/reject/"
        method: "GET"
        headers:
          "Authorization":token
      )

      .success ((data, status, headers, config) ->
        console.log("rejectIncident success")
        callback(data)
        return
      )

      .error ((data, status, headers, config) ->
        console.log("rejectIncident failed")
        callback(false)
        return
      )
      return

    syncIncidents = (token, callback) ->
      $http(
        url: App.host_addr + "/incidents/sync/"
        method: "GET"
        headers:
          "Authorization":token
      )

      .success ((data, status, headers, config) ->
        console.log("syncIncidents success")
        callback(data)
        return
      )

      .error ((data, status, headers, config) ->
        console.log("syncIncidents failed")
        callback(false)
        return
      )
      return

    getIncidentUpdates = (token, id, callback) ->
      $http(
        url: App.host_addr + "/incidents/" + id + "/updates/"
        method: "GET"
        headers:
          "Authorization": token
      )

      .success ((data, status, headers, config) ->
        console.log("getIncidentUpdates success")
        callback(data)
        return
      )

      .error ((data, status, headers, config) ->
        console.log("Process failed")
        callback(false)
        return
      );
      return

    getIncidentUpdate = (token, inci_id, update_id, callback) ->
      $http(
        url: App.host_addr + "/incidents/" + inci_id + "/updates/" + update_id + "/"
        method: "GET"
        headers:
          "Authorization": token
      )

      .success ((data, status, headers, config) ->
        console.log("getIncidentUpdate success")
        callback(data)
        return
      )

      .error ((data, status, headers, config) ->
        console.log("Process failed")
        callback(false)
        return
      );
      return

    getIncidentDispatches = (token, inci_id, callback) ->
      $http(
        url: App.host_addr + "/incidents/" + inci_id + "/dispatches/"
        method: "GET"
        headers:
          "Authorization": token
      )

      .success ((data, status, headers, config) ->
        console.log("getIncidentDispatches success")
        callback(data)
        return
      )

      .error ((data, status, headers, config) ->
        console.log("Process failed")
        callback(false)
        return
      );
      return

    getIncidentDispatch = (token, inci_id, dispatch_id, callback) ->
      $http(
        url: App.host_addr + "/incidents/" + inci_id + "/dispatches/" + dispatch_id + "/"
        method: "GET"
        headers:
          "Authorization": token
      )

      .success ((data, status, headers, config) ->
        console.log("getIncidentDispatch success")
        callback(data)
        return
      )

      .error ((data, status, headers, config) ->
        console.log("Process failed")
        callback(false)
        return
      );
      return

    # returns
    {
      getIncidents:getIncidents
      getIncident:getIncident
      postIncident:postIncident
      approveIncident:approveIncident
      rejectIncident:rejectIncident
      getIncidentUpdates:getIncidentUpdates
      getIncidentUpdate:getIncidentUpdate
      getIncidentDispatches:getIncidentDispatches
      getIncidentDispatch:getIncidentDispatch
    }
