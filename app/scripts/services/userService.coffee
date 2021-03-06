'use strict'


angular.module 'tbcCmsFrontApp'
.service 'User', ($http) ->
  login = (loginData, callback) ->
    $http(
      url: App.host_addr + "/o/token/"
      method: "POST"
      headers:
        "Content-Type":"application/x-www-form-urlencoded"
        "Authorization":"Basic dGNMbmQ1NmhldjJWVDdPOHRiS1c1RjV0RFlxRWRqU0VmcHljVTBWbDo4UmxtMkI0R2Vkd3M2ZkJWN3VzMU0xZTI3RXhkRVB4T3o4M05IZllWS1pUaFluYUJUQXJ2Vk5PaFpoUW4xQzlRWERvSGViMXBQS2tsSTFRTEFNNUZjdnVrN1Y5NGtudUJmbGJseTRkbjhqdDZsajRvMzZFZVFHbWE4a2ZRYjNaUA=="
      transformRequest: (obj) ->
        str = []
        for p of obj
          str.push encodeURIComponent(p) + '=' + encodeURIComponent(obj[p])
        str.join '&'
      data:
        "grant_type":"password"
        "username":loginData.username
        "password":loginData.password
        "scope":"read"
    )

    .success ((data, status, headers, config) ->
      console.log(data)
      callback(data)
      return
    )

    .error ((data, status, headers, config) ->
      console.log("Login failed")
      callback(data)
      return
    )

  logout = (token, callback) ->
    $http(
      url: App.host_addr + "/o/revoke_token/"
      method: "POST"
      headers:
        "Content-Type":"application/x-www-form-urlencoded"
        "Authorization":"Basic dGNMbmQ1NmhldjJWVDdPOHRiS1c1RjV0RFlxRWRqU0VmcHljVTBWbDo4UmxtMkI0R2Vkd3M2ZkJWN3VzMU0xZTI3RXhkRVB4T3o4M05IZllWS1pUaFluYUJUQXJ2Vk5PaFpoUW4xQzlRWERvSGViMXBQS2tsSTFRTEFNNUZjdnVrN1Y5NGtudUJmbGJseTRkbjhqdDZsajRvMzZFZVFHbWE4a2ZRYjNaUA=="
      transformRequest: (obj) ->
        str = []
        for p of obj
          str.push encodeURIComponent(p) + '=' + encodeURIComponent(obj[p])
        str.join '&'
      data:
        "token":token
    )

    .success ((data, status, headers, config) ->
      console.log(data)
      callback(data)
      return
    )

    .error ((data, status, headers, config) ->
      console.log("Login failed")
      callback(data)
      return
    )

  getProfile = (token, callback) ->
    $http(
      url: App.host_addr + "/users/me/"
      method: "GET"
      headers:
        "Authorization": token
    )

    .success ((data, status, headers, config) ->
      console.log(data)
      console.log("getProfile success")
      callback(data)
      return
    )

    .error ((data, status, headers, config) ->
      console.log("getProfile failed")
      callback(false)
      return
    )


  # returns
  {
  login:login
  logout:logout
  getProfile:getProfile
  }
