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

    getIncidentFromKey = (token, key, callback) ->
      $http(
        url: App.host_addr + "/update/" + key + "/keys/"
        method: "GET"
        headers:
          "Authorization":token
      )

      .success ((data, status, headers, config) ->
        console.log("getIncidentFromKey success")
        console.log(data)
        callback(data)
        return
      )

      .error ((data, status, headers, config) ->
        console.log("getIncidentFromKey failed")
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
          "longitude":report.longitude
          "latitude":report.latitude
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

    archiveIncident = (token, id, callback) ->
      $http(
        url: App.host_addr + "/incidents/" + id + "/archive/"
        method: "GET"
        headers:
          "Authorization":token
      )

      .success ((data, status, headers, config) ->
        console.log("archiveIncident success")
        callback(data)
        return
      )

      .error ((data, status, headers, config) ->
        console.log("archiveIncident failed")
        callback(false)
        return
      )
      return

    allIncidentUpdates = (token, callback) ->
      $http(
        url: App.host_addr + "/incidents/allupdates/"
        method: "GET"
        headers:
          "Authorization":token
      )

      .success ((data, status, headers, config) ->
        console.log("allupdates success")
        callback(data)
        return
      )

      .error ((data, status, headers, config) ->
        console.log("allupdates failed")
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

    postIncidentUpdate = (token, key, report, callback) ->
      $http(
        url: App.host_addr + "/update/"+key+"/keys/"
        method: "POST"
        headers:
          "Content-Type":"application/json"
          "Authorization":token
        data:
#          "agency":report.agency
#          "is_approved":report.is_approved
          "updated_severity":report.severity
          "time":report.time
          "description":report.description
          "photo_url":report.photo_url
      )

      .success ((data, status, headers, config) ->
        console.log("postIncidentUpdate success")
        callback(data)
        return
      )

      .error ((data, status, headers, config) ->
        console.log(data)
        callback(false)
        return
      )
      return

    approveIncidentUpdate = (token, inci_id, id, callback) ->
      $http(
        url: App.host_addr + "/incidents/" + inci_id + "/updates/" + id + "/approve/"
        method: "GET"
        headers:
          "Authorization":token
      )

      .success ((data, status, headers, config) ->
        console.log("approveIncidentUpdate success")
        console.log(data)
        callback(data)
        return
      )

      .error ((data, status, headers, config) ->
        console.log("approveIncidentUpdate failed")
        console.log data
        callback(false)
        return
      )
      return

    rejectIncidentUpdate = (token, inci_id, id, callback) ->
      $http(
        url: App.host_addr + "/incidents/" + inci_id + "/updates/" + id + "/reject/"
        method: "GET"
        headers:
          "Authorization":token
      )

      .success ((data, status, headers, config) ->
        console.log("rejectIncidentDispatch success")
        console.log(data)
        callback(data)
        return
      )

      .error ((data, status, headers, config) ->
        console.log("rejectIncidentDispatch failed")
        callback(false)
        return
      )
      return

    allIncidentDispatches = (token, callback) ->
      $http(
        url: App.host_addr + "/incidents/alldispatches/"
        method: "GET"
        headers:
          "Authorization":token
      )

      .success ((data, status, headers, config) ->
        console.log("alldispatches success")
        callback(data)
        return
      )

      .error ((data, status, headers, config) ->
        console.log("alldispatches failed")
        callback(false)
        return
      )
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

    approveIncidentDispatch = (token, inci_id, id, callback) ->
      $http(
        url: App.host_addr + "/incidents/" + inci_id + "/dispatches/" + id + "/approve/"
        method: "GET"
        headers:
          "Authorization":token
      )

      .success ((data, status, headers, config) ->
        console.log("approveIncidentDispatch success")
        console.log(data)
        callback(data)
        return
      )

      .error ((data, status, headers, config) ->
        console.log("approveIncidentDispatch failed")
        callback(false)
        return
      )
      return

    rejectIncidentDispatch = (token, inci_id, id, callback) ->
      $http(
        url: App.host_addr + "/incidents/" + inci_id + "/dispatches/" + id + "/reject/"
        method: "GET"
        headers:
          "Authorization":token
      )

      .success ((data, status, headers, config) ->
        console.log("rejectIncidentDispatch success")
        console.log(data)
        callback(data)
        return
      )

      .error ((data, status, headers, config) ->
        console.log("rejectIncidentDispatch failed")
        callback(false)
        return
      )
      return

    getIncidentTypes = (token, callback) ->
      $http(
        url: App.host_addr + "/incidents/types/"
        method: "GET"
        headers:
          "Authorization": token
      )

      .success ((data, status, headers, config) ->
        console.log("get inci types success")
        callback(data)
        return
      )

      .error ((data, status, headers, config) ->
        console.log("inci types failed")
        callback(false)
        return
      );
      return

    # returns
    {
      getIncidents:getIncidents
      getIncident:getIncident
      getIncidentFromKey:getIncidentFromKey
      postIncident:postIncident
      approveIncident:approveIncident
      rejectIncident:rejectIncident
      archiveIncident:archiveIncident

      allIncidentUpdates:allIncidentUpdates
      getIncidentUpdates:getIncidentUpdates
      getIncidentUpdate:getIncidentUpdate
      postIncidentUpdate:postIncidentUpdate
      approveIncidentUpdate:approveIncidentUpdate
      rejectIncidentUpdate:rejectIncidentUpdate

      allIncidentDispatches:allIncidentDispatches
      getIncidentDispatches:getIncidentDispatches
      getIncidentDispatch:getIncidentDispatch
      approveIncidentDispatch:approveIncidentDispatch
      rejectIncidentDispatch:rejectIncidentDispatch

      getIncidentTypes:getIncidentTypes
    }
