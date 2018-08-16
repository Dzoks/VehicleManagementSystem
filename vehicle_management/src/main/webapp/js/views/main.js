var mainLayout = {
    id: "app",
    width: "auto",
    height: "auto",
    rows: [
        {
            cols: [
                {
                    view: "template",
                    width: 240,
                    css: "logoInside",
                    template: '<img  src="../../img/telegroup-logo.png"/>'
                },
                {
                    view: "toolbar",
                    css: "mainToolbar",
                    height: 50,
                    cols: [
                        {
                            id: "appNameLabel",
                            view: "label",
                            css: "appNameLabel",
                            label: "Vehicle Management"
                        },
                        {}
                    ]
                }
            ]
        },
        {
            id: "main",
            cols: [
                {
                    rows: [
                        {
                            id: "mainMenu",
                            css: "mainMenu",
                            view: "sidebar",
                            gravity: 0.01,
                            minWidth: 41,
                            collapsed: true
                        },
                        {
                            id: "sidebarBelow",
                            css: "sidebar-below",
                            view: "template",
                            template: "",
                            height: 50,
                            gravity: 0.01,
                            minWidth: 41,
                            width: 41,
                            type: "clean"
                        }
                    ]
                },
                {
                    id: "emptyRightPanel"
                }
            ]
        }
    ]
};


var loginLayout = {
    id: "login",
    width: "auto",
    height: "auto",
    rows:[
        {
            height:50
        },
        {
            cols:[
                {},
                {
                    view: "template",
                    borderless:true,
                    height:500,
                    width:500,
                    template: '<img  src="../../img/telegroup-logo.png"/>' +
                        '<img  src="../../img/app-logo.png"/>'
                },
                {
                  rows:[
                      {
                          height:50,
                      },
                      {
                          view:"form",
                          id:"loginForm",
                          borderless:true,
                          width: 400,
                          elementsConfig: {
                              labelWidth: 140,
                              bottomPadding: 18
                          },
                          elements: [
                              {
                                  id: "username",
                                  name: "username",
                                  view: "text",
                                  label: "Korisničko ime:",
                                  invalidMessage: "Korisničke ime je obavezno!",
                                  required: true
                              },
                              {
                                  id: "password",
                                  name: "password",
                                  view: "text",
                                  type: "password",
                                  label: "Lozinka:",
                                  invalidMessage: "Lozinka je obavezna!",
                                  required: true
                              },
                              {
                                  id: "companyName",
                                  name: "companyName",
                                  view: "text",
                                  label: "Kompanija:"
                              },
                              {
                                  id: "loginBtn",
                                  view: "button",
                                  value: "Prijavite se",
                                  type: "form",
                                  click: "login",
                                  align:"right",
                                  hotkey: "enter",
                                  width: 150
                              }
                          ]
                      },
                      {}

                  ]
                },
                {}
            ]
        }
    ]
};

var login = function () {
};

var logout = function () {
};