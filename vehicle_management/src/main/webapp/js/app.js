var MENU_STATES = {
    COLLAPSED: 0,
    EXPANDED: 1
};
var menuState = MENU_STATES.COLLAPSED;
var userData = null;
var panel = {id: "empty"};
var rightPanel = null;

var menuSystemAdmin=[
    {
        id:"company",
        icon:"briefcase",
        value:"Kompanije"
    },
    {
        id:"logger",
        icon:"history",
        value:"Korisničke akcije"
    }
];

var menuActions = function (id) {
    switch (id) {
        case "logger":
            loggerView.selectPanel();
            break;
        case "company":
            companyView.selectPanel();
            break;
    }
};

var init = function () {
    if (!webix.env.touch && webix.ui.scrollSize) webix.CustomScroll.init();
    webix.i18n.setLocale("sr-SP");
    webix.Date.startOnMonday = true;
    webix.ui(panel);
    panel = $$("empty");
    webix.ajax().get("api/user/state").then(function(data){
        userData=data.json();
        showApp();
    }).fail(function (err) {
        showLogin();
    })
};

var menuEvents = {
    onItemClick: function (item) {
        menuActions(item);
    }
};

var showLogin = function () {
    var login = webix.copy(loginLayout);
    webix.ui(login, panel);
    panel = $$("login");

};

var showApp = function () {
    var main = webix.copy(mainLayout);
    webix.ui(main, panel);
    panel = $$("app");
    var localMenuData = null;
    webix.ui({
        id: "menu-collapse",
        view: "template",
        template: '<div id="menu-collapse" class="menu-collapse">' +
        '<span></span>' +
        '<span></span>' +
        '<span></span>' +
        '</div>',
        onClick: {
            "menu-collapse": function (e, id, trg) {
                var elem = document.getElementById("menu-collapse");
                if (menuState == MENU_STATES.COLLAPSED) {
                    elem.className = "menu-collapse open";
                    menuState = MENU_STATES.EXPANDED;
                    $$("mainMenu").toggle();
                } else {
                    elem.className = "menu-collapse";
                    menuState = MENU_STATES.COLLAPSED;
                    $$("mainMenu").toggle();
                }
            }
        }
    });
    switch (userData.roleId) {
        case role.systemAdministrator:
            localMenuData=menuSystemAdmin;
            break;
    }
    $$("mainMenu").define("data", localMenuData);
    $$("mainMenu").define("on", menuEvents);
    rightPanel = "emptyRightPanel";
    if (userData.roleId===role.systemAdministrator){
        companyView.selectPanel();
        $$("mainMenu").select("company");
    }
};

//main call
window.onload = function () {
    init();
};

