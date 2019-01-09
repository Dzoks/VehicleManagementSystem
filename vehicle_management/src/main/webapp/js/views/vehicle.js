const vehicleView = {
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
                        id:"addVehicleBtn",
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
                    },
                    onItemDblClick:function(id){
                        vehicleDetailsView.selectPanel(id);
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
                            "Registracija",
                            {
                                content: "textFilter",
                                fillspace: true,
                                sort: "string"
                            }
                        ],
                        fillspace:true
                    },
                    {
                        id:"manufacturer",
                        header:[
                            "Proizvođač",
                            {
                                content: "textFilter",
                                fillspace: true,
                                sort: "string"
                            }
                        ],
                        fillspace:true
                    },
                    {
                        id:"model",
                        header:[
                            "Model",
                            {
                                content: "textFilter",
                                fillspace: true,
                                sort: "string"
                            }
                        ],
                        fillspace:true
                    },
                    {
                        id:"description",
                        header:[
                            "Opis",
                            {
                                content: "textFilter",
                                fillspace: true,
                                sort: "string"
                            }
                        ],
                        fillspace:true
                    },
                    {
                        id:"fuelTypeId",
                        header:[
                            "Tip goriva",
                            {
                                content: "richSelectFilter",
                                fillspace: true,
                                sort: "string",
                                suggest: {
                                    body: {
                                        template: function (obj) {	// template for options list
                                            if (obj.$empty)
                                                return "";
                                            return dependencyMap['fuelType'][obj.value];
                                        }
                                    }

                                },
                            }
                        ],
                        template: function (obj) {
                            return dependencyMap['fuelType'][obj.fuelTypeId];
                        },
                        fillspace:true
                    },
                    {
                        id:"locationName",
                        header:[
                            "Lokacija",
                            {
                                content: "textFilter",
                                fillspace: true,
                                sort: "string"
                            }
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
        const panelCopy = webix.copy(this.panel);
        $$("main").addView(webix.copy(panelCopy));

        if (locationId){
            vehicleView.locationId=locationId;
            $$("vehicleDT").hideColumn("locationName");
            $$("vehicleDT").clearAll();
            $$("vehicleDT").load("api/vehicle/byLocation/"+locationId);
            $$("vehicleDT").refresh();
        }
        if (userData.roleId===role.user){
            $$("addVehicleBtn").hide();
        }else{
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
                        const context = this.getContext();
                        const delBox = (webix.copy(commonViews.deleteConfirmSerbian("vozila", "vozilo")));
                        delBox.callback = result=> {
                            if (result) {
                                $$("vehicleDT").remove(context.id.row);
                            }
                        };
                        webix.confirm(delBox);
                    }
                }
            });
            connection.attachAjaxEvents("vehicleDT","api/vehicle");
        }

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
                                            id:"registration",
                                            name:"registration",
                                            label:"Registracijski broj:",
                                            view:"text",
                                            required:true,
                                            invalidMessage:"Registracijski broj je obavezan!"
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
                                        },
                                    ]
                                },
                                {
                                    gravity:0.05
                                },
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
                                            id: "description",
                                            name: "description",
                                            view: "textarea",
                                            label: "Opis:",
                                        },
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
            webix.UIManager.setFocus("registration");
            $$("fuelTypeId").define("options",dependency.fuelType);
            $$("fuelTypeId").refresh();
            const locations=[];
            connection.sendAjax("GET","api/location").then(data=> {
                const array=data.json();
                array.forEach(obj=> {
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
        const form=$$("addVehicleForm");
        if (form.validate()){
            const vehicle={...form.getValues(),deleted:0,companyId:userData.companyId};
            $$("vehicleDT").add(vehicle);
            util.dismissDialog('addVehicleDialog');
        }
    }
};
