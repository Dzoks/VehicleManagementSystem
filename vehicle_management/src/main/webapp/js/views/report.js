const reportView={
    vehicleReportPopup:{
        id:"vehicleReportPopup",
        view:"popup",
        modal:true,
        position:"center",
        body: {
            rows: [
                {
                    view: "toolbar",
                    css: "panelToolbar",
                    cols: [
                        {
                            view: "label",
                            width: 800,
                            template: "<span class='fa fa-bar-chart'/> Izvještaji"
                        },
                        {},
                        {
                            view: "icon",
                            icon: "close",
                            align: "right",
                            click: "util.dismissDialog('vehicleReportPopup');"
                        }
                    ]
                },
                {
                    cols:[
                        {
                            rows:[
                                {
                                    width:400,
                                    id:"periodPicker",
                                    view:"radio",
                                    label:"Period:",
                                    value:'1',
                                    options:[
                                        { id:1, value:"Sedmica"},
                                        { id:2, value:"Mjesec"},
                                        { id:3, value:"Godina"},
                                    ],

                                    on:{
                                        onChange:function (newv,oldv) {
                                            $$("pdfGenerator").hide();
                                            switch(newv){

                                                case '1':
                                                    $$("reportCalendar").define("type","week");
                                                    break;
                                                case '2':
                                                    $$("reportCalendar").define("type","month");
                                                    if ($$("calculateGlobalReportBtn").isVisible()){
                                                        $$("pdfGenerator").show();
                                                    }

                                                    break;
                                                case '3':
                                                    $$("reportCalendar").define("type","year");
                                                    break;
                                            }
                                            $$("reportCalendar").refresh();
                                        }
                                    }
                                },
                                {
                                    id:"pdfGenerator",
                                    hidden:true,
                                    cols:[
                                        {
                                            view:"richselect",
                                            value:'PDF',
                                            id:"typePicker",
                                            options:[
                                                { id:"PDF"},
                                                { id:"XLS"},
                                                { id:"CSV"}
                                            ]
                                        },
                                        {
                                            view:"button",
                                            id:"generateDocument",
                                            align:"right",
                                            value:"Preuzmite izvještaj",
                                            click:"reportView.generateDocument",
                                            width:200,
                                        }
                                    ]
                                },
                                {
                                    id:"reportCalendar",
                                    view:"calendar",
                                    type:"week",

                                },
                                {
                                    view:"button",
                                    id:"calculateVehicleReportBtn",
                                    align:"right",
                                    value:"Kreirajte izvještaj",
                                    click:"reportView.calculateVehicleReport",
                                    width:200,
                                },
                                {
                                    view:"button",
                                    id:"calculateGlobalReportBtn",
                                    align:"right",
                                    value:"Kreirajte izvještaj",
                                    click:"reportView.calculateGlobalReport",
                                    width:200,
                                },

                            ]
                        },
                        {
                            view:"chart",
                            id:"reportChart",
                            type:"pie",
                            value:"#value#",
                            pieInnerText:"#value#",
                            label:"#description#"
                        }
                    ]
                }
            ]
        }
    },

    showVehicleReportPopup(){
        if (util.popupIsntAlreadyOpened("vehicleReportPopup")) {
            webix.ui(webix.copy(reportView.vehicleReportPopup)).show();
            $$("reportCalendar").selectDate(new Date());
            $$("calculateGlobalReportBtn").hide();
        }
    },

    showGlobalReportPopup(){
        if (util.popupIsntAlreadyOpened("vehicleReportPopup")) {
            webix.ui(webix.copy(reportView.vehicleReportPopup)).show();
            $$("reportCalendar").selectDate(new Date());
            $$("calculateVehicleReportBtn").hide();
        }
    },

    calculateVehicleReport(){
        if (!selectedDate)
            return;
        const selectedDate=$$("reportCalendar").getValue();
        let calculatedPeriod;
        switch ($$("periodPicker").getValue()){
            case '1':
                calculatedPeriod=util.getWeekStartAndEnd(selectedDate);
                break;
            case '2':
                calculatedPeriod=util.getMonthStartAndEnd(selectedDate);
                break;
            case '3':
                calculatedPeriod=util.getYearStartAndEnd(selectedDate);
                break;
        }
        const queryToSend={
            vehicleId:vehicleDetailsView.vehicle.id,
            companyId:vehicleDetailsView.vehicle.companyId,
            start_date:util.dateToStrFormat(calculatedPeriod.start),
            end_date:util.dateToStrFormat(calculatedPeriod.end)
        };

        connection.sendAjax("POST","api/expense/vehicleReport",queryToSend).then(res=>{
            const reportArray=res.json();
            reportArray.forEach(r=>{
                if (!r.value){
                    r.value=0;
                }
            });
            $$("reportChart").clearAll();
            $$("reportChart").define("data",reportArray);
            $$("reportChart").refresh();
        }).fail(err=>{
            console.log(err);
            util.messages.showErrorMessage("Neuspješno dobavljanje izvještaja");
        });
    },

    calculateGlobalReport(){

        const selectedDate=$$("reportCalendar").getValue();
        if (!selectedDate)
            return;
        let calculatedPeriod;
        switch ($$("periodPicker").getValue()){
            case '1':
                calculatedPeriod=util.getWeekStartAndEnd(selectedDate);
                break;
            case '2':
                calculatedPeriod=util.getMonthStartAndEnd(selectedDate);
                break;
            case '3':
                calculatedPeriod=util.getYearStartAndEnd(selectedDate);
                break;
        }
        const queryToSend={
            companyId:userData.companyId,
            start_date:util.dateToStrFormat(calculatedPeriod.start),
            end_date:util.dateToStrFormat(calculatedPeriod.end)
        };

        connection.sendAjax("POST","api/expense/allReport",queryToSend).then(res=>{
            const reportArray=res.json();
            reportArray.forEach(r=>{
                if (!r.value){
                    r.value=0;
                }
            });
            $$("reportChart").clearAll();
            $$("reportChart").define("data",reportArray);
            $$("reportChart").refresh();
        }).fail(err=>{
            console.log(err);
            util.messages.showErrorMessage("Neuspješno dobavljanje izvještaja");
        });
    },

    generateDocument(){
        const selectedDate=$$("reportCalendar").getValue();
        if (!selectedDate)
            return;
        const calculatedPeriod=util.getMonthStartAndEnd(selectedDate);
        const object={
            text:$$("typePicker").getValue(),
            start_date:util.dateToStrFormat(calculatedPeriod.start),
            end_date:util.dateToStrFormat(calculatedPeriod.end)
        };

        connection.sendAjax("POST","api/expense/monthReport",object).then(res=>{
            const file=res.json();
            const blob = util.b64toBlob(file.data);
            saveFileAs(blob, file.name);
        }).fail(err=>console.log(err));
    }

    //TODO kraj sedmice util

};