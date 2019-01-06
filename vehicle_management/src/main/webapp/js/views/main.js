const mainLayout = {
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
                            width:250,
                            label: "Vehicle Management System"
                        },
                        {
                            id: "showReportBtn",
                            view: "button",
                            hidden:true,
                            type: "iconButton",
                            label: "Izvještaji",
                            icon: "bar-chart",
                            autowidth:true,
                            click: 'reportView.showGlobalReportPopup',
                        },
                        {},
                        {
                            view: "menu",
                            id: "userMenu",
                            width: 60,
                            openAction: "click",
                            data: [
                                {
                                    height:100,
                                    value: "<span  class='fa fa-angle-down'/>",
                                    icon: "cog",
                                    submenu: [
                                        {
                                            id:"2",
                                            icon:"user",
                                            value:"Profil"
                                        },
                                        {
                                            id: "1",
                                            icon: "sign-out",
                                            value: "Odjavite se",
                                        }
                                    ]
                                }
                            ],
                            on: {
                                onMenuItemClick: function (id) {
                                    switch (id) {
                                        case "2":
                                            profileView.showProfilePopup();
                                            break;
                                        case "1":
                                            logout();
                                            break;

                                    }
                                }
                            }
                        }
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


const loginLayout = {
    id: "login",
    width: "auto",
    height: "auto",
    rows: [
        {
            gravity:0.1
        },
        {
            cols: [
                {},
                {
                    view: "template",
                    borderless: true,
                    height: 500,
                    width: 500,
                    template: '<img  src="../../img/telegroup-logo.png"/>' +
                        '<img  src="../../img/app-logo.png"/>'
                },
                {
                    rows: [
                        {
                            height: 50,
                        },
                        {
                            view: "form",
                            id: "loginForm",
                            borderless: true,
                            width: 400,
                            elementsConfig: util.elementsConfig,
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
                                    align: "right",
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
        },
        {
            gravity:0.1
        }
    ]
};

const login = function () {
    const form = $$("loginForm");
    if (form.validate()) {
        connection.sendAjax("POST","/api/user/login", form.getValues()).then(data=> {
            userData = data.json();
            showApp();
        }).fail(err=> {
            util.messages.showErrorMessage("Prijavljivanje nije uspjelo!");
        });
    }
};

const logout = function () {

    webix.ajax().get("/api/user/logout", function (xhr) {
            if (xhr.status = "200") {
                userData = null;
                util.messages.showLogoutMessage();
                connection.reload();
            } else {
                util.messages.showLogoutErrorMessage();
                connection.reload();
            }
    });
};

const registrationLayout = {
    id: "registration",
    width: "auto",
    height: "auto",
    userId:null,
    rows: [
        {
        },
        {
            cols: [
                {},
                {
                    view: "template",
                    borderless: true,
                    height: 500,
                    width: 500,
                    template: '<img  src="../../img/telegroup-logo.png"/>' +
                        '<img  src="../../img/app-logo.png"/>'
                },
                {
                    rows: [
                        {
                            height: 50,
                            view:"label",
                            css:"registration-label",
                            label:"Registracija"
                        },
                        {},
                        {
                            view: "form",
                            id: "registrationForm",
                            borderless: true,
                            width: 400,
                            elementsConfig: util.elementsConfig,
                            elements: [
                                {

                                },
                                {
                                    id: "username",
                                    name: "username",
                                    view: "text",
                                    label: "Korisničko ime:",
                                    invalidMessage: "Korisničko ime je obavezno!",
                                    required: true
                                },
                                {
                                    id: "firstName",
                                    name: "firstName",
                                    view: "text",
                                    label: "Ime:",
                                    invalidMessage: "Ime je obavezno!",
                                    required: true
                                },
                                {
                                    id: "lastName",
                                    name: "lastName",
                                    view: "text",
                                    label: "Prezime:",
                                    invalidMessage: "Prezime je obavezno!",
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
                                    id: "registrationBtn",
                                    view: "button",
                                    value: "Registrujte se",
                                    type: "form",
                                    click: "register",
                                    align: "right",
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

const register=function () {
    const form=$$("registrationForm");
    if (form.validate()){
        connection.sendAjax("POST","api/user/register",form.getValues()).then(function (result) {
            util.messages.showMessage("Uspješna registracija. Sada se možete prijaviti na sistem.");

            setTimeout(function () {
                connection.sendAjax("GET","api/user/state").then(data=> {
                    return connection.sendAjax("GET","/api/user/logout");
                }).then(value=> {
                    const url=window.location;
                    url.replace(url.protocol+"//"+url.host);
                }).fail(err=> {
                        const url=window.location;
                        url.replace(url.protocol+"//"+url.host);
                });
            },2000);

        }).fail(err=> {
            util.messages.showErrorMessage(err.responseText);
        });
    }
};

const userDialog={
    panel:{
        id:"userDialog",
        view:"popup",
        modal:true,
        position:"center",
        body:{
            rows:[
                {
                    view:"toolbar",
                    css:"panelToolbar",
                    cols:[

                    ]
                },
                {
                    view: "form",
                    id: "registrationForm",
                    borderless: true,
                    width: 400,
                    elementsConfig: util.elementsConfig,
                    elements: [
                        {
                            id:"id",
                            name:"id",
                            hidden:true
                        },
                        {
                            id: "username",
                            name: "username",
                            view: "text",
                            label: "Korisničko ime:",
                            invalidMessage: "Korisničko ime je obavezno!",
                            required: true
                        },
                        {
                            id: "firstName",
                            name: "firstName",
                            view: "text",
                            label: "Ime:",
                            invalidMessage: "Ime je obavezno!",
                            required: true
                        },
                        {
                            id: "lastName",
                            name: "lastName",
                            view: "text",
                            label: "Prezime:",
                            invalidMessage: "Prezime je obavezno!",
                            required: true
                        },
                        {
                            view: "button",
                            value: "Sačuvajte",
                            type: "form",
                            click: "userDialog.save",
                            align: "right",
                            hotkey: "enter",
                            width: 150
                        }
                    ]
                }
            ]
        }

    }
};

