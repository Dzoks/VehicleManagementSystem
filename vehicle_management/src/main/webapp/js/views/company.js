
var onCompanyClick=function (id) {
    $$("companyDT").select(id);
    var companyId = id === -1 ? 0 : id;
    var datatable = $$("userDT");
    connection.dettachAjaxEvents("userDT");
    datatable.clearAll();
    connection.attachAjaxEvents("userDT","api/user");

    return datatable.load("api/user/byCompany/" + companyId);

};
var companyView = {

    panel: {
        id: "companyPanel",
        adjust: true,
        cols: [
                    {
                        width:300,
                        rows: [
                            {
                                view: "toolbar",
                                css: "panelToolbar",
                                cols: [
                                    {
                                        view: "label",
                                        width: 150,
                                        template: "<span class='fa fa-briefcase'/> Kompanije"
                                    },
                                    {},
                                    {
                                        id: "addCompanyBtn",
                                        view: "button",
                                        type: "iconButton",
                                        label: "Dodajte",
                                        icon: "plus-circle",
                                        click: 'companyView.showAddCompanyDialog',
                                        autowidth: true
                                    }
                                ]
                            },
                            {
                                id: "companyDT",
                                view: "datatable",
                                css:"webixDatatable",
                                fillspace:true,
                                header: false,
                                select: true,
                                navigation: true,
                                editable: true,
                                editaction: "custom",
                                on: {
                                    onItemDblClick: function (id) {
                                        if (id.row !== -1)
                                            this.editRow(id);
                                    },
                                    onItemClick:function(id){
                                        onCompanyClick(id.row);
                                    } ,
                                    onBeforeContextMenu: function (item) {
                                        if (item.row === -1)
                                            return false;
                                        this.select(item.row);
                                    }
                                },

                                url: "api/company",
                                data: [
                                    {
                                        name: "Administratori sistema",
                                        id: -1

                                    }
                                ],
                                columns: [
                                    {
                                        id: "id",
                                        hidden: true
                                    },
                                    {
                                        id: "deleted",
                                        hidden: true
                                    },
                                    {
                                        id: "name",
                                        editable: true,
                                        editor: "text",
                                        fillspace: true
                                    }
                                ]
                            }
                        ]
                    },

                    {
                        rows: [
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
                                        click: 'companyView.showAddUserDialog',
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
                                                suggest: {
                                                    body: {
                                                        template: function (obj) {	// template for options list
                                                            if (obj.$empty)
                                                                return "";
                                                            return dependencyMap['status'][obj.value];
                                                        }
                                                    }

                                                },
                                                    fillspace: true,
                                                sort: "string"
                                            }
                                        ]
                                    },
                                    {
                                        id: "roleId",
                                        width:230,
                                        template: function (obj) {
                                            return dependencyMap['role'][obj.roleId];
                                        },
                                        header: [
                                            "Tip korisnika",
                                            {

                                                content: "richSelectFilter",
                                                suggest: {
                                                    body: {

                                                        template: function (obj) {	// template for options list
                                                            if (obj.$empty)
                                                                return "";
                                                            return dependencyMap['role'][obj.value];
                                                        }
                                                    }

                                                },
                                                sort: "string"
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
                    }
                ]

    },

    selectPanel: function () {
        $$("main").removeView(rightPanel);
        rightPanel = "companyPanel";
        var panelCopy = webix.copy(this.panel);
        $$("main").addView(webix.copy(panelCopy));
        connection.attachAjaxEvents("companyDT", "api/company");
        webix.ui({
            view: "contextmenu",
            id: "companyContextMenu",
            width: "200",
            data: [
                {
                    id: "delete",
                    value: "Obrišite",
                    icon: "trash"
                }
            ],
            master: $$("companyDT"),
            on: {
                onItemClick: function (id) {
                    var context = this.getContext();
                    var delBox = (webix.copy(commonViews.deleteConfirmSerbian("kompanije", "kompaniju")));
                    delBox.callback = function (result) {
                        if (result) {
                            $$("companyDT").remove(context.id.row);
                        }
                    };
                    webix.confirm(delBox);
                }
            }
        });
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
        $$("companyDT").select(-1);
        $$("userDT").load("api/user/byCompany/0");
    },

    addCompanyDialog: {
        id: "addCompanyDialog",
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
                            template: "<span class='fa fa-briefcase'/> Dodavanje kompanije"
                        },
                        {},
                        {
                            view: "icon",
                            icon: "close",
                            align: "right",
                            click: "util.dismissDialog('addCompanyDialog');"
                        }
                    ]
                },
                {
                    id: "addCompanyForm",
                    view: "form",
                    elementsConfig: {
                        labelWidth: 100,
                        bottomPadding: 18
                    },
                    elements: [
                        {
                            id: "name",
                            name: "name",
                            view: "text",
                            label: "Naziv:",
                            required: true,
                            invalidMessage: "Naziv je obavezan!"
                        },
                        {
                            id: "addCompanyBtn",
                            view: "button",
                            value: "Dodajte kompaniju",
                            type: "form",
                            click: "companyView.addCompany",
                            align: "right",
                            hotkey: "enter",
                            width: 150
                        }
                    ]
                }
            ]
        }
    },

    showAddCompanyDialog: function () {
        if (util.popupIsntAlreadyOpened("addCompanyDialog")) {
            webix.ui(webix.copy(companyView.addCompanyDialog)).show();
            webix.UIManager.setFocus("name");
        }
    },

    addCompany: function () {
        var form = $$("addCompanyForm");
        if (form.validate()) {
            $$("companyDT").add(form.getValues());
            util.dismissDialog("addCompanyDialog");
        }
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
                            on:{
                                onChange:function (newv,oldv) {
                                    if (newv===role.systemAdministrator){
                                        $$("companyId").define("required",false);
                                        $$("companyId").define("disabled",true);
                                        $$("companyId").setValue(null);

                                    }else{
                                        $$("companyId").define("required",true);
                                        $$("companyId").define("disabled",false);


                                    }
                                    $$("companyId").refresh();


                                }
                            }
                        },
                        {
                            id:"companyId",
                            name:"companyId",
                            label: "Kompanija:",
                            view:"richselect",
                            required:false,
                            disabled:true,
                            invalidMessage:"Kompanija je obavezna!",
                            on: {
                                onChange: function (newv, oldv) {
                                    if (newv){
                                        var locations=[];
                                        webix.ajax().get("api/location/byCompany/"+newv).then(function (data) {
                                            var array=data.json();
                                            array.forEach(function (obj) {
                                                locations.push({
                                                    id:obj.id,
                                                    value:obj.label
                                                });

                                            });
                                            $$("locationId").define("options",locations);
                                            $$("locationId").define("disabled",false);
                                            $$("locationId").refresh();
                                        });

                                    }else{
                                        $$("locationId").setValue(null);
                                        $$("locationId").define("options",[]);
                                        $$("locationId").define("disabled",true);
                                    }
                                    $$("locationId").refresh();
                                }
                            }
                        },
                        {
                            id:"locationId",
                            name:"locationId",
                            label: "Lokacija:",
                            view:"richselect",
                            disabled:true,
                        },
                        {
                            id: "addCompanyBtn",
                            view: "button",
                            value: "Dodajte korisnika",
                            type: "form",
                            click: "companyView.addUser",
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
            webix.ui(webix.copy(companyView.addUserDialog)).show();
            webix.UIManager.setFocus("username");
            $$("roleId").define("options",dependency.role);
            $$("roleId").refresh();

            var currentCompanies=[];
            $$("companyDT").eachRow(function (row){
                if (row!=-1) {
                    currentCompanies.push({
                        id: row,
                        value: $$("companyDT").getItem(row).name
                    })
                }
            });

            $$("roleId").define("options",dependency.role);
            $$("roleId").refresh();
            $$("companyId").define("options",currentCompanies);
            $$("companyId").refresh();
        }
    },

    addUser:function () {
        var form=$$("addUserForm");
        if (form.validate()){
            var user=form.getValues();
            user.statusId=userStatus.onHold;
            var companyId=user.companyId?user.companyId:-1;
            onCompanyClick(companyId).then(function () {
                $$("userDT").add(user);
                util.dismissDialog('addUserDialog');
            });

        }
    },

    // dwTODO NE UCITA SVE
};
