/**
 * Created by qikunxiang on 30/10/15.
 */

function initNEAAPI($scope) {
    setTimeout(function () {
        var weather = $("#api-weather");
        var psi = $("#api-psi");

        if (window.neaApiTimer) {
            clearInterval(window.neaApiTimer);
            window.neaApiTimer = null;
        }
        var neaApi = function () {
            $.ajax({
                type: 'GET',
                dataType: "xml",
                processData: false,
                crossDomain: true,
                jsonp: false,
                url: "http://www.nea.gov.sg/api/WebAPI?dataset=12hrs_forecast&keyref=781CF461BB6606AD28A78E343E0E4176167EFFE3CFEF773A",
                success: function (responseData, textStatus, jqXHR) {
                    weather.text($(responseData).find("forecast").text());
                }
            });
            $.ajax({
                type: 'GET',
                dataType: "xml",
                processData: false,
                crossDomain: true,
                jsonp: false,
                url: "http://www.nea.gov.sg/api/WebAPI?dataset=psi_update&keyref=781CF461BB6606AD28A78E343E0E4176167EFFE3CFEF773A",
                success: function (responseData, textStatus, jqXHR) {
                    var rst = $(responseData);
                    rst.find("region").each(function() {
                        switch ($(this).find("id").text()) {
                            case "NRS":
                                psi.find(".national div").text($(this).find('reading[type="NPSI"]').attr("value"));
                                break;
                            case "rCE":
                                psi.find(".central div").text($(this).find('reading[type="NPSI"]').attr("value"));
                                break;
                            case "rNO":
                                psi.find(".north div").text($(this).find('reading[type="NPSI"]').attr("value"));
                                break;
                            case "rSO":
                                psi.find(".south div").text($(this).find('reading[type="NPSI"]').attr("value"));
                                break;
                            case "rWE":
                                psi.find(".west div").text($(this).find('reading[type="NPSI"]').attr("value"));
                                break;
                            case "rEA":
                                psi.find(".east div").text($(this).find('reading[type="NPSI"]').attr("value"));
                                break;
                        }
                    });
                }
            });
        }
        neaApi();
        window.neaApiTimer = setInterval(neaApi, 10 * 50 * 1000);
    }, 500);
}