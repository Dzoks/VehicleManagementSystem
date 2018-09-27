
var locationView={
    
    panel:{
        id:"locationPanel",
        adjust: true,
        rows:[
            {
                view: "toolbar",
                padding: 8,
                css: "panelToolbar",
                cols: [
                    {
                        view: "label",
                        width: 400,
                        template: "<span class='fa fa-location-arrow'/> Lokacije"
                    },
                    {},
                    {
                        id: "addUserBtn",
                        view: "button",
                        type: "iconButton",
                        label: "Dodajte",
                        icon: "plus-circle",
                        click: 'locationView.showAddLocationDialog',
                        autowidth: true
                    }
                ]
            },
            {
                id:"locationMap",
                view:"google-map",
                url:"api/location",
                on:{
                    onAfterLoad:function () {
                        var markers=[];
                        var map=$$("locationMap").getMap().val;

                        $$("locationMap").data.each(function (obj) {
                         markers.push(obj);
                        });
                        var bounds = new google.maps.LatLngBounds();
                        for (var i = 0; i < markers.length; i++) {
                            bounds.extend(markers[i]);
                        }
                        map.fitBounds(bounds);
                    },
                    onItemClick:function (id, marker) {
                        var contentString=marker.label;
                        contentString+="<br>";
                        contentString+="<a href='#' onclick='vehicleView.selectPanel("+id+")' >Vozila</a>";
                        contentString+="<br>";
                        contentString+="<a href='#' onclick='locationView.setEdit("+id+");'>Izmjenite</a>";
                        contentString+="<br>";
                        contentString+="<a href='#' onclick='locationView.deleteLocation("+id+")'>Obrišite</a>"
                        var infowindow = new google.maps.InfoWindow({
                            content: contentString,
                        });
                        infowindow.open($$("locationMap").getMap().val, marker);



                    }
                },
                zoom:8
                //key:"AIzaSyDLrWtIdZaoYBiQlrvI8V_4gKFH6TBJ4c4"
            }
        ]
    },

    addLocationDialog:{
        id:"addLocationDialog",
        view:"window",
        css:"popup-css",
        position:"top",
        on:{
            onDestruct:function () {
                if (locationView.markerToEdit){
                    $$("locationMap").remove(locationView.markerToEdit.id);
                    $$("locationMap").add(locationView.oldMarker);
                }
                if (locationView.markerExists)
                    $$("locationMap").remove("marker");
                locationView.markerExists=false;
                locationView.markerToEdit=null;
                locationView.oldMarker=null;

            }
        },

        head:{
            view: "toolbar",
            css: "panelToolbar",
            width:800,
            cols: [
                {
                    view: "label",

                    template: "<span class='fa fa-location-arrow'/> Dodavanje lokacije"
                },
                {},
                {

                    view: "icon",
                    icon: "close",
                    align: "right",
                    click: "util.dismissDialog('addLocationDialog');"
                }
            ]
        },
        body: {
            width:400,
            rows: [

                {
                    id: "addLocationForm",
                    view: "form",
                    elementsConfig: {
                        labelWidth: 80,
                        bottomPadding: 18
                    },
                    elements: [
                        {
                            id: "label",
                            name: "label",
                            view: "text",
                            label: "Naziv:",
                            required: true,
                            invalidMessage: "Naziv je obavezan!"
                        },
                        {
                            id:"address",
                            name:"address",
                            view:"search",
                            label:"Lokacija:",
                            required:true,
                            hotkey: "enter",
                            invalidMessage:"Morate unijeti lokaciju!"
                        },
                        {
                            id: "addLocationBtn",
                            view: "button",
                            value: "Dodajte lokaciju",
                            type: "form",
                            click: "locationView.addLocation",
                            align: "right",
                            width: 150
                        },
                        {
                            id: "updateLocationBtn",
                            view: "button",
                            value: "Sačuvajte",
                            type: "form",
                            click: "locationView.saveLocation",
                            align: "right",
                            width: 150
                        }
                    ]
                }
            ]
        }


    },

    showAddLocationDialog:function(){
        if (util.popupIsntAlreadyOpened("addLocationDialog")) {
            webix.ui(webix.copy(locationView.addLocationDialog)).show();
            $$("updateLocationBtn").hide();
            webix.UIManager.setFocus("label");
            $$("address").attachEvent("onKeyPress",function (code,ev) {
                if (code===13) {
                    var geocoder = new google.maps.Geocoder();
                    var myAddress = $$("address").getValue();
                    geocoder.geocode({'address': myAddress}, function (results, status) {
                        if (status === 'OK') {
                            if(locationView.markerToEdit){
                                $$("locationMap").remove(locationView.markerToEdit.id);
                                locationView.markerToEdit=null;
                                $$("locationMap").add(locationView.oldMarker);
                                locationView.oldMarker=null;
                            }else {
                                if (locationView.markerExists)
                                    $$("locationMap").remove("marker");
                                locationView.markerExists = true;
                                var marker = {
                                    id: "marker",
                                    lat: results[0].geometry.location.lat(),
                                    lng: results[0].geometry.location.lng(),
                                    draggable: true
                                };
                                $$("locationMap").add(marker);
                                var map = $$("locationMap").getMap().val.setCenter(marker);
                            }
                        } else {
                            util.messages.showErrorMessage("Nije moguće pronaći unesenu adresu!");
                        }
                    });
                }
            });

        }
    },


    addLocation:function(){

        var form=$$("addLocationForm");
        if (form.validate()){

            if (!locationView.markerExists){
                form.elements.address.setValue("");
                form.validate();
                return;
            }else{
                var marker=$$("locationMap").getItem("marker");
                $$("locationMap").remove("marker");
                var locationToAdd={
                    lat:marker.lat,
                    lng:marker.lng,
                    label:$$("label").getValue(),
                    companyId:userData.companyId
                };
                webix.ajax().header({
                    "Content-Type":"application/json"
                }).post("api/location",locationToAdd).then(function (result) {
                    var location=result.json();
                    $$("locationMap").add(location);
                    locationView.markerExists=false;
                    util.messages.showMessage("Uspješno dodavanje");
                    util.dismissDialog('addLocationDialog');
                }).fail(function (err) {
                    util.showErrorMessage(err.responseText);
                });

            }
        }

    },


    markerExists:false,

    selectPanel: function () {
        $$("main").removeView(rightPanel);
        rightPanel = "locationPanel";
        var panelCopy = webix.copy(this.panel);
        $$("main").addView(webix.copy(panelCopy));
        $$("locationMap").attachEvent("onAfterDrop", function(id, item){
            var geocoder = new google.maps.Geocoder();
            var marker=$$("locationMap").getItem(id);
            var latlng = {lat: marker.lat, lng: marker.lng};
            geocoder.geocode({'location': latlng}, function (results, status) {
                if (status === 'OK') {
                    $$("address").setValue(results[0].formatted_address);
                }
            });
        });
    },
    
    setEdit:function (id) {
        var markerToEdit=$$("locationMap").getItem(id);
        $$("locationMap").remove(id);
        locationView.oldMarker={
            lat:markerToEdit.lat,
            lng:markerToEdit.lng,
            id:markerToEdit.id,
            label:markerToEdit.label,
            companyId:markerToEdit.companyId,
            deleted: markerToEdit.deleted
        };
        markerToEdit.draggable=true;
        locationView.markerExists=true;
        locationView.markerToEdit=markerToEdit;
        $$("locationMap").add(markerToEdit);
        webix.ui(webix.copy(locationView.addLocationDialog)).show();
        $$("addLocationBtn").hide();
        webix.UIManager.setFocus("label");
        $$("label").setValue(markerToEdit.label);
        var geocoder = new google.maps.Geocoder();
        var latlng = {lat: markerToEdit.lat, lng: markerToEdit.lng};
        geocoder.geocode({'location': latlng}, function (results, status) {
            if (status === 'OK') {
                $$("address").setValue(results[0].formatted_address);
            }
        });
        $$("address").attachEvent("onKeyPress",function (code,ev) {
            if (code===13) {
                var geocoder = new google.maps.Geocoder();
                var myAddress = $$("address").getValue();
                geocoder.geocode({'address': myAddress}, function (results, status) {
                    if (status === 'OK') {
                        if (locationView.markerToEdit)
                            $$("locationMap").remove(locationView.markerToEdit.id);
                        locationView.markerToEdit={
                            id:"marker",
                            lat:results[0].geometry.location.lat(),
                            lng:results[0].geometry.location.lng(),
                            draggable:true
                        };
                        $$("locationMap").add(locationView.markerToEdit);
                        $$("locationMap").getMap().val.setCenter(locationView.markerToEdit);
                    } else {
                        util.messages.showErrorMessage("Nije moguće pronaći unesenu adresu!");
                    }
                });
            }
        });

    },

    saveLocation:function(){
        var form=$$("addLocationForm");
        if (form.validate()){

            if (!locationView.markerToEdit){
                form.elements.address.setValue("");
                form.validate();
                return;
            }else{
                var marker=locationView.markerToEdit;
                $$("locationMap").remove(locationView.markerToEdit.id);
                var locationToAdd={
                    id:marker.id,
                    lat:marker.lat,
                    lng:marker.lng,
                    label:$$("label").getValue(),
                    deleted:0,
                    companyId:userData.companyId
                };
                locationView.markerToEdit=locationToAdd;
                webix.ajax().header({
                    "Content-Type":"application/json"
                }).put("api/location/"+marker.id,JSON.stringify(locationToAdd)).then(function (result) {
                    $$("locationMap").add(locationView.markerToEdit);
                    locationView.markerToEdit=false;
                    locationView.oldMarker=false;
                    util.messages.showMessage("Uspješna izmjena");
                    util.dismissDialog("addLocationDialog");
                }).fail(function (err) {
                    util.showErrorMessage(err.responseText);
                });

            }
        }
    },

    deleteLocation:function (id) {
        webix.ajax().del("api/location/"+id).then(function (value) {
            $$("locationMap").remove(id);
        }).fail(function (err) {
            util.messages.showErrorMessage(err.responseText);
        });
    }

};
