'use strict'


angular.module 'tbcCmsFrontApp'
  .service 'Incident', ($http, $websocket) ->


    getIncidents = (token, callback) ->
      $http(
        url: App.host_addr + "/incidents/"
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
      getIncidentUpdates:getIncidentUpdates
      getIncidentUpdate:getIncidentUpdate
      getIncidentDispatches:getIncidentDispatches
      getIncidentDispatch:getIncidentDispatch
    }
