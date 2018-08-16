var companyView={

    panel:{
        id:"companyPanel",
        adjust:true,
        rows:[
            {
                height:50
            },
            {
                height:500,
                cols:[
                  {},
                  {

                      width:310,
                      rows:[
                          {
                              view:"toolbar",
                              css:"panelToolbar",
                              cols:[
                                  {
                                      view:"label",
                                      width:150,
                                      template:"<span class='fa fa-briefcase'/> Kompanije"
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
                              id:"companyDT",
                              view:"datatable",
                              header:false,
                              select: true,
                              navigation: true,
                              editable: true,
                              editaction: "custom",
                              on: {
                                  onItemDblClick: function (id) {
                                      if (id.row!==-1)
                                      this.editRow(id);
                                  },
                                  onBeforeContextMenu: function (item) {
                                      if (item.row===-1)
                                          return false;
                                      this.select(item.row);
                                  }
                              },
                              css:"webixDatatable",
                              url:"api/company",
                              data:[
                                  {
                                      name:"Administratori sistema",
                                      id:-1

                                  }
                              ],
                              columns:[
                                  {
                                      id:"id",
                                      hidden:true,
                                  },
                                  {
                                      id:"deleted",
                                      hidden:true,
                                  },
                                  {
                                      id:"name",
                                      editable:true,
                                      editor:"text",
                                      fillspace:true
                                  }
                              ]
                          }
                      ]
                  },
                  {},
                  {
                      rows:[
                          {
                              view:"toolbar",
                              css:"panelToolbar",
                              cols:[
                                  {
                                      view:"label",
                                      width:150,
                                      template:"<span class='fa fa-user'/> Korisnici"
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
                              view:"tabview",
                              width:400,
                              cells:[
                                  {
                                      header:"Administrator kompanije"
                                  },
                                  {
                                      header:"Korisnik"
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

    selectPanel:function () {
        $$("main").removeView(rightPanel);
        rightPanel = "companyPanel";
        var panelCopy = webix.copy(this.panel);
        $$("main").addView(webix.copy(panelCopy));
        connection.attachAjaxEvents("companyDT","api/company");
        webix.ui({
            view:"contextmenu",
            id:"companyContextMenu",
            width:"200",
            data:[
                {
                    id:"delete",
                    value:"Obrišite",
                    icon:"trash"
                }
            ],
            master:$$("companyDT"),
            on:{
                onItemClick: function (id) {
                    var context = this.getContext();
                    var delBox = (webix.copy(commonViews.deleteConfirmSerbian("kompanije","kompaniju")));
                    delBox.callback=function (result) {
                        if (result){
                            $$("companyDT").remove(context.id.row);
                        }
                    };
                    webix.confirm(delBox);
                }
            }
        });
    },

    addCompanyDialog:{
        id: "addCompanyDialog",
        view:"popup",
        modal: true,
        position: "center",
        body:{
            rows:[
                {
                    view:"toolbar",
                    css:"panelToolbar",
                    cols:[
                        {
                            view:"label",
                            width:300,
                            template:"<span class='fa fa-briefcase'/> Dodavanje kompanije"
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
                    id:"addCompanyForm",
                    view:"form",
                    elementsConfig:{
                        labelWidth: 100,
                        bottomPadding: 18
                    },
                    elements:[
                        {
                            id:"name",
                            name:"name",
                            view:"text",
                            label:"Naziv:",
                            required:true,
                            invalidMessage:"Naziv je obavezan!"
                        },
                        {
                            id: "addCompanyBtn",
                            view: "button",
                            value: "Dodajte kompaniju",
                            type: "form",
                            click: "companyView.addCompany",
                            align:"right",
                            hotkey: "enter",
                            width: 150
                        }
                    ]
                }
            ]
        }
    },
    
    showAddCompanyDialog:function () {
        if (util.popupIsntAlreadyOpened("addCompanyDialog")) {
            webix.ui(webix.copy(companyView.addCompanyDialog)).show();
            webix.UIManager.setFocus("name");
        }
    },

    addCompany:function () {
        var form=$$("addCompanyForm");
        if (form.validate()){
         $$("companyDT").add(form.getValues());
         util.dismissDialog("addCompanyDialog");
        }
    }
};