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

    # returns
    {
      getIncidents:getIncidents
    }
