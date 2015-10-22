'use strict'


angular.module 'tbcCmsFrontApp'
  .service 'Agency', ($http, $websocket) ->


    getAgencies = (token, callback) ->
      $http(
        url: App.host_addr + "/agencies/"
        method: "GET"
        headers:
          "Authorization":token
      )

      .success ((data, status, headers, config) ->
        console.log("getAgencies success")
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
    getAgencies:getAgencies
    }
