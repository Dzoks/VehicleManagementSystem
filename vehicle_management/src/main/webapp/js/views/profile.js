const profileView={
    userPopup:{
        isEdit:false,
        id: "userPopup",
        view: "popup",
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
                            template: "<span class='fa fa-user'/> Profil korisnika"
                        },
                        {},
                        {
                            view: "icon",
                            icon: "close",
                            align: "right",
                            click: "util.dismissDialog('userPopup');"
                        }
                    ]
                },
                {
                    id: "profileForm",
                    view: "form",
                    elementsConfig: {
                        labelWidth: 120,
                        bottomPadding: 18
                    },
                    elements: [
                        {
                            id: "id",
                            name: "id",
                            hidden:true,
                            required: true,
                        },
                        {
                            id:"firstName",
                            name:"firstName",
                            label: "Ime:",
                            view:"text",
                            required:true,
                            invalidMessage:"Ime je obavezno!",
                        },
                        {
                            id:"lastName",
                            name:"lastName",
                            label: "Prezime:",
                            view:"text",
                            required:true,
                            invalidMessage:"Prezime je obavezno!",
                        },
                        {
                            id:"notificationTypeId",
                            name:"notificationTypeId",
                            label: "Obavještenja:",
                            required:true,
                            view:"richselect",
                        },
                        {
                            id:"locationId",
                            name:"locationId",
                            label: "Lokacija:",
                            view:"richselect",
                        },
                        {
                            id: "saveProfileBtn",
                            view: "button",
                            value: "Sačuvajte",
                            type: "form",
                            click: "profileView.updateProfile",
                            align: "right",
                            hotkey: "enter",
                            width: 150
                        }

                    ],

                }
            ]
        }
    },


    showProfilePopup(user){
        if (util.popupIsntAlreadyOpened("userPopup")) {
            webix.ui(webix.copy(profileView.userPopup));
            setTimeout(function () {
                $$("userPopup").show();

            }, 0);
            if (user){
                profileView.userPopup.isEdit=true;
                $$("profileForm").setValues(user);
            }else{
                $$("profileForm").setValues(userData);
                profileView.userPopup.isEdit=false;
            }
            if ($$("profileForm").getValues().roleId===role.systemAdministrator){
                $$("notificationTypeId").hide();
                $$("locationId").hide();
            }
            $$("notificationTypeId").define("options",dependency.notificationType);
            $$("notificationTypeId").refresh();
            const locations=[];
            connection.sendAjax("GET","api/location").then(data=> {
                const array=data.json();
                array.forEach(function (obj) {
                    if (profileView.userPopup.isEdit&&userData.roleId===role.systemAdministrator){
                        if (obj.companyId==user.companyId){
                            locations.push({
                                id:obj.id,
                                value:obj.label
                            });
                        }
                    }else{
                        locations.push({
                            id:obj.id,
                            value:obj.label
                        });
                    }


                });
                $$("locationId").define("options",locations);
                $$("locationId").refresh();
            });
        }
    },

    updateProfile(){
        const form=$$("profileForm");
        const user=form.getValues();
        if (form.validate()){
            connection.sendAjax("PUT","api/user/"+user.id,user).then(res=>{
                if (res.text()){
                    if (profileView.userPopup.isEdit){
                        //add changed to list
                        $$("userDT").updateItem(user.id, user);
                    }else{
                        userData=form.getValues();
                    }
                    util.dismissDialog('userPopup');
                    util.messages.showMessage("Uspješna izmjena!");
                }
            }).fail(err=>{
                console.log(err);
                util.messages.showErrorMessage("Neuspješna izmjena!");
            });
        }
    }
};