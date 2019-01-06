const vehicleDetailsView={
    vehicle:null,

    panel:{
        id:"vehicleDetailsPanel",
        adjust:true,
        rows:[
            {
                cols:[
                    {
                        gravity:0.3,
                        rows:[
                            {
                                view: "toolbar",
                                css: "panelToolbar",
                                height:45,
                                cols: [
                                    {
                                        view: "label",
                                        template: "<span class='fa fa-car'/> Vozilo"
                                    },
                                    {
                                        id: "editVehicleBtn",
                                        view: "button",
                                        type: "iconButton",
                                        label: "Izmjenite",
                                        icon: "pencil",
                                        click: 'vehicleDetailsView.enableEdit',
                                        autowidth: true
                                    }
                                ]
                            },
                            {
                                view:"form",
                                gravity:0.3,
                                id:"vehicleDetailsForm",
                                elementsConfig: {
                                    labelWidth: 150,
                                    bottomPadding: 18
                                },
                                elements:[
                                    {
                                        id:"id",
                                        view:"text",
                                        name:"id",
                                        hidden:true,
                                    },
                                    {
                                        id:"registration",
                                        name:"registration",
                                        label:"Registracijski broj:",
                                        view:"text",
                                        disabled:true,
                                        required:true,
                                        invalidMessage:"Registracijski broj je obavezan!"
                                    },
                                    {
                                        id: "fuelTypeId",
                                        name: "fuelTypeId",
                                        label: "Tip goriva:",
                                        disabled:true,
                                        view: "richselect",
                                        required: true,
                                        invalidMessage: "Tip goriva je obavezan!"
                                    },
                                    {
                                        id: "locationId",
                                        name: "locationId",
                                        view: "richselect",
                                        label: "Lokacija:",
                                        disabled:true,
                                        required: true,
                                        invalidMessage: "Lokacija je obavezna!"
                                    },
                                    {
                                        id:"manufacturer",
                                        name:"manufacturer",
                                        view:"text",
                                        label:"Proizvođač:",
                                        disabled:true,
                                        required:true,
                                        invalidMessage:"Proizvođač je obavezan!"
                                    },
                                    {
                                        id:"model",
                                        name:"model",
                                        view:"text",
                                        label:"Model:",
                                        disabled:true,
                                        required:true,
                                        invalidMessage:"Model je obavezan!"
                                    },
                                    {
                                        id: "description",
                                        name: "description",
                                        view: "textarea",
                                        disabled:true,
                                        label: "Opis:",
                                    },
                                    {
                                      cols:[
                                          {},
                                          {
                                              id:"saveChangesBtn",
                                              view: "button",
                                              value: "Sačuvajte",
                                              type: "form",
                                              click: "vehicleDetailsView.saveChanges",
                                              hidden:true,
                                              align: "right",
                                              width:150,
                                          },
                                          {
                                              id:"cancelChangesBtn",
                                              view: "button",
                                              value: "Otkažite",
                                              type: "form",
                                              click: "vehicleDetailsView.cancelEdit",
                                              hidden:true,
                                              align: "right",
                                              width:150,
                                          }
                                      ]
                                    },
                                    {}
                                ]
                            },
                        ]
                    },
                    {
                        view:"tabview",
                        id:"tabView",
                        gravity:0.7,
                        cells:[
                            {
                                header:"Rezervacije",
                                body:{
                                    view:"template",
                                    template:`
                                        <div id="vehicle_scheduler" class="dhx_cal_container" style='width:100%; height:100%;'>
                                            <div class="dhx_cal_navline">
                                                <div class="dhx_cal_prev_button">&nbsp;</div>
                                                <div class="dhx_cal_next_button">&nbsp;</div>
                                                <div class="dhx_cal_today_button"></div>
                                                <div class="dhx_cal_date"></div>
                                                <div class="dhx_cal_tab" name="week_tab" ></div>
                                                <div class="dhx_cal_tab" name="month_tab"></div>
                                            </div>
                                            <div class="dhx_cal_header"></div>
                                            <div class="dhx_cal_data"></div>       
                                       </div>
                                    `
                                }
                            },
                            {
                                id:"expenseTab",
                                header:"Troškovi",
                                body:{
                                    id:"expenseTab",

                                    rows:[
                                        {
                                            view: "toolbar",
                                            css: "panelToolbar",
                                            height:40,
                                            cols: [
                                                {
                                                },
                                                {
                                                    view: "button",
                                                    type: "iconButton",
                                                    label: "Izvještaji",
                                                    icon: "bar-chart",
                                                    click: 'reportView.showVehicleReportPopup',
                                                    autowidth: true
                                                },
                                                {
                                                    id: "addExpense",
                                                    view: "button",
                                                    type: "iconButton",
                                                    label: "Dodajte",
                                                    icon: "plus",
                                                    click: 'vehicleDetailsView.showAddExpenseDialog',
                                                    autowidth: true
                                                }
                                            ]
                                        },
                                        {
                                            id: "expenseDT",
                                            view: "datatable",
                                            css: "webixDatatable",
                                            multiselect: "false",
                                            select: true,
                                            navigation: true,
                                            editable: true,
                                            resizeColumn: true,
                                            resizeRow: true,
                                            editaction: "dblclick",
                                            tooltip: true,
                                            on: {
                                                onBeforeContextMenu: function (item) {
                                                    this.select(item.row);
                                                },
                                            },
                                            columns:[
                                                {
                                                    id:"id",
                                                    name:"id",
                                                    hidden:"true"
                                                },
                                                {
                                                    id:"date",
                                                    name:"date",
                                                    //format:webix.Date.dateToStr("%d.%m.%Y %H:%i"),
                                                    header: [
                                                        "Datum",
                                                        {
                                                            content: "dateRangeFilter",
                                                        }
                                                    ],
                                                    fillspace:true,
                                                    editable:true,
                                                },
                                                {
                                                    id:"value",
                                                    name:"value",
                                                    header: [
                                                        "Iznos",
                                                        {
                                                            content: "numberFilter",
                                                            sort: "string"
                                                        }
                                                    ],
                                                    fillspace:true,
                                                },
                                                {
                                                    id:"description",
                                                    name:"description",
                                                    header: [
                                                        "Opis",
                                                        {
                                                            content: "textFilter",
                                                            sort: "string"
                                                        }
                                                    ],
                                                    fillspace:true,
                                                },
                                                {
                                                    id:"expenseTypeId",
                                                    name:"expenseTypeId",
                                                    fillspace:true,
                                                    template: function (obj) {
                                                        return dependencyMap['expenseType'][obj.expenseTypeId];
                                                    },
                                                    header: [
                                                        "Tip troška",
                                                        {
                                                            content: "richSelectFilter",
                                                            fillspace: true,
                                                            sort: "string",
                                                            suggest: {
                                                                body: {

                                                                    template: function (obj) {	// template for options list
                                                                        if (obj.$empty)
                                                                            return "";
                                                                        return dependencyMap['expenseType'][obj.value];
                                                                    }
                                                                }
                                                            },
                                                        }
                                                    ]
                                                },
                                            ]
                                        }
                                    ]
                                }
                            }
                        ]
                    }
                ]
            }
        ]
    },

    selectPanel:function(vehicleId){
        $$("mainMenu").select("vehicle");
        $$("main").removeView(rightPanel);
        rightPanel = "vehicleDetailsPanel";
        const panelCopy = webix.copy(this.panel);
        $$("main").addView(webix.copy(panelCopy));
        $$("fuelTypeId").define("options",dependency.fuelType);
        $$("fuelTypeId").refresh();

        webix.ui({
            view: "contextmenu",
            id: "expenseContextMenu",
            width: "200",
            data: [
                {
                    id:"edit",
                    value:"Izmjenite",
                    icon:"pencil"
                },
                {
                    id: "delete",
                    value: "Obrišite",
                    icon: "trash"
                }
            ],
            master: $$("expenseDT"),
            on: {
                onItemClick: function (id) {
                    const context = this.getContext();

                    switch(id){
                        case "delete":
                            const delBox = (webix.copy(commonViews.deleteConfirmSerbian("troška", "trošak")));
                            delBox.callback = result=> {
                                if (result) {
                                    connection.sendAjax("DELETE","api/expense/"+context.id.row).then(res=>{
                                        $$("expenseDT").remove(context.id);
                                        util.messages.showMessage("Uspješno brisanje!");
                                    }).fail(err=>{
                                        console.log(err);
                                        util.messages.showErrorMessage("Neuspješno brisanje");
                                    });
                                }
                            };
                            webix.confirm(delBox);
                            break;
                        case "edit":
                            vehicleDetailsView.showEditExpenseDialog($$("expenseDT").getItem(context.id));
                            break;
                    }

                }
            }
        });
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
        connection.sendAjax("GET","api/vehicle/"+vehicleId).then(res=>{
            const vehicle=res.json();
            const form=$$("vehicleDetailsForm");
            vehicleDetailsView.vehicle = vehicle;
            form.setValues(vehicle);
            if (userData.roleId===role.user){
                $$("tabView").removeView('expenseTab');
                $$("editVehicleBtn").hide();
            }else{
                $$("expenseDT").load("api/expense/byVehicle/"+vehicle.id);

            }
            vehicleDetailsView.loadScheduler(vehicle.id);

        }).fail(err=>{
            console.log(err);
        });
    },

    loadScheduler(vehicleId){
        scheduler.config.xml_date="%d.%m.%Y. %H:%i";
        scheduler.config.readonly = true;
        scheduler.init("vehicle_scheduler");
        scheduler.load("api/reservation/byVehicle/"+vehicleId, "json");
        scheduler.attachEvent("onClick",function (id,e) {
            reservationView.showDetails(vehicleId,id);
        });
        scheduler.attachEvent("onEventLoading", function (ev) {
            if (ev.userId !== userData.id )
                ev.color = "#bdd5ff";
            return true;
        });
        scheduler.attachEvent("onEmptyClick", function (date, e) {
            if (date < new Date()) {
                util.messages.showErrorMessage("Nemoguće je dodati rezervaciju u prošlosti!");
                return;
            }
            connection.sendAjax("POST","api/reservation/checkAvailability",{vehicleId:vehicleId,start_date:util.dateToStrFormat(date)}).then(res=>{
                if (res.text()==="true"){
                    reservationView.selectPanel(vehicleId,date);
                }else{
                    util.messages.showErrorMessage("Već postoji rezervacija za odabrani datum!");
                }
            })

        });
    },

    saveChanges(){
        const form=$$("vehicleDetailsForm");
        connection.sendAjax("PUT","api/vehicle/"+vehicleDetailsView.vehicle.id,form.getValues()).then(res=>{
            if (res.text()){
                vehicleDetailsView.vehicle=form.getValues();
                vehicleDetailsView.cancelEdit();
                util.messages.showMessage("Uspješna izmjena!");
            }
        }).fail(err=>{
            console.log(err);
            if (err.status===400)
                util.messages.showErrorMessage(err.response);
            else
                util.messages.showErrorMessage("Neuspješna izmjena!");
            form.setValues(vehicleDetailsView.vehicle);
        });
    },

    enableEdit(){
        $$("registration").enable();
        $$("fuelTypeId").enable();
        $$("locationId").enable();
        $$("manufacturer").enable();
        $$("model").enable();
        $$("description").enable();
        $$("saveChangesBtn").show();
        $$("cancelChangesBtn").show();
    },

    cancelEdit(){
        $$("registration").disable();
        $$("fuelTypeId").disable();
        $$("locationId").disable();
        $$("manufacturer").disable();
        $$("model").disable();
        $$("description").disable();
        $$("saveChangesBtn").hide();
        $$("cancelChangesBtn").hide();
        $$("vehicleDetailsForm").setValues(vehicleDetailsView.vehicle);
    },

    addExpenseDialog:{
        id: "addExpenseDialog",
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
                            width: 400,
                            template: "<span class='fa fa-money-bill-alt'/> Dodavanje troška"
                        },
                        {},
                        {
                            view: "icon",
                            icon: "close",
                            align: "right",
                            click: "util.dismissDialog('addExpenseDialog');"
                        }
                    ]
                },
                {
                    id:"addExpenseForm",
                    view: "form",
                    elementsConfig: {
                        labelWidth: 150,
                        bottomPadding: 18
                    },
                    elements:[
                        {
                            id:"id",
                            name:"id",
                            hidden:"true",
                        },
                        {
                            id:"date",
                            name:"date",
                            view:"datepicker",
                            required:true,
                            label:"Datum:",

                            suggest:{
                                type:"calendar",
                                timepicker:true,
                                body:{
                                    timepicker:true,
                                    maxDate:new Date(new Date().getTime()+60000),

                                }
                            },
                            timepicker:true,
                            invalidMessage:"Datum je obavezan!"
                        },
                        {
                            id:"value",
                            name:"value",
                            label:"Iznos:",
                            view:"text",
                            required:true,
                            invalidMessage:"Iznos je obavezan!"
                        },
                        {
                            id: "expenseTypeId",
                            name: "expenseTypeId",
                            view: "richselect",
                            label: "Tip troška:",
                            required: true,
                            invalidMessage: "Tip troška je obavezan!"
                        },
                        {
                            id:"description",
                            name:"description",
                            label:"Opis:",
                            view:"textarea"
                        },
                        {
                            id:"addBtn",
                            view: "button",
                            value: "Dodajte trošak",
                            type: "form",
                            click: "vehicleDetailsView.addExpense",
                            align: "right",
                            hotkey: "enter",
                            width: 150
                        },
                        {
                            id:"editBtn",
                            view: "button",
                            value: "Sačuvajte",
                            type: "form",
                            click: "vehicleDetailsView.editExpense",
                            align: "right",
                            hotkey: "enter",
                            width: 150
                        },
                    ],
                    rules:{
                        "value": function (value) {
                            if (!value){
                                $$('addExpenseForm').elements.value.config.invalidMessage = 'Iznos je obavezan!';
                                return false;
                            }
                            if (!webix.rules.isNumber(value)) {
                                $$('addExpenseForm').elements.value.config.invalidMessage = 'Iznos mora biti broj!';
                                return false;
                            }
                            return true;
                        },
                    }
                }
            ]
        }
    },

    showAddExpenseDialog(){
        if (util.popupIsntAlreadyOpened("addExpenseDialog")) {
            webix.ui(webix.copy(vehicleDetailsView.addExpenseDialog)).show();
            webix.UIManager.setFocus("date");
            $$("expenseTypeId").define("options",dependency.expenseType);
            $$("expenseTypeId").refresh();
            $$("editBtn").hide();
        }
    },

    showEditExpenseDialog(expense){
        if (util.popupIsntAlreadyOpened("addExpenseDialog")) {
            webix.ui(webix.copy(vehicleDetailsView.addExpenseDialog)).show();
            webix.UIManager.setFocus("date");
            $$("expenseTypeId").define("options",dependency.expenseType);
            $$("expenseTypeId").refresh();
            $$("addExpenseForm").setValues({...expense,date:webix.Date.strToDate("%d.%m.%Y. %H:%i")(expense.date)});
            $$("addBtn").hide();
        }
    },

    addExpense(){
        const form=$$("addExpenseForm");
        if (form.validate()){
            connection.sendAjax("POST","api/expense",{...form.getValues(),companyId:userData.companyId,
                vehicleId:vehicleDetailsView.vehicle.id,deleted:0,date:webix.Date.dateToStr("%d.%m.%Y. %H:%i")(form.getValues().date)}).then(res=>{
                if (res.json()){
                    const table=$$("expenseDT");
                    table.clearAll();
                    table.load("api/expense/byVehicle/"+vehicleDetailsView.vehicle.id);
                    util.dismissDialog('addExpenseDialog');
                    util.messages.showMessage("Uspješno dodavanje!");
                }else{
                    util.messages.showErrorMessage("Neuspješno dodavanje!");
                }
            }).fail(err=>{
                console.log(err);
                util.messages.showErrorMessage("Neuspješno dodavanje!");
            });
        }
    },

    editExpense(){
        const form=$$("addExpenseForm");
        if (form.validate()){
            connection.sendAjax("PUT","api/expense/"+form.getValues().id,{...form.getValues(),companyId:userData.companyId,
                vehicleId:vehicleDetailsView.vehicle.id,deleted:0,date:webix.Date.dateToStr("%d.%m.%Y. %H:%i")(form.getValues().date)}).then(res=>{
                if (res.text()){
                    const table=$$("expenseDT");
                    table.clearAll();
                    table.load("api/expense/byVehicle/"+vehicleDetailsView.vehicle.id);
                    util.dismissDialog('addExpenseDialog');
                    util.messages.showMessage("Uspješna izmjena!");
                }else{
                    util.messages.showErrorMessage("Neuspješna izmjena!");
                }
            }).fail(err=>{
                console.log(err);
                util.messages.showErrorMessage("Neuspješna izmjena!");
            });
        }
    },



};