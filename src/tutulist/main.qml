import QtQuick 2.15
//import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import "theScripts/config.js" as ConfigFile
import "theComponents"
import "theScripts/databaseHeader.js" as DBheader
import "theScripts/alltasks.js" as AllTasksJs

import "theScripts/settings.js" as Settings


Window
{

    id:mainWindow;
    width: ConfigFile.application_width;
    height: ConfigFile.application_height;
    visible: true;
    title: qsTr(ConfigFile.application_title);

    signal pageAllTasksPleaseRefreshYourSelf;
    onPageAllTasksPleaseRefreshYourSelf:
    {
        pageLoader.active=false;
//        pageLoader.source = "./thePages/AllTasks.qml";
        pageLoader.active=true;
    }

    //properties

    QtObject
    {
        id:appColors;
        property string c_theme : "light";
        property color c_background : ConfigFile.colorPackLight["background"];
        property color c_button_background : ConfigFile.colorPackLight["button_background"];
        property color c_button_text : ConfigFile.colorPackLight["button_text"];
        property color c_button_background_cancel : ConfigFile.colorPackLight["button_background_cancel"];
        property color c_task_background : ConfigFile.colorPackLight["task_background"];
        property color c_stepTask_background : ConfigFile.colorPackLight["stepTask_background"];
        property color c_stepTask_text : ConfigFile.colorPackLight["stepTask_text"];
        property color c_task_text : ConfigFile.colorPackLight["task_text"];
        property color c_input_background : ConfigFile.colorPackLight["input_background"];
        property color c_input_text : ConfigFile.colorPackLight["input_text"];
        property color c_input_placeholder : ConfigFile.colorPackLight["input_placeholder"];
        property color c_bg_indicator : ConfigFile.colorPackLight["bg_indicator"];
        property color c_font_text : ConfigFile.colorPackLight["font_text"];
        property color c_font_title : ConfigFile.colorPackLight["font_title"];
        property variant c_List_for_task_priority:
        [
            ConfigFile.colorPackLight["priorty_unknown"],
            ConfigFile.colorPackLight["priorty_1"],
            ConfigFile.colorPackLight["priorty_2"],
            ConfigFile.colorPackLight["priorty_3"],
            ConfigFile.colorPackLight["priorty_4"],
            ConfigFile.colorPackLight["priorty_5"],
            ConfigFile.colorPackLight["priorty_6"],
            ConfigFile.colorPackLight["priorty_7"],
            ConfigFile.colorPackLight["priorty_8"]
        ];
    }

    QtObject
    {
        id:appIcons;
        property variant i_sizes: ["24x24/","50x50/","100x100/"];
        property string i_path: "/theResources/" + appColors.c_theme+"Mode/";

        property string icon_menubar: appIcons.i_path + appIcons.i_sizes[2] + "menubar.png";
        property string icon_bottomMenu_allTasks: appIcons.i_path + appIcons.i_sizes[1] + "allTask.png";
        property string icon_bottomMenu_todayTasks: appIcons.i_path + appIcons.i_sizes[1] + "todayTask.png";
        property string icon_bottomMenu_completedTasks: appIcons.i_path + appIcons.i_sizes[1] + "completedTask.png";
        property string icon_back: appIcons.i_path + appIcons.i_sizes[1] + "back.png";
        property string icon_search: appIcons.i_path + appIcons.i_sizes[1] + "search.png";
        property string icon_completeTasks: appIcons.i_path + appIcons.i_sizes[1] + "uncheckedTask.png";
        property string icon_uncompleteTasks: appIcons.i_path + appIcons.i_sizes[1] + "checkedTask.png";
        property string icon_addTodayTask: appIcons.i_path + appIcons.i_sizes[1] + "todayTask.png";
        property string icon_removeTodayTask: appIcons.i_path + appIcons.i_sizes[1] + "removeTask.png";
        property string icon_removeTasks: appIcons.i_path + appIcons.i_sizes[1] + "removeTask.png";
        property string icon_addTasks: appIcons.i_path + appIcons.i_sizes[1] + "emptyList.png";
        property string icon_submitTasks: appIcons.i_path + appIcons.i_sizes[1] + "submitQuickTask.png";
        property string icon_backward: appIcons.i_path + appIcons.i_sizes[1] + "backward.png";
        property string icon_cancel: appIcons.i_path + appIcons.i_sizes[1] + "cancel.png";
        property string icon_add: appIcons.i_path + appIcons.i_sizes[1] + "add.png";
//        property string icon_search_colored: appIcons.i_path + appIcons.i_sizes[1] + "search-colored.png";
    }






    Component.onCompleted:
    {
        console.log("source : main.qml -> Application started successfully.");
        DBheader.initDatabaseTables();
        tutu_bottonMenu.setCurrentPage= ConfigFile.application_homePage;//set as home page.

        //to get settings from database
        const rs_theme = Settings.get("theme");
        if(rs_theme !== "`error") //|| rs_theme!=="undefined")
        {
            if(rs_theme === "dark")
            {
                appColors.c_theme = "dark";
                appColors.c_background = ConfigFile.colorPackDark["background"];
                appColors.c_button_background = ConfigFile.colorPackDark["button_background"];
                appColors.c_button_text = ConfigFile.colorPackDark["button_text"];
                appColors.c_button_background_cancel = ConfigFile.colorPackDark["button_background_cancel"];
                appColors.c_task_background = ConfigFile.colorPackDark["task_background"];
                appColors.c_stepTask_background = ConfigFile.colorPackDark["stepTask_background"];
                appColors.c_stepTask_text = ConfigFile.colorPackDark["stepTask_text"];
                appColors.c_task_text = ConfigFile.colorPackDark["task_text"];
                appColors.c_input_background = ConfigFile.colorPackDark["input_background"];
                appColors.c_input_text = ConfigFile.colorPackDark["input_text"];
                appColors.c_input_placeholder = ConfigFile.colorPackDark["input_placeholder"];
                appColors.c_bg_indicator = ConfigFile.colorPackDark["bg_indicator"];
                appColors.c_font_text = ConfigFile.colorPackDark["font_text"];
                appColors.c_font_title = ConfigFile.colorPackDark["font_title"];
                appColors.c_List_for_task_priority=
                [
                    ConfigFile.colorPackDark["priorty_unknown"],
                    ConfigFile.colorPackDark["priorty_1"],
                    ConfigFile.colorPackDark["priorty_2"],
                    ConfigFile.colorPackDark["priorty_3"],
                    ConfigFile.colorPackDark["priorty_4"],
                    ConfigFile.colorPackDark["priorty_5"],
                    ConfigFile.colorPackDark["priorty_6"],
                    ConfigFile.colorPackDark["priorty_7"],
                    ConfigFile.colorPackDark["priorty_8"]
                ];
            }

            console.log("source: config.js -> success to get setting(theme) values = " + rs_theme);
        }
        else
        {
            console.log("source : config.js -> failed to get setting(theme)..\nWill try to add theme with default value light into settings.");
            if(Settings.set("theme","light"))
            {
                console.log("source: config.js -> succss to insert setting theme with defualt value light.");
            }
            else
            {
                console.log("source: config.js -> failed to insert setting theme with defualt value light.");
            }
        }



        //get last height and width mainWindow
        const rs_appWidth = Settings.get("appWidth");
        if(rs_appWidth !== "`error")
        {
            mainWindow.width=rs_appWidth;
        }
        else
        {
            console.log("source: config.js -> failed to fetch window.w");
        }
        const rs_appHeight = Settings.get("appHeight");
        if(rs_appHeight !== "`error")
        {
            mainWindow.height=rs_appHeight;
        }
        else
        {
            console.log("source: config.js -> failed to fetch window.h");
        }


        //apply settings into application vairables





        /* //check connection with database then init tables.
        const res_testDB = DBheader.testDatabaseConnection();//this table isnt include inside the function DBheader.deleteTables..() so it run even main tables are removed.
        if(res_testDB)
        {
            console.log("source : main.qml -> result databsae connection check = OK , response="+res_testDB);
            DBheader.initDatabaseTables();
            tutu_bottonMenu.setCurrentPage= 1;//set as home page.
        }
        else
            console.log("source : main.qml -> result database connection = failed, response=" + res_testDB);
            */

    }

    onClosing:
    {
        console.log("source : main.qml -> user is trying to close app, mainStackView Dep = "+ mainStackView.depth);
        if(mainStackView.depth===1)
        {
           console.log("source : main.qml -> SAFE EXIT.");

            //save width and height of application into database/settings table;
            if(Settings.set("appWidth",mainWindow.width))
            {
                console.log("source : main.qml -> safe exit -> success to save window.Width");
                if(Settings.set("appHeight",mainWindow.height))
                    console.log("source : main.qml -> safe exit -> success to save window.Height");
            }
            else
                console.log("source : main.qml -> safe exit -> failed to save window.Width or window.Height");
            mainWindow.close();
        }
        else
        {
            mainStackView.pop();
            close.accepted = false;
        }

    }


    Rectangle
    {
        id:root;
        anchors.fill:parent;
        color: appColors.c_background//ConfigFile.color_background;

        MouseArea
        {
            anchors.fill:parent; onClicked:
            {
                console.log("source : main.qml -> on root clicked");
            }
        }

        TuTuTitleBar
        {
            id:tutu_titleBar;
            onButtonMainMenuClicked:
            {
                mainStackView.push("./thePages/settings/Settings.qml");
            }
        }

        Rectangle
        {
            id:centerPageBase;
            anchors
            {
                top: tutu_titleBar.bottom;
                bottom:parent.bottom;
                left:parent.left;
                right:parent.right;
            }
            color:"white";



            Loader
            {
                id:pageLoader;
                visible:  mainStackView.depth===1;
                anchors.fill: parent;
                source: "./thePages/TodayTasks.qml";
                property bool valid: item !== null;
            }

            Connections //make connection with page AllTasks.qml & TodayTasks.qml & CompletedTasks.qml and the PageLoader
            {
                id:connectionWithPageLoader
                ignoreUnknownSignals: true
                target: pageLoader.valid? pageLoader.item : null

                //callable by AllTasks.qml for now.
                function onMainQMLpleaseOpenSetupTaskForm()
                {
                    console.log("source : main.qml -> signal mainQMLpleaseOpenSetupTaskForm recived from AllTasks.qml.");
                    mainStackView.push("./theForms/setupTask.qml");
                }

                //callable by AllTasks.qml or TodayTasks.qml or CompletedTasks.qml for now.
                function onMainQMLpleaseOpenTheModifyTaskForm(id,title, desc, timeToPerform, creationDate,priority,deadline)
                {
                    console.log("source : main.qml -> signal mainQMLpleaseOpenTheModifyTaskForm recived from AllTasks.qml or TodayTasks.qml or CompletedTasks.qml");


                    mainStackView.push(Qt.resolvedUrl("./theForms/modifyTask.qml"),
                                       {
                                           idValue: Qt.binding(function() { return id }),
                                           titleValue: Qt.binding(function() { return title}),
                                           descriptionValue: Qt.binding(function() { return desc}),
                                           timeToPerformValue: Qt.binding(function() { return timeToPerform}),
                                           priorityValue:Qt.binding(function() { return priority}),
                                           deadlineValue:Qt.binding(function() { return deadline}),
                                           creationdateValue:Qt.binding(function() { return creationDate})
                                       })
                }

            }

            //make connection with page setupTask.qml to quit after new task saved successfully.
            //make connection with page settings.qml to quit from that page.
            Connections
            {
                id:connectionWithMainStackView;
                ignoreUnknownSignals: true;
                target: mainStackView.currentItem;
                function onQuitTheSetupTaskFrom()
                {
                    console.log("source : main.qml -> signal quit the setup task recived from setupTask.qml");
                    mainStackView.pop();
                    pageAllTasksPleaseRefreshYourSelf();
                }
                function onQuitFromModifyTaskForm()
                {
                    console.log("source : main.qml -> close-modifytaskform signal recived from modifyTask.qml");
                    mainStackView.pop();
                    pageAllTasksPleaseRefreshYourSelf();
                }
                function onGoToMain()
                {
                    console.log("source : main.qml -> signal goToMain recived from settings.qml");
                    mainStackView.pop();
                }
            }


        }

        StackView
        {
            id:mainStackView;
            visible:mainStackView.depth>1;
            initialItem: "./thePages/LoadingPage.qml";
            anchors.fill:parent;
        }

//        StackView
//        {
//            id:mainStackView;
//            visible:mainStackView.depth>1;
//            initialItem: "./thePages/LoadingPage.qml";
//            anchors.fill:parent;
//        }


        TutuIndicator
        {
            id:tutu_bottonMenu;
            visible:!mainStackView.visible
            anchors
            {
                bottom:parent.bottom;
                bottomMargin:10;
            }

            onHide:
            {
                this.visible=false;
            }
            onShow:
            {
                this.visible=true;
            }

            onAllTasksClicked:
            {
                pageLoader.source = "./thePages/AllTasks.qml";
                console.log("source : main.qml -> bottomMenu-> allTasks Clicked");
            }
            onTodayTasksClicked:
            {
                pageLoader.source = "./thePages/TodayTasks.qml";
                console.log("source : main.qml -> bottomMenu-> todayTasks Clicked");
            }
            onCompletedTasksClicked:
            {
                pageLoader.source = "./thePages/CompletedTasks.qml";
                console.log("source : main.qml -> bottomMenu-> completedTasks Clicked");
            }
        }
    }
}
