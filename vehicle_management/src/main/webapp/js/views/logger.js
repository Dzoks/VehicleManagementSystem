var loggerView = {
    panel: {
        id: "loggerPanel",
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
                        template: "<span class='fa fa-history'/> Korisničke akcije"
                    },
                    {}
                ]
            },
            {
                id: "loggerDT",
                view: "datatable",
                css: "webixDatatable",
                multiselect: "false",
                select: false,
                navigation: true,
                editable: false,
                resizeColumn: true,
                resizeRow: true,
                url: "api/logger",
                tooltip: true,
                columns: [
                    {
                        id: "actionType",
                        header: [
                            "Tip akcije",
                            {
                                content: "textFilter",
                                sort: "string"
                            }
                        ],
                        tooltip: false,
                        fillspace: true,

                    },
                    {
                        id: "actionDetails",
                        header: [
                            "Detaljnije",
                            {
                                content: "textFilter",
                                sort: "string"
                            }
                            // TODO Popraviti filter tako da radi range pretraga
                        ],

                        fillspace: true,

                    },
                    {
                        id: "tableName",
                        header: [
                            "Tabela",
                            {
                                content: "textFilter",
                                sort: "string"
                            }
                        ],
                        tooltip: false,
                        fillspace: true,

                    },
                    {
                        id: "created",
                        header: [
                            "Datum",
                            {
                                content: "dateRangeFilter",
                            }
                        ],
                        width: 225,
                        tooltip: false,

                    },
                    {
                        id: "username",
                        header: [
                            "Korisnik",
                            {
                                content: "textFilter",
                                sort: "string"
                            }
                        ],
                        tooltip: false,
                        fillspace: true,

                    },
                    {
                        id: "role",
                        header: [
                            "Tip korisnika",
                            {
                                content: "richSelectFilter",
                                fillspace: true,
                                sort: "string"
                            }
                        ],
                        tooltip: false,
                        fillspace: true,

                    },
                    {
                        id: "companyName",
                        header: [
                            "Kompanija",
                            {
                                content: "richSelectFilter",
                                fillspace: true,
                                sort: "string"
                            }
                        ],
                        tooltip: false,
                        fillspace: true,

                    }
                ]
            }
        ]
    },

    selectPanel: function () {
        $$("main").removeView(rightPanel);
        rightPanel = "loggerPanel";
        var panelCopy = webix.copy(this.panel);
        $$("main").addView(webix.copy(panelCopy));
        if (userData.companyId) {
            $$("loggerDT").hideColumn("companyName");
        }
    }
};
