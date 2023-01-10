//this componenet is based on the showTasks.qml -> "+ componentType + ".qml  and will use as completed/today Tasks. some features are disabled on thoese.

import QtQuick 2.15
import QtQuick.Controls 2.15
import "../theScripts/alltasks.js" as AllTasks
import "../theScripts/config.js" as Configs
import "../theScripts/completedtasks.js" as CompletedTasks
import "../theScripts/todaytasks.js" as TodayTasks
import "../theComponents"

import "../theScripts/steptasks.js" as StepTaskManager


Item
{


    anchors.fill:parent;

    /* componenet setup starts */
    //this is a flag to enable or disable something in this component
    property string componentType : "alltasks"; //values are  alltasks,todaytasks,completedtasks.
    property bool searchAllowed : true;
    property bool addNewTaskAllowed: true;
    property string setIconRight : Configs.icon_addTodayTask;
    property string setIconLeft: Configs.icon_completeTasks;
    property string setIconDelete: Configs.icon_removeTasks;
    signal buttonRightClicked(int tId, int tsId, string tsCompeteDate);
    signal buttonLeftClicked(int tId, int tsId, string tsCompeteDate);
    signal searchTextChanged(string text);

    onSearchAllowedChanged: function(text)
    {
        console.log("source: showTasks.qml -> "+ componentType + ".qml -> searchTextChanged.");
    }

    onButtonLeftClicked: function(tId,tsId,tsCompeteDate)
    {
        console.log("source : showTasks.qml -> "+ componentType + ".qml  -> button left clicked.");
    }

    onButtonRightClicked: function(tId,tsId,tsCompeteDate)
    {
        console.log("source : showTasks.qml -> "+ componentType + ".qml  -> button right clicked.");
    }


    Component.onCompleted:
    {
        console.log("source : showTasks.qml -> "+ componentType + ".qml  -> im completelly loaded.");
        reloadAllTasks();
    }

    signal reloadAllTasks;
    onReloadAllTasks:
    {
//        console.log("source: showTasks.qml -> "+ componentType + ".qml  -> signal reloadAllTasks -> result Alltasks.getlist() -> " +AllTasks.getList());
        console.log("source : showTasks.qml -> "+ componentType + ".qml  -> signal reloadAllTasks called.");
        listModelMain.clear();

        var resultGet;
        switch(componentType)
        {
            case "completedtasks":
                resultGet = CompletedTasks.getList(listModelMain,"appendToList");
                break;
            case "todaytasks":
                resultGet = TodayTasks.getList(listModelMain,"appendToList");
                break;
            default:
                resultGet = AllTasks.getList(listModelMain,"appendToList");
                break;
        }


    }


    /* end of setup component */



    property int selectedIdToDelete : 0;//used inside this file. didnt set from another.
    property string statusRemoveConfirmMessage : "wait";//used inside this file. didnt set from another.

    property int selectedStepTaskIdToDelete : 0;//this is for remove task step.
    onStatusRemoveConfirmMessageChanged:
    {
        if(statusRemoveConfirmMessage=="confirmed")
        {
            if(selectedStepTaskIdToDelete==0)
            {
                const res = AllTasks.deleteTask(selectedIdToDelete);
                if(res)
                {
                    console.log("source : showTasks.qml -> "+ componentType + ".qml  -> i confirm the task is completely removed.");
                    reloadAllTasks();
                }
                else
                    console.log("source : showTasks.qml -> "+ componentType + ".qml  -> something went wrong while removing the task, error="+res)
            }
            else
            {
                const res = StepTaskManager.deleteStepTask(selectedIdToDelete,selectedStepTaskIdToDelete);
                if(res)
                {
                    console.log("source : showTasks.qml -> "+ componentType + ".qml  -> i confirm the step task is completely removed.");
                    reloadAllTasks();
                }
                else
                    console.log("source : showTasks.qml -> "+ componentType + ".qml  -> something went wrong while removing the step task, error="+res)
            }
            baseConfirmYesOrNo.visible=false;
        }
        if(statusRemoveConfirmMessage=="canceled")
        {
            baseConfirmYesOrNo.visible=false;
        }
    }


    signal openTheSetupTaskForm;
    signal openTheModifyTaskForm(int id, string title, string desc, string timeToPerform, string creationDate, string priority,string deadline);

    onOpenTheSetupTaskForm:
    {
        console.log("source : showTasks.qml -> "+ componentType + ".qml  -> signal openTheSetupTaskForm called.")
    }

    onOpenTheModifyTaskForm:
    {
        console.log("source : showTasks.qml -> "+ componentType + ".qml  -> signal openTheModifyTaskForm called.");
    }






    Rectangle
    {
        id:theListBase;
        anchors.fill:parent;
//        anchors
//        {
//            left:parent.left;
//            right:parent.right;
//            top:parent.top;
////            bottom:addNewQuickTask.top;
//            bottom:parent.bottom
//        }
        color:"transparent";

        ListView
        {
            id:listViewMain;
            anchors.fill:parent;
//            anchors.topMargin:35;
            clip:true;
            header: Item
            {
                id:searchBar;
                width: searchAllowed? parent.width/1.50: 0;
                height: searchAllowed? 60 : 10;
                anchors.horizontalCenter:parent.horizontalCenter
                visible:searchAllowed
                function doSearch()
                {
                    if(componentType == "alltasks")
                    {
                        //run search query
                        if(searchWord.text!=="")
                        {
                            listModelMain.clear();
//                                AllTasks.searchTask(searchWord.text,listModelMain,"appendToList"); //search like off.
                            AllTasks.searchTask(searchWord.text,listModelMain,"appendToList",0); //search like on.
                        }
                        else
                        {
                            reloadAllTasks();
                        }
                    }
                    else
                    {
                        searchTextChanged(searchWord.text);
                    }
                }
                //search input;
                Rectangle
                {
                    width:parent.width;
                    height:parent.height/1.5;
                    anchors.verticalCenter: parent.verticalCenter;
                    color:"white";
                    border.color: Configs.color_bg_indicator;
                    radius:10;
                    clip:true;
//                    TextField
                    TextInput
                    {
                        id:searchWord;
                        anchors.fill:parent;
                        color:Configs.color_font_text;
                        font.pointSize: Configs.font_size_text;
                        padding:15;
                        topPadding: 28;
                        maximumLength: 40;
                        onEditingFinished:
                        {
                            doSearch();
                        }
//                        onTextChanged:
//                        {
//                            if(text === "")
//                                reloadAllTasks()
//                        }
                    }
                    Text
                    {
                        text: "Search task";
                        color: "#aaa"
                        visible: !searchWord.text
                        anchors
                        {
                            verticalCenter: parent.verticalCenter;
                            left:parent.left;
                            leftMargin:15;
                        }
                    }
                }
                Rectangle
                {
//                    id:baseButtonSearchNow;
                    width:24;
                    height:width;
                    color:"white";
                    anchors
                    {
                        right:parent.right;
                        rightMargin:5;
                        verticalCenter: parent.verticalCenter;

                    }
                    Image
                    {
                        anchors.fill: parent;
                        source: Configs.icon_search_colored;
                    }
                    MouseArea
                    {
                        anchors.fill: parent;
                        onClicked:
                        {
                            doSearch();
                        }
                    }

                }
            }
            model:
            ListModel
            {
                id:listModelMain;

            }
            delegate:
            Item
            {
                width: listViewMain.width;
                height: tsId> 0 ? 35:70;
                Rectangle
                {
                    anchors.fill: parent;

                    color:"transparent";
                    Rectangle
                    {
                        id:itemmm2;
                        width: tsId > 0 ? parent.width/1.50 : parent.width/1.10;
                        height: tsId > 0 ? parent.height/1.50 : 50; //tsId >0 means this is task Step. not a task
                        color: tsId > 0 ? "gray" : "gray"; //tsId >0 means this is task Step. not a task
                        radius:15;
                        anchors.horizontalCenter: parent.horizontalCenter;
                        Rectangle
                        {
//                            id:priorityShower;
                            width: tsId > 0 ? 0 : 5;
                            height: tsId > 0 ? 0 : parent.height;
                            color: tPriority <= 7 ? "red" : tPriority <= 14 ? "orange": tPriority > 21 ? "green": "black";
                            radius:parent.radius;
                        }


                        MouseArea
                        {
                            anchors.fill:parent;
                            onPressAndHold:
                            {
                                console.log("source : showTasks.qml -> "+ componentType + ".qml  ->  on task press and hold, details are: id="+tId + " title="+tTitle + "desc="+tDesc + " timetoperform="+tTimerToPerForm+ " deadlione"+tDeadline + " creation="+tCreation + " priority="+tPriority);
                                if(tId>0 && tsId===0)
                                    openTheModifyTaskForm(tId,tTitle,tDesc,tTimerToPerForm,tCreation,tPriority,tDeadline);
                                else
                                    console.log("soruce : showTasks.qml -> "+ componentType + ".qml  -> this is not task, wait for new updates to be able modify stepTasks. task Step Id="+tsId);
                            }
                            onClicked:
                            {
                                if(tsId === 0)
                                {
                                    console.log("source: showTasks.qml -> "+ componentType + ".qml  -> on task clicked, lets add new step to this task");
                                    quicklyAddStep.visible=true;
                                }
                                else
                                    console.log("source: showTasks.qml -> "+ componentType + ".qml  -> on stepTask can not add step task.");
                            }
                        }

                        Text
                        {
                            text: tsId>0 ? tsTitle : tTitle;
                            color: tsId > 0 ? "black":"white";
                            font.pointSize: tsId>0 ? 10 : 18;
                            width:parent.width/3;
                            clip:true;
                            anchors
                            {
                                verticalCenter:parent.verticalCenter;
                                left:parent.left;
                                leftMargin: 30;
                            }

                        }
                        Rectangle
                        {
                            id:todayButton; //the component set is known this as RIGHT button;
                            width:tsId>0 ? 0: 45;
                            height:tsId> 0 ? 0 : parent.height;
                            visible: tsId>0? false:true;
                            anchors.right:parent.right;
                            color:"transparent";
                            Image
                            {
                                source: setIconRight;
                                anchors.centerIn: parent;
                            }

                            MouseArea
                            {
                                anchors.fill:parent;
                                onClicked:
                                {

                                    if(componentType == "alltasks")
                                    {
                                        console.log("source : showTasks.qml -> "+ componentType + ".qml  -> add to today this task clicked, id="+tId);
                                        const res = TodayTasks.addTaskToToday(tId);
                                        if(res)
                                        {
                                            console.log("source : showTasks.qml -> "+ componentType + " -> i confirm the task is completely adde to today task.");
                                            reloadAllTasks();
                                        }
                                        else
                                            console.log("source : showTasks.qml -> "+ componentType + ".qml  -> something went wrong error="+res)
                                    }
                                    else
                                    {
                                        buttonRightClicked(tId,tsId,tsCompeteDate);
                                    }

                                }
                            }
                        }

                        Rectangle
                        {
                            id:completeButton; //the component set is known this as LEFT button;
                            width:45;
                            height:parent.height;
                            anchors.right:todayButton.left;
                            color:"transparent";
                            Image
                            {
                                source: tsId>0 ? tsCompeteDate==="0" ? Configs.icon_completeTasks : Configs.icon_uncompleteTasks : setIconLeft;
                                anchors.centerIn: parent;
                            }

                            MouseArea
                            {
                                anchors.fill:parent;
                                onClicked:
                                {
                                    if(componentType == "alltasks")
                                    {
                                        if(tsId>0)
                                        {
                                            if(tsCompeteDate==="0")
                                            {
                                                console.log("source : showTasks.qml -> "+ componentType + ".qml  -> complete this step task clicked, tasKStepId="+tsId+ " tId="+tId);
                                                const queryResult = StepTaskManager.completeStep(tId,tsId);
                                                if(queryResult)
                                                {
                                                    console.log("source: showTasks.qml -> "+ componentType + ".qml  -> taskStep completed successfully.");
                                                    reloadAllTasks();
                                                }
                                                else
                                                {
                                                    console.log("source: showTasks.qml -> "+ componentType + ".qml  -> taskStep failed to complete.");
                                                }
                                            }
                                            else
                                            {
                                                console.log("source : showTasks.qml -> "+ componentType + ".qml  -> lets uncomplete this taskStep. tsId="+tsId);
                                                const queryResult = StepTaskManager.uncompleteStep(tId,tsId);
                                                if(queryResult)
                                                {
                                                    console.log("source: showTasks.qml -> "+ componentType + ".qml  -> taskStep uncompleted successfully.");
                                                    reloadAllTasks();
                                                }
                                                else
                                                {
                                                    console.log("source: showTasks.qml -> "+ componentType + ".qml  -> taskStep failed to uncomplete.");
                                                }
                                            }


                                        }
                                        else
                                        {
                                            console.log("source : showTasks.qml -> "+ componentType + ".qml  -> complete this task clicked, id="+tId);
                                            const res = CompletedTasks.completeTask(tId);
                                            if(res)
                                            {
                                                console.log("source : showTasks.qml -> "+ componentType + ".qml  -> i confirm the task is completely completed.");
                                                reloadAllTasks();
                                            }
                                            else
                                                console.log("source : showTasks.qml -> "+ componentType + ".qml  -> something went wrong error="+res)
                                        }
                                    }//end of component == alltasks

                                    else
                                    {
                                        buttonLeftClicked(tId,tsId,tsCompeteDate);
                                    }
                                }
                            }
                        }


                        Rectangle
                        {
                            id:removeButton; //the component seter is setIconDelete and by default is visible.
                            width: setIconDelete ==""? 0 :45;
                            height: setIconDelete ==""? 0 :parent.height;
                            visible: setIconDelete ==""? false : true;
//                            width: componentType == "alltasks" ? 45:0;
//                            height: componentType == "alltasks" ? parent.height: 0;
//                            visible: componentType == "alltasks" ? true : false;
                            anchors.right:completeButton.left;
                            color:"transparent";
                            Image
                            {
                                source: setIconDelete;
                                anchors.centerIn: parent;
                            }

                            MouseArea
                            {
                                anchors.fill:parent;
                                onClicked:
                                {
                                    baseConfirmYesOrNo.visible=true;
                                    if(tsId>0)
                                    {
                                        console.log("source: showTasks.qml -> "+ componentType + ".qml  -> remove step task clicked. tsid="+tsId + " tid="+tId);
                                        confirmMessage.textMessage = "are you sure to delete step task ("+tsTitle+") ?";
                                        selectedStepTaskIdToDelete=tsId;
                                        selectedIdToDelete=tId;
                                    }
                                    else
                                    {
                                        console.log("source : showTasks.qml -> "+ componentType + ".qml  -> remove task clicekd, id="+tId);
                                        confirmMessage.textMessage = "are you sure to delete task ("+tTitle+") ?";
                                        selectedStepTaskIdToDelete=0; //to tell the confirm delete this is just task so remove this tId from Task Table.
                                        selectedIdToDelete=tId;
                                    }
                                    confirmMessage.response="wait";


                                }

                            }
                        }

                        QuicklySetupTaskStep
                        {
                            id:quicklyAddStep;
                            visible:false;
                            setTaskId: tId;
                        }




                    }


                }

            }//end of item delegate

        }//end of list view


    }

    Rectangle
    {
        id:addNewQuickTask;
        width:addNewTaskAllowed? parent.width/1.25: 0;
        height:addNewTaskAllowed? 45 : 0;
        visible: addNewTaskAllowed;
        color:Configs.color_bg_text;
        radius:100;
        clip:true;
        anchors
        {
            bottom:parent.bottom;
            bottomMargin:90;
            horizontalCenter:parent.horizontalCenter;
        }


        Rectangle
        {
            id:taskTitleBase;
            width:parent.width-40;
            height:parent.height;
            radius:parent.radius;
            color:"transparent";

//            TextField
            TextInput
            {
                id:taskTitle;
                anchors.fill: parent;
                padding: 15;
                font.pointSize: Configs.font_size_text;
                topPadding: 30;
                wrapMode: "WrapAnywhere"
                maximumLength: 25;
                color:Configs.color_font_text;
                onEditingFinished:
                {
                    if(text!=="")
                    {
                        const res=  AllTasks.addQuicklyNewTask(taskTitle.text);
                        if(res)
                        {
                            console.log("source : showTasks.qml -> "+ componentType + ".qml  -> response is ok query submitted as QuickTask.");
                            taskTitle.clear();
                            reloadAllTasks();
                        }
                    }
                }
            }
        }


        Rectangle
        {
            id:button;
            color:Configs.color_bg_button;
            width:40;
            height:parent.height;
            radius:parent.radius;
            anchors.left:taskTitleBase.right;
            Image
            {
                anchors.centerIn:parent;
                source: taskTitle.length>0 ? Configs.icon_submitTasks : Configs.icon_add;
            }

            MouseArea
            {
                anchors.fill:parent;
                onClicked:
                {
                    console.log("source : showTasks.qml -> "+ componentType + ".qml  -> on submit new task button clicked.");
                    if(taskTitle.text==="")
                    {
                        console.log("source: showTasks.qml -> "+ componentType + ".qml  -> add new task via setup and form.");
                        openTheSetupTaskForm();
                    }
                    else
                    {
                        const res=  AllTasks.addQuicklyNewTask(taskTitle.text);
                        if(res)
                        {
                            console.log("source : showTasks.qml -> "+ componentType + ".qml  -> response is ok query submitted as QuickTask.");
                            taskTitle.clear();
                            reloadAllTasks();
                        }
                    }
                }
            }
        }

    }



    Rectangle
    {
        id:baseConfirmYesOrNo;
        anchors.fill: parent;
        color:"black";
        opacity: 0.6;
        visible: false;

        MouseArea
        {
            anchors.fill: parent;
            onClicked:
            {
                confirmMessage.response="canceled";
            }
        }
        ConfirmYesOrNo
        {
            id:confirmMessage;
            onResponseChanged:
            {
                statusRemoveConfirmMessage=response;
            }
        }
    }



}
