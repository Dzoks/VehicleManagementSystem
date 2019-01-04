const reservationView={
    vehicleId:null,
    expensesToDelete:[],

    panel:{
        view:"popup",
        id:"reservationView",
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
                            width: 1000,
                            template: "<span class='fa fa-check'></span> Dodavanje rezervacije"
                        },
                        {},
                        {
                            view: "icon",
                            icon: "close",
                            align: "right",
                            click: "util.dismissDialog('reservationView');"
                        }
                    ]
                },
                {
                    cols:[
                        {
                            width:500,
                            id:"reservationForm",
                            view: "form",
                            elementsConfig: {
                                labelWidth: 160,
                                bottomPadding: 18
                            },
                            elements:[
                                {
                                    id:"id",
                                    name:"id",
                                    hidden:"true",
                                },
                                {
                                  cols:[
                                      {},
                                      {
                                          id:"deleteBtn",
                                          view: "button",
                                          align:"right",
                                          type: "iconButton",
                                          label: "Obrišite",
                                          icon: "trash",
                                          autowidth:true,
                                          click: 'reservationView.deleteReservation',
                                      },
                                      {
                                          id:"enableEditBtn",
                                          view: "button",
                                          align:"right",
                                          type: "iconButton",
                                          label: "Izmjenite",
                                          icon: "pencil",
                                          autowidth:true,
                                          click: 'reservationView.enableEdit',
                                      },
                                  ]
                                },

                                {
                                    id:"start_date",
                                    name:"start_date",
                                    view:"datepicker",
                                    required:true,
                                    label:"Početni datum:",
                                    timepicker:true,
                                    suggest:{
                                        type:"calendar",
                                        timepicker:true,
                                        body:{
                                            timepicker:true,
                                        }
                                    },
                                    invalidMessage:"Početni datum je obavezan!"
                                },
                                {
                                    id:"end_date",
                                    name:"end_date",
                                    view:"datepicker",
                                    required:true,
                                    label:"Krajnji datum:",
                                    timepicker:true,
                                    suggest:{
                                        timepicker:true,
                                        type:"calendar", body:{
                                            timepicker:true,
                                        }
                                    },
                                    invalidMessage:"Krajnji datum je obavezan!"
                                },

                                {
                                    id:"text",
                                    name:"text",
                                    label:"Pravac puta:",
                                    view:"text",
                                    required:true,
                                    invalidMessage:"Pravac puta je obavezan!"
                                },
                                {
                                    id:"startMileage",
                                    name:"startMileage",
                                    label:"Početna kilometraža:",
                                    view:"text",
                                },
                                {
                                    id:"endMileage",
                                    name:"endMileage",
                                    label:"Krajnja kilometraža:",
                                    view:"text"
                                },

                                {
                                    id:"addReservationBtn",
                                    view: "button",
                                    value: "Dodajte rezervaciju",
                                    type: "form",
                                    click: "reservationView.addReservation",
                                    align: "right",
                                    hotkey: "enter",
                                    width: 150
                                },
                                {
                                    id:"editReservationBtn",
                                    view: "button",
                                    value: "Sačuvajte",
                                    type: "form",
                                    click: "reservationView.saveEditedReservation",
                                    align: "right",
                                    hotkey: "enter",
                                    width: 150
                                },
                            ],
                            rules:{
                                "startMileage": function (value) {
                                    if (!value){
                                        return true;
                                    }
                                    if (!webix.rules.isNumber(value)) {
                                        $$('reservationForm').elements.startMileage.config.invalidMessage = 'Početna kilometraža mora biti broj!';
                                        return false;
                                    }
                                    return true;
                                },
                                "endMileage": function (value) {
                                    if (!value)
                                        return true;
                                    if (!webix.rules.isNumber(value)) {
                                        $$('reservationForm').elements.endMileage.config.invalidMessage = 'Krajnja kilometraža mora biti broj!';
                                        return false;
                                    }
                                    if ($$("reservationForm").getValues().startMileage>value){
                                        $$('reservationForm').elements.endMileage.config.invalidMessage = 'Krajnja kilometraža mora biti veća od početne!';
                                        return false;
                                    }
                                    return true;
                                },
                            }
                        },
                        {
                            rows:[
                                {
                                    view: "toolbar",
                                    css: "panelToolbar",
                                    height:40,
                                    cols: [
                                        {
                                            view: "label",
                                            template:`<span class='fa fa-check'></span> Troškovi`
                                        },
                                        {},
                                        {
                                            id: "addExpense",
                                            view: "button",
                                            type: "iconButton",
                                            label: "Dodajte",
                                            icon: "plus",
                                            click: 'reservationView.showAddExpenseDialog',
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
                    ]
                },

            ]
        }

    },

    selectPanel(vehicleId,startDate){
        if (util.popupIsntAlreadyOpened("reservationView")){
            reservationView.vehicleId=vehicleId;
            const object={vehicleId:vehicleId,start_date:startDate,end_date:new Date(startDate.getTime()+1000*60*5)};
                webix.ui(webix.copy(reservationView.panel)).show();
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
                                            $$("expenseDT").remove(context.id);
                                        }
                                    };
                                    webix.confirm(delBox);
                                    break;
                                case "edit":
                                    reservationView.showEditExpenseDialog($$("expenseDT").getItem(context.id));
                                    break;
                            }

                        }
                    }
                });
                const form=$$("reservationForm");
                form.setValues(object);
                $$("startMileage").hide();
                $$("endMileage").hide();
                $$("enableEditBtn").hide();
                $$("deleteBtn").hide();
                $$("editReservationBtn").hide();
                reservationView.expensesToDelete=[];
        }
    },

    showDetails(vehicleId,eventId){
        if (util.popupIsntAlreadyOpened("reservationView")){
            reservationView.expensesToDelete=[];
            reservationView.vehicleId=vehicleId;
            connection.sendAjax("GET","api/reservation/custom/"+eventId).then(res=>{
                const object=res.json();
                webix.ui(webix.copy(reservationView.panel)).show();
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
                                            const expense=$$("expenseDT").getItem(context.id);
                                            if (!expense.new)
                                                reservationView.expensesToDelete.push(expense.id);
                                            $$("expenseDT").remove(context.id);
                                        }
                                    };
                                    webix.confirm(delBox);
                                    break;
                                case "edit":
                                    reservationView.showEditExpenseDialog($$("expenseDT").getItem(context.id));
                                    break;
                            }

                        }
                    }
                });
                $$("expenseContextMenu").disable();
                const form=$$("reservationForm");
                form.setValues(object.reservation);
                $$("start_date").setValue(util.strToDateFormat(object.reservation.start_date));
                $$("end_date").setValue(util.strToDateFormat(object.reservation.end_date));
                $$("expenseDT").define("data",object.expenses);
                $$("expenseDT").refresh();
                $$("addReservationBtn").hide();
                $$("editReservationBtn").hide();
                reservationView.disableEdit();
                $$("deleteBtn").hide();
                if  (userData.id===object.reservation.userId || userData.roleId===role.companyAdministrator){
                    $$("enableEditBtn").show();
                    if (new Date()<$$("start_date").getValue()){
                        $$("deleteBtn").show();
                    }
                }else{
                    $$("enableEditBtn").hide();
                }

            }).fail(err=>console.log(err));
        }
    },

    addReservation(){
        const form=$$("reservationForm");
        if (form.validate()){
            const reservation=form.getValues();
            const object={
                reservation:{...reservation,start_date: util.dateToStrFormat(reservation.start_date),end_date: util.dateToStrFormat(reservation.end_date),deleted:0,userId:userData.id,companyId:userData.companyId},
                expenses:[]
            };
            $$("expenseDT").eachRow(expense=>{
                object.expenses.push({...$$("expenseDT").getItem(expense),id:null});
            });
            connection.sendAjax("POST","api/reservation/custom",object).then(res=>{
                const reservation=res.json();
                scheduler.addEvent(reservation);
                util.dismissDialog("reservationView");
                util.messages.showMessage("Uspješno dodavanje!");
            }).fail(err=>{
                console.log(err);
                if (err.status===400){
                    util.messages.showErrorMessage(err.response);
                }else{
                    util.messages.showErrorMessage("Neuspješno dodavanje!");
                }
            });
        }
    },

    saveEditedReservation(){
        const form=$$("reservationForm");
        if (form.validate()){
            const reservation=form.getValues();
            const object={
                reservation:{...reservation,start_date: util.dateToStrFormat(reservation.start_date),end_date: util.dateToStrFormat(reservation.end_date),deleted:0,userId:userData.id,companyId:userData.companyId},
                expenses:[],
                expensesToDelete:reservationView.expensesToDelete
            };
            $$("expenseDT").eachRow(id=>{
                const expense=$$("expenseDT").getItem(id);
                if (expense.new){
                    object.expenses.push({...expense,id:null});
                }else if (expense.updated){
                    object.expenses.push(expense);
                }
            });
            connection.sendAjax("PUT","api/reservation/custom/"+reservation.id,object).then(res=>{
                const reservation=res.json();
                scheduler.deleteEvent(reservation.id);
                scheduler.addEvent(reservation);
                util.dismissDialog("reservationView");
                util.messages.showMessage("Uspješna izmjena!");
            }).fail(err=>{
                console.log(err);
                if (err.status===400){
                    util.messages.showErrorMessage(err.response);
                }else{
                    util.messages.showErrorMessage("Neuspješna izmjena!");
                }
            });
        }
    },

    deleteReservation(){
        const form=$$("reservationForm");
        connection.sendAjax("DELETE","api/reservation/"+form.getValues().id).then(res=>{
            scheduler.deleteEvent(form.getValues().id);
            util.dismissDialog('reservationView');
            util.messages.showMessage("Uspješno brisanje");
        }).fail(err=>{
            console.log(err);
            util.messages.showErrorMessage("Brisanje nije uspjelo!");
        })
    },

    enableEdit(){

        $$("start_date").enable();
        $$("end_date").enable();
        $$("text").enable();
        $$("startMileage").enable();
        $$("endMileage").enable();
        $$("editReservationBtn").show();
        $$("addExpense").show();
        $$("expenseContextMenu").enable();

        const reservation=$$("reservationForm").getValues();
        if (new Date()<reservation.start_date){
            $$("startMileage").disable();
            $$("endMileage").disable();
        }
        else if (new Date()>=reservation.start_date&& new Date()<=reservation.end_date){
            $$("startMileage").enable();
            $$("endMileage").enable();
            $$("start_date").disable();
        }
        else if (new Date()>=reservation.end_date){
            $$("startMileage").enable();
            $$("endMileage").enable();
            $$("end_date").disable();
            $$("start_date").disable();
        }else{
            reservationView.disableEdit();
        }
    },

    disableEdit(){
        $$("start_date").disable();
        $$("end_date").disable();
        $$("text").disable();
        $$("startMileage").disable();
        $$("endMileage").disable();
        $$("editReservationBtn").hide();
        $$("addExpense").hide();
        $$("expenseContextMenu").disable();
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
                            click: "reservationView.addExpense",
                            align: "right",
                            hotkey: "enter",
                            width: 150
                        },
                        {
                            id:"editBtn",
                            view: "button",
                            value: "Sačuvajte",
                            type: "form",
                            click: "reservationView.editExpense",
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
            webix.ui(webix.copy(reservationView.addExpenseDialog)).show();
            webix.UIManager.setFocus("date");
            $$("expenseTypeId").define("options",dependency.expenseType);
            $$("expenseTypeId").refresh();
            $$("editBtn").hide();
        }
    },

    showEditExpenseDialog(expense){
        if (util.popupIsntAlreadyOpened("addExpenseDialog")) {
            webix.ui(webix.copy(reservationView.addExpenseDialog)).show();
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
            $$("expenseDT").add({...form.getValues(),companyId:userData.companyId,
                vehicleId:reservationView.vehicleId,deleted:0,date:webix.Date.dateToStr("%d.%m.%Y. %H:%i")(form.getValues().date),new:true});
            util.dismissDialog('addExpenseDialog');
            util.messages.showMessage("Uspješno dodavanje!");
        }
    },

    editExpense(){
        const form=$$("addExpenseForm");
        if (form.validate()){
            $$("expenseDT").remove(form.getValues().id);
            $$("expenseDT").add({...form.getValues(),companyId:userData.companyId,
                vehicleId:reservationView.vehicleId,deleted:0,date:webix.Date.dateToStr("%d.%m.%Y. %H:%i")(form.getValues().date),updated:true});
            util.dismissDialog('addExpenseDialog');
            util.messages.showMessage("Uspješna izmjena!");
        }
    },
};