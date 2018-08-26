var MENU_STATES = {
    COLLAPSED: 0,
    EXPANDED: 1
};
var menuState = MENU_STATES.COLLAPSED;
var userData = null;
var panel = {id: "empty"};
var rightPanel = null;

var menuSystemAdmin = [
    {
        id: "company",
        icon: "briefcase",
        value: "Kompanije"
    },
    {
        id: "logger",
        icon: "history",
        value: "Korisničke akcije"
    }
];

var menyCompanyAdmin=[
    {
        id:"dashboard",
        icon:"home",
        value:"Početna"
    },
    {
        id:"vehicle",
        icon:"car",
        value:"Vozila"
    },
    {
        id: "logger",
        icon: "history",
        value: "Korisničke akcije"
    },
    {
        id:"user",
        icon:"user",
        value:"Korisnici"
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
        case "vehicle":
            vehicleView.selectPanel();
            break;
        case "dashboard":
            locationView.selectPanel();
            break;
        case "user":
            userView.selectPanel();
            break;
    }
};

var init = function () {
    if (!webix.env.touch && webix.ui.scrollSize) webix.CustomScroll.init();
    webix.i18n.setLocale("sr-SP");
    webix.Date.startOnMonday = true;
    webix.ui(panel);
    panel = $$("empty");
    var urlQuery=window.location.search;
    if (urlQuery && urlQuery.startsWith('?q=reg')){
        var token=urlQuery.split('=')[2];
        webix.ajax().get("api/user/check/"+token).then(function (result) {
            var userId=result.json();
            showRegistration(userId);
        }).fail(function (err) {
            util.messages.showErrorMessage("Token je istekao ili nije validan!");
            checkState();
        })
    }else{
        checkState();
    }

};

var checkState=function(){
    webix.ajax().get("api/user/state").then(function (data) {
        userData = data.json();
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

var showRegistration = function (userId) {
    var registration=webix.copy(registrationLayout);
    webix.ui(registration,panel);
    panel=$$("registration");
    $$("registrationForm").setValues({
        id:userId
    });

};

var showApp = function () {
    var promise=preloadDependencies();
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
            localMenuData = menuSystemAdmin;
            break;
        case role.companyAdministrator:
            localMenuData=menyCompanyAdmin;
            break;
    }
    $$("mainMenu").define("data", localMenuData);
    $$("mainMenu").define("on", menuEvents);
    rightPanel = "emptyRightPanel";
    promise.then(function (value) {
        if (userData.roleId === role.systemAdministrator) {
            companyView.selectPanel();
            $$("mainMenu").select("company");
        }else{
            locationView.selectPanel();
            $$("mainMenu").select("dashboard");
        }
    }).fail(function (err) {
     //   connection.reload();
    });

};

var preloadDependencies = function () {
    var promises=[];
    promises.push(webix.ajax().get("api/role").then(function (data) {
        var roles = [];
        var array = [];
        data.json().forEach(function (obj) {
            roles[obj.id] = obj.value;
            array.push(obj);
        });
        dependencyMap["role"] = roles;
        dependency["role"] = array;

    }));
    promises.push(webix.ajax().get("api/status").then(function (data) {
        var status = [];
        var array = [];

        data.json().forEach(function (obj) {
            status[obj.id] = obj.value;
            array.push(obj);
        });
        dependencyMap["status"] = status;
        dependency["status"] = array;
    }));
    promises.push(webix.ajax().get("api/expense-type").then(function (data) {
        var expenseTypes = [];
        var array = [];

        data.json().forEach(function (obj) {
            expenseTypes[obj.id] = obj.value;
            array.push(obj);
        });
        dependencyMap["expenseType"] = expenseTypes;
        dependency["expenseType"] = array;
    }));
    promises.push(webix.ajax().get("api/notification-type").then(function (data) {
        var notificationTypes = [];
        var array = [];
        data.json().forEach(function (obj) {
            notificationTypes[obj.id] = obj.value;
            array.push(obj);
        });
        dependencyMap["notificationType"] = notificationTypes;
        dependency["notificationType"] = array;

    }));
    promises.push(webix.ajax().get("api/fuel-type").then(function (data) {
        var fuel = [];
        var array = [];
        data.json().forEach(function (obj) {
            fuel[obj.id] = obj.value;
            array.push(obj);
        });
        dependencyMap['fuelType'] = fuel;
        dependency['fuelType'] = array;

    }));
    return webix.promise.all(promises);

};

//main call
window.onload = function () {
    init();
};

