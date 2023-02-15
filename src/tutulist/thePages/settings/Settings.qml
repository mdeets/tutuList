import QtQuick 2.15
import "../../theScripts/config.js" as Configs
import "../../theScripts/settings.js" as Settings
import "../../theScripts/databaseHeader.js" as DBC
import "../../theComponents"
import QtQuick.Controls 2.15
Page
{
    signal goToMain;
    property int tempInterval:0;

    onGoToMain:
    {
        console.log("source: Settings.qml -> signal goBack called.)")
    }

    Rectangle
    {
        id:local_root;
        anchors.fill:parent;
        color:appColors.c_background;//"#403E42"
        MouseArea //to avoid click on items placed under this ppage.
        {
            anchors.fill:parent;
        }
        Rectangle
        {
            id:baseHeaderSettings;
            width:parent.width;
            height:50;
            color:"transparent";

            Rectangle
            {
                id:baseBackButton;
                width:45;
                height:45;
                color:"transparent";
                anchors
                {
                    left:parent.left;
                    leftMargin:10;
                    verticalCenter: parent.verticalCenter;
                }

                Image
                {
                    width:24; height:24;
                    source:  appIcons.icon_back;
                    anchors.centerIn:parent;
                }
                MouseArea
                {
                    anchors.fill: parent;
                    onClicked:
                    {
                        goToMain();
                    }
                }
            }

            Text
            {
                id:titleSetting;
                text: "Settings";
                color:appColors.c_font_title;
                font.pointSize: Configs.font_size_title;
                anchors
                {
                    verticalCenter:parent.verticalCenter
                    left:baseBackButton.right;
                }
            }






            //dark / light starts


        Rectangle
        {
            width:45; height:45;
            color:"transparent";
            anchors.verticalCenter: parent.verticalCenter;
            anchors.right:parent.right;
            anchors.rightMargin:25;
            AnimatedImage
            {
                id:lightOrDark;
                source: appIcons.animated_icon_sunMoon;
                paused: false;
            }


            MouseArea
            {
                anchors.fill:parent;
                onClicked:
                {
                    console.log("source : settings.qml -> on change theme clicked.");
                    if(appColors.c_theme === "light")
                    {
                        if(Settings.set("theme","dark"))
                        {
                            console.log("source: settings.qml -> theme updated.")
                            appColors.c_theme = "dark";
                            appColors.c_background = Configs.colorPackDark["background"];
                            appColors.c_button_background = Configs.colorPackDark["button_background"];
                            appColors.c_button_text = Configs.colorPackDark["button_text"];
                            appColors.c_button_background_cancel = Configs.colorPackDark["button_background_cancel"];
                            appColors.c_task_background = Configs.colorPackDark["task_background"];
                            appColors.c_stepTask_background = Configs.colorPackDark["stepTask_background"];
                            appColors.c_stepTask_text = Configs.colorPackDark["stepTask_text"];
                            appColors.c_task_text = Configs.colorPackDark["task_text"];
                            appColors.c_input_background = Configs.colorPackDark["input_background"];
                            appColors.c_input_text = Configs.colorPackDark["input_text"];
                            appColors.c_input_placeholder = Configs.colorPackDark["input_placeholder"];
                            appColors.c_bg_indicator = Configs.colorPackDark["bg_indicator"];
                            appColors.c_font_text = Configs.colorPackDark["font_text"];
                            appColors.c_font_title = Configs.colorPackDark["font_title"];
                            appColors.c_List_for_task_priority=
                            [
                                Configs.colorPackDark["priorty_unknown"],
                                Configs.colorPackDark["priorty_1"],
                                Configs.colorPackDark["priorty_2"],
                                Configs.colorPackDark["priorty_3"],
                                Configs.colorPackDark["priorty_4"],
                                Configs.colorPackDark["priorty_5"],
                                Configs.colorPackDark["priorty_6"],
                                Configs.colorPackDark["priorty_7"],
                                Configs.colorPackDark["priorty_8"]
                            ];
                        }
                        else
                        {
                            console.log("source: settings.qml -> theme update failed.");
                        }
                    }
                    else
                    {
                        if(Settings.set("theme","light"))
                        {
                            console.log("source: settings.qml -> theme updated.")
                            appColors.c_theme = "light";
                            appColors.c_background = Configs.colorPackLight["background"];
                            appColors.c_button_background = Configs.colorPackLight["button_background"];
                            appColors.c_button_text = Configs.colorPackLight["button_text"];
                            appColors.c_button_background_cancel = Configs.colorPackLight["button_background_cancel"];
                            appColors.c_task_background = Configs.colorPackLight["task_background"];
                            appColors.c_stepTask_background = Configs.colorPackLight["stepTask_background"];
                            appColors.c_stepTask_text = Configs.colorPackLight["stepTask_text"];
                            appColors.c_task_text = Configs.colorPackLight["task_text"];
                            appColors.c_input_background = Configs.colorPackLight["input_background"];
                            appColors.c_input_text = Configs.colorPackLight["input_text"];
                            appColors.c_input_placeholder = Configs.colorPackLight["input_placeholder"];
                            appColors.c_bg_indicator = Configs.colorPackLight["bg_indicator"];
                            appColors.c_font_text = Configs.colorPackLight["font_text"];
                            appColors.c_font_title = Configs.colorPackLight["font_title"];
                            appColors.c_List_for_task_priority=
                            [
                                Configs.colorPackLight["priorty_unknown"],
                                Configs.colorPackLight["priorty_1"],
                                Configs.colorPackLight["priorty_2"],
                                Configs.colorPackLight["priorty_3"],
                                Configs.colorPackLight["priorty_4"],
                                Configs.colorPackLight["priorty_5"],
                                Configs.colorPackLight["priorty_6"],
                                Configs.colorPackLight["priorty_7"],
                                Configs.colorPackLight["priorty_8"]
                            ];
                        }
                        else
                        {
                            console.log("source: settings.qml -> theme update failed.");
                        }
                    }
                }
            }

        }
        //dark light finish







        }



        Rectangle
        {
            id:baseContent;
            anchors
            {
                top:baseHeaderSettings.bottom;
                left:parent.left;
                right:parent.right;
                bottom:parent.bottom;
            }
            color:"white";
            Column
            {
                anchors.fill: parent;
                Rectangle
                {
                    id:manuallSection;
                    width:parent.width;
                    height: parent.height/5;
                    color:appColors.c_background;


                }
                Rectangle
                {
                    id:apiSection;
                    width:parent.width;
                    height: parent.height/5;
                    color:appColors.c_background;
                    enabled: false;
                    GetAField_Form_with_Title_and_InputText
                    {
                        opacity: 0.5;
                        anchors.centerIn:parent;
                        setLabel: "Enter API Address:";
                        setPlaceHolderInput: "E.g : www.abc.com/directory/api";
                        onGet_entered_valueChanged:
                        {
                            if(get_entered_value == "DELETE ALL LOCAL DATA")
                            {
                                console.log("source : settings.qml -> delete typed, tables removed, init tables.");
                                DBC.deleteDatbaseTables();
                                DBC.initDatabaseTables();
                                goToMain();
                            }
                        }
                    }

                }
                Rectangle
                {
                    id:deleteLocalData
                    width:parent.width;
                    height: parent.height/5;
                    color:appColors.c_background;
                    GetAField_Form_with_Title_and_InputText
                    {
                        anchors.centerIn:parent;
                        setLabel: "To delete all local data type:\nDELETE ALL LOCAL DATA";
                        setPlaceHolderInput: "type DELETE ALL LOCAL DATA to delete local data.";
                        onGet_entered_valueChanged:
                        {
                            if(get_entered_value == "DELETE ALL LOCAL DATA")
                            {
                                console.log("source : settings.qml -> delete typed, tables removed, init tables.");
                                DBC.deleteDatbaseTables();
                                DBC.initDatabaseTables();
                                goToMain();
                            }
                        }
                    }
                }
                Rectangle
                {
                    id:something;
                    width:parent.width;
                    height: parent.height/5;
                    color:appColors.c_background;
                }

            }
        }

    }

}
