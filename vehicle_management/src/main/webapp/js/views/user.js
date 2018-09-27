var userView={
    panel:{
        id:"userPanel",
        adjust: true,
        rows:[
            {
                view: "toolbar",
                css: "panelToolbar",
                fillspace:true,
                cols: [
                    {
                        view: "label",
                        width: 400,
                        template: "<span class='fa fa-user'/> Korisnici"
                    },
                    {},
                    {
                        id: "addUserBtn",
                        view: "button",
                        type: "iconButton",
                        label: "Dodajte",
                        icon: "plus-circle",
                        click: 'userView.showAddUserDialog',
                        autowidth: true
                    }
                ]

            },
            {
                // TODO richSelectFilter treba prepraviti sa integera na podatke,
                id: "userDT",
                view: "datatable",
                css:"webixDatatable",
                select: true,
                navigation: true,
                fillspace: true,
                url:"api/user",
                on: {
                    onBeforeContextMenu: function (item) {
                        if (item.row === userData.id)
                            return false;
                        this.select(item.row);
                    }
                },
                columns: [
                    {
                        id: "id",
                        hidden: true
                    },
                    {
                        id: "email",
                        fillspace:true,
                        header: [
                            "E-mail",
                            {
                                content: "textFilter",
                                sort: "string"
                            }
                        ]
                    },
                    {
                        id: "username",
                        fillspace:true,
                        header: [
                            "Korisničko ime",
                            {
                                content: "textFilter",
                                sort: "string"
                            }
                        ]
                    },
                    {
                        id: "name",
                        template: function(obj) {
                            if (obj.firstName){
                                return obj.firstName+" "+obj.lastName;
                            } else return "";
                        },
                        fillspace:true,
                        header: [
                            "Ime i prezime",
                            {
                                content: "textFilter",
                                sort: "string"
                            }
                        ]
                    },
                    {
                        id: "statusId",
                        fillspace:true,
                        template: function (obj) {
                            return dependencyMap['status'][obj.statusId];
                        },
                        header: [
                            "Status",

                            {
                                content: "richSelectFilter",
                                fillspace: true,
                                suggest: {
                                    body: {
                                        template: function (obj) {	// template for options list
                                            if (obj.$empty)
                                                return "";
                                            return dependencyMap['status'][obj.value];
                                        }
                                    }

                                },
                                sort: "string"
                            }
                        ]
                    },
                    {
                        id: "roleId",
                        fillspace:true,
                        template: function (obj) {
                            return dependencyMap['role'][obj.roleId];
                        },
                        header: [
                            "Tip korisnika",
                            {
                                content: "richSelectFilter",
                                fillspace: true,
                                sort: "string",
                                suggest: {
                                    body: {

                                        template: function (obj) {	// template for options list
                                            if (obj.$empty)
                                                return "";
                                            return dependencyMap['role'][obj.value];
                                        }
                                    }

                                },
                            }
                        ]

                    },
                    {
                        id:"locationName",
                        fillspace:true,
                        header: [
                            "Lokacija",
                            {
                                content: "richSelectFilter",
                                fillspace: true,
                                sort: "string"
                            }
                        ]
                    }
                ]
            }
        ]
    },
    
    selectPanel:function () {
        $$("main").removeView(rightPanel);
        rightPanel = "userPanel";
        var panelCopy = webix.copy(this.panel);
        $$("main").addView(webix.copy(panelCopy));
        connection.attachAjaxEvents("userDT",'api/user');
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
            master: $$("userDT"),
            on: {
                onItemClick: function (id) {
                    var context = this.getContext();
                    var delBox = (webix.copy(commonViews.deleteConfirmSerbian("korisnika", "korisnika")));
                    delBox.callback = function (result) {
                        if (result) {
                            $$("userDT").remove(context.id.row);
                        }
                    };
                    webix.confirm(delBox);
                }
            }
        });
    },

    addUserDialog: {
        id: "addUserDialog",
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
                            width: 300,
                            template: "<span class='fa fa-user'/> Dodavanje korisnika"
                        },
                        {},
                        {
                            view: "icon",
                            icon: "close",
                            align: "right",
                            click: "util.dismissDialog('addUserDialog');"
                        }
                    ]
                },
                {
                    id: "addUserForm",
                    view: "form",
                    elementsConfig: {
                        labelWidth: 100,
                        bottomPadding: 18
                    },
                    elements: [
                        {
                            id: "email",
                            name: "email",
                            view: "text",
                            label: "E-mail:",
                            required: true,
                            invalidMessage: "E-mail je obavezan!"
                        },
                        {
                            id:"roleId",
                            name:"roleId",
                            label: "Uloga:",
                            view:"richselect",
                            required:true,
                            invalidMessage:"Uloga je obavezna!",
                        },
                        {
                            id:"locationId",
                            name:"locationId",
                            label: "Lokacija:",
                            view:"richselect",
                        },
                        {
                            id: "addCompanyBtn",
                            view: "button",
                            value: "Dodajte korisnika",
                            type: "form",
                            click: "userView.addUser",
                            align: "right",
                            hotkey: "enter",
                            width: 150
                        }

                    ],
                    rules: {
                        "email": function (value) {
                            if (!value) {
                                $$('addUserForm').elements.email.config.invalidMessage = 'E-mail je obavezan!';
                                return false;
                            }
                            if (!webix.rules.isEmail(value)) {
                                $$('addUserForm').elements.email.config.invalidMessage = 'E-mail nije u validnom formatu!';
                                return false;
                            }
                            return true;
                        }
                    }
                }
            ]
        }
    },
    showAddUserDialog: function () {
        if (util.popupIsntAlreadyOpened("addUserDialog")) {
            webix.ui(webix.copy(userView.addUserDialog)).show();
            webix.UIManager.setFocus("username");
            var reducedRoles=[];
            dependency.role.forEach(function (obj) {
                if (obj.id!==role.systemAdministrator)
                    reducedRoles.push(obj);
            });
            $$("roleId").define("options",reducedRoles);
            $$("roleId").refresh();
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
            });

        }
    },
    
    addUser:function () {
        var form=$$("addUserForm");
        if (form.validate()){
            var user=form.getValues();
            user.statusId=userStatus.onHold;
            user.companyId=userData.companyId;
            $$("userDT").add(user);
            util.dismissDialog('addUserDialog');
        }
    }
};