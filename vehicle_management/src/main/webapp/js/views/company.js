var companyView = {

    panel: {
        id: "companyPanel",
        adjust: true,
        rows: [
            {
                height: 50
            },
            {
                height: 500,
                cols: [
                    {},
                    {

                        width: 300,
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
                                    onItemClick: function (id) {
                                        var companyId = id.row === -1 ? 0 : id.row;
                                        var datatable = $$("userDT");
                                        connection.dettachAjaxEvents("userDT");
                                        datatable.clearAll();
                                        datatable.load("api/user/byCompany/" + companyId);
                                        datatable.refresh();
                                    },
                                    onBeforeContextMenu: function (item) {
                                        if (item.row === -1)
                                            return false;
                                        this.select(item.row);
                                    }
                                },
                                css: "webixDatatable",
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
                    {},
                    {
                        rows: [
                            {
                                view: "toolbar",
                                css: "panelToolbar",
                                cols: [
                                    {
                                        view: "label",
                                        width: 150,
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
                                select: true,
                                navigation: true,
                                autowidth: true,
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
                                        width: 250,
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
                                        width: 150,
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
                                        template: "#firstName# #lastName#",
                                        width: 200,

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
                                        width: 125,
                                        template: function (obj) {
                                            return dependencyMap['status'][obj.statusId];
                                        },
                                        header: [
                                            "Status",

                                            {
                                                content: "richSelectFilter",
                                                fillspace: true,
                                                sort: "string"
                                            }
                                        ]
                                    },
                                    {
                                        id: "roleId",
                                        width: 210,
                                        template: function (obj) {
                                            return dependencyMap['role'][obj.roleId];
                                        },
                                        header: [
                                            "Status",
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
                    {}
                ]
            },
            {}
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
                            id: "addCompanyBtn",
                            view: "button",
                            value: "Dodajte korisnika",
                            type: "form",
                            click: "companyView.addUser",
                            align: "right",
                            hotkey: "enter",
                            width: 150
                        }
                    ]
                }
            ]
        }
    },

    showAddUserDialog: function () {
        if (util.popupIsntAlreadyOpened("addUserDialog")) {
            webix.ui(webix.copy(companyView.addUserDialog)).show();
            webix.UIManager.setFocus("username");
        }
    },
};