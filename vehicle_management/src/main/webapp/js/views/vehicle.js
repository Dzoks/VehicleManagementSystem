var vehicleView = {
    panel: {
        id: "vehiclePanel",
        adjust: true,
        rows: [
            {
                view: "toolbar",
                padding: 8,
                css: "panelToolbar",
                cols: [
                    {
                        view: "label",
                        width: 400,
                        template: "<span class='fa fa-car'/> Vozila"
                    },
                    {},
                    {
                        view:"button",
                        type: "iconButton",
                        label: "Dodajte",
                        icon: "plus-circle",
                        click: 'vehicleView.showAddVehicleDialog',
                        autowidth: true
                    }
                ]
            },
            {
                id: "vehicleDT",
                view: "datatable",
                css: "webixDatatable",
                multiselect: "false",
                select: true,
                navigation: true,
                editable: true,
                resizeColumn: true,
                resizeRow: true,
                url: "api/vehicle",
                tooltip: true,
                on: {
                    onBeforeContextMenu: function (item) {
                        this.select(item.row);
                    }
                },
                columns: [
                    {
                        id: "id",
                        hidden: true
                    },
                    {
                        id:"deleted",
                        hidden:true
                    },
                    {
                        id:"registration",
                        header:[
                            "Registracija"
                        ],
                        fillspace:true
                    },
                    {
                        id:"manufacturer",
                        header:[
                            "Proizvođač"
                        ],
                        fillspace:true
                    },
                    {
                        id:"model",
                        header:[
                            "Model"
                        ],
                        fillspace:true
                    },
                    {
                        id:"name",
                        header:[
                            "Naziv"
                        ],
                        fillspace:true
                    },
                    {
                        id:"description",
                        header:[
                            "Opis"
                        ],
                        fillspace:true
                    },
                    {
                        id:"fuelTypeId",
                        header:[
                            "Tip goriva"
                        ],
                        template:function (obj) {
                            return dependencyMap['fuelType'][obj.fuelTypeId];
                        },
                        fillspace:true
                    },
                    {
                        id:"locationName",
                        header:[
                            "Lokacija"
                        ],
                        fillspace:true
                    }
                ]
            }
        ]
    },

    locationId:null,

    selectPanel: function (locationId) {
        $$("mainMenu").select("vehicle");
        $$("main").removeView(rightPanel);
        rightPanel = "vehiclePanel";
        var panelCopy = webix.copy(this.panel);
        $$("main").addView(webix.copy(panelCopy));

        if (locationId){
            vehicleView.locationId=locationId;
            $$("vehicleDT").hideColumn("locationName");
            $$("vehicleDT").clearAll();
            $$("vehicleDT").load("api/vehicle/byLocation/"+locationId);
            $$("vehicleDT").refresh();
        }
        webix.ui({
            view: "contextmenu",
            id: "userContextMenu",
            width: "200",
            data: [
                {
                    id: "delete",
                    value: "Obrišite",
                    icon: "trash"
                }
            ],
            master: $$("vehicleDT"),
            on: {
                onItemClick: function (id) {
                    var context = this.getContext();
                    var delBox = (webix.copy(commonViews.deleteConfirmSerbian("vozila", "vozilo")));
                    delBox.callback = function (result) {
                        if (result) {
                            $$("vehicleDT").remove(context.id.row);
                        }
                    };
                    webix.confirm(delBox);
                }
            }
        });

        connection.attachAjaxEvents("vehicleDT","api/vehicle");
    },

    addVehicleDialog:{
        id: "addVehicleDialog",
        view: "popup",
        modal: true,
        position: "center",
        body: {
            rows: [
                {
                    view: "toolbar",
                    css: "panelToolbar",
                    cols: [
                        {
                            view: "label",
                            width: 600,
                            template: "<span class='fa fa-car'/> Dodavanje vozila"
                        },
                        {},
                        {
                            view: "icon",
                            icon: "close",
                            align: "right",
                            click: "util.dismissDialog('addVehicleDialog');"
                        }
                    ]
                },
                {
                    id:"addVehicleForm",
                    view: "form",
                    elementsConfig: {
                        labelWidth: 150,
                        bottomPadding: 18
                    },
                    elements:[
                        {
                            cols:[
                                {
                                    rows:[
                                        {
                                            id:"manufacturer",
                                            name:"manufacturer",
                                            view:"text",
                                            label:"Proizvođač:",
                                            required:true,
                                            invalidMessage:"Proizvođač je obavezan!"
                                        },
                                        {
                                            id:"model",
                                            name:"model",
                                            view:"text",

                                            label:"Model:",
                                            required:true,
                                            invalidMessage:"Model je obavezan!"
                                        },
                                        {
                                            id:"name",
                                            name:"name",
                                            view:"text",

                                            label:"Naziv:",
                                            required:true,
                                            invalidMessage:"Naziv je obavezan!"
                                        },
                                        {
                                            id:"registration",
                                            name:"registration",
                                            label:"Registracijski broj:",
                                            view:"text",

                                            required:true,
                                            invalidMessage:"Registracijski broj je obavezan!"
                                        },
                                    ]
                                },
                                {
                                    rows:[
                                        {
                                            id: "description",
                                            name: "description",
                                            view: "textarea",
                                            label: "Opis:",
                                        },
                                        {
                                            id: "fuelTypeId",
                                            name: "fuelTypeId",
                                            label: "Tip goriva:",
                                            view: "richselect",
                                            required: true,
                                            invalidMessage: "Tip goriva je obavezan!"
                                        },
                                        {
                                            id: "locationId",
                                            name: "locationId",
                                            view: "richselect",
                                            label: "Lokacija:",
                                            required: true,
                                            invalidMessage: "Lokacija je obavezna!"
                                        }
                                    ]
                                }
                            ]
                        },
                        {
                            view: "button",
                            value: "Dodajte vozilo",
                            type: "form",
                            click: "vehicleView.addVehicle",
                            align: "right",
                            hotkey: "enter",
                            width: 150
                        }
                    ]
                }
             ]
        }
    },
    
    showAddVehicleDialog:function () {
        if (util.popupIsntAlreadyOpened("addVehicleDialog")) {
            webix.ui(webix.copy(vehicleView.addVehicleDialog)).show();
            webix.UIManager.setFocus("manufacturer");
            $$("fuelTypeId").define("options",dependency.fuelType);
            $$("fuelTypeId").refresh();
            var locations=[];
            webix.ajax().get("api/location").then(function (data) {
                var array=data.json();
                array.forEach(function (obj) {
                    locations.push({
                        id:obj.id,
                        value:obj.label
                    });

                });
                $$("locationId").define("options",locations);
                $$("locationId").refresh();
                if (vehicleView.locationId){
                    $$("locationId").setValue(vehicleView.locationId);
                    $$("locationId").define("disabled",true);
                    $$("locationId").refresh();
                    vehicleView.locationId=null;
                }
            });
        }
    },

    addVehicle:function () {
        var form=$$("addVehicleForm");
        if (form.validate()){
            var vehicle=form.getValues();
            vehicle.companyId=userData.companyId;
            $$("vehicleDT").add(vehicle);
            util.dismissDialog('addVehicleDialog');
        }
    }
};
