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
    property string setIconRight : Configs.icon_back//Configs.icon_addTodayTask;
    property string setIconLeft: Configs.icon_completeTasks;
    property string setIconDelete: Configs.icon_removeTasks;
    signal buttonRightClicked(int tId, int tsId, string tsCompeteDate);
    signal buttonLeftClicked(int tId, int tsId, string tsCompeteDate);
    signal searchTextChanged(string text);
    property ListModel listModelAccessForOutSide: listModelMain //to make accses for whos using this component to append something into this listModel

//    signal aTaskCreatedViaQuicklyCreation(int tId);
//    onATaskCreatedViaQuicklyCreation:
//    {
//        console.log("source: showTasks.qml -> "+componentType + ".qml -> signal aTaskCreatedViaQuicklyCreation called.");
//    }

    onSearchTextChanged: function(text)
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
        color:Configs.color_background;

        ListView
        {
            id:listViewMain;
            anchors
            {
                fill:parent;
                topMargin:5;
                bottomMargin: addNewTaskAllowed ? 100:55; //to fix unacceable listView items, whos filled or blocked with bottom indicator and add-quickly-new-task boxes
            }


            clip:true;
            header: Item
            {
                id:searchBar;
                width: searchAllowed? parent.width/1.25: 0;
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
//                            AllTasks.searchTask(searchWord.text,listModelMain,"appendToList",0); //search like on.
                            AllTasks.getList(listModelMain,"appendToList","searchOn","likeOn",searchWord.text)
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
                    color:Configs.color_bg_text;
                    border.color: Configs.color_bg_indicator;
                    radius:10;
                    clip:true;
                    TextInput
                    {
                        id:searchWord;
                        width:parent.width-baseButtonSearchNow.width;//to avoid filling background button with this textinput
                        height:parent.height;
                        color:Configs.color_font_text;
                        font.pointSize: Configs.font_size_text;
                        padding:15;
                        topPadding: 28;
                        maximumLength: 40;
                        onEditingFinished:
                        {
                            doSearch();
                        }
                        onTextChanged:
                        {
                            if(text === "")
                                doSearch();
                        }
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
                    id:baseButtonSearchNow;
                    width:24;
                    height:width;
                    color:"transparent";
                    anchors
                    {
                        right:parent.right;
                        rightMargin:5;
                        verticalCenter: parent.verticalCenter;

                    }
                    Image
                    {
                        anchors.fill: parent;
                        source: Configs.icon_search;//Configs.icon_search_colored;
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
                height: tsId> 0 ? 35: 85;//80 70
                Rectangle
                {

                    anchors.fill: parent;
                    color:"transparent";
                    Rectangle
                    {
                        id:itemmm2;
                        width: tsId > 0 ? parent.width/1.50 : parent.width/1.10;
                        height: tsId > 0 ? parent.height/1.50 : 70; // 50 //tsId >0 means this is task Step. not a task
                        color: tsId > 0 ? Configs.color_stepTask_background :Configs.color_task_background; //tsId >0 means this is task Step. not a task
                        radius:10;
                        anchors.horizontalCenter: parent.horizontalCenter;
                        Rectangle
                        {
                            id:priorityShower;
                            width: tsId > 0 ? 0 : parent.width;
                            height: tsId > 0 ? 0 : 1.50;
                            anchors.top: itemmm2.bottom;
                            color: tPriority>6 || isNaN(tPriority) ? Configs.colorList_for_task_priority[0] : Configs.colorList_for_task_priority[tPriority]
                            radius:parent.radius;
//                            Text
//                            {
//                                text: isNaN(tPriority) ? "?" : tPriority;
//                                color:Configs.color_font_text;
//                                anchors
//                                {
//                                    bottom:parent.bottom;
//                                    bottomMargin:5;
//                                    left:parent.left;
//                                    leftMargin:5;
//                                }
//                            }
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
                                    priorityShower.visible=false;
                                    quicklyAddStep.visible=true;

                                }
                                else
                                    console.log("source: showTasks.qml -> "+ componentType + ".qml  -> on stepTask can not add step task.");
                            }
                        }

                        Text
                        {
                            id:title;
                            text: tsId>0 ? tsTitle : tTitle;
                            color: tsId > 0 ? Configs.color_stepTask_text :Configs.color_task_text;
                            font.pointSize: tsId>0 ? Configs.font_size_stepTask : Configs.font_size_task;
                            width:parent.width/3;
                            clip:true;
                            anchors
                            {
                                verticalCenter:parent.verticalCenter;
                                left:parent.left;
                                leftMargin: tsId > 0 ? 30 : 70;
                            }
                        }
                        Text
                        {
                            id:description;
                            text: tsId>0 ? tsDesc.length>30? tsDesc.slice(0,30)+".." : tsDesc : tDesc.length>30 ? tDesc.slice(0,30)+".." : tDesc
                            color: tsId > 0 ? Configs.color_stepTask_text :Configs.color_task_text;
                            font.pointSize: tsId>0 ? Configs.font_size_stepTask_description : Configs.font_size_task_description;
                            width:parent.width/1.50;
                            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                            clip:true;
                            anchors
                            {
                                left:title.left;
//                                leftMargin: tsId > 0 ? 30 : 70;
                                top:title.bottom;
                            }
                        }

                        Rectangle
                        {
                            id:todayButton; //the component set is known this as RIGHT button;
                            width:tsId>0 ? 0: 30;
                            height:tsId> 0 ? 0 : parent.height;
                            visible: tsId>0? false:true;
//                            anchors.right:parent.right;
                            anchors.left:parent.left;
                            anchors.leftMargin: 35;
                            color:"transparent";
                            Image
                            {
                                width:24;
                                height:24;
                                source: setIconRight;
                                anchors.centerIn: parent;
                                rotation: componentType==="alltasks" ? 180 : 0;//just in all tasks need to rotate icon
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
                            width:30;
                            height:parent.height;
                            anchors.right:todayButton.left;
                            color:"transparent";
                            Image
                            {
                                width:24;
                                height:24;
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
                            width: setIconDelete ==""? 0 :30;
                            height: setIconDelete ==""? 0 :parent.height;
                            visible: setIconDelete ==""? false : true;
//                            width: componentType == "alltasks" ? 45:0;
//                            height: componentType == "alltasks" ? parent.height: 0;
//                            visible: componentType == "alltasks" ? true : false;
                            anchors.right:parent.right;
                            color:"transparent";
                            Image
                            {
                                width:24;
                                height:24;
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
                            anchors.fill:parent;
                            visible:false;
                            setTaskId: tId;
                            setMaxLenght:80;
                            onCancelButtonClicked:
                            {
                                priorityShower.visible=true;
                            }
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
        height:addNewTaskAllowed? 45: 0;
        color:"transparent"//child has color dont need color here.
        radius:10;
        clip:true;
        anchors
        {
            bottom:parent.bottom;
            bottomMargin:65;
            horizontalCenter:parent.horizontalCenter;
        }
        MouseArea
        {
            anchors.fill: parent
        }

        Rectangle
        {
            id:taskTitleBase;
            anchors.fill: parent
            color:Configs.color_bg_text;
            border.color: Configs.color_bg_indicator;
            radius:10;
            TextInput
            {
                id:taskTitle;
                width:parent.width - (button.width-5);  //button.width-5 bc of button has transparent background and to avoid to dont fill the button background with textinput (when language changes into a right to left style some first charecter of text will be under that button.
                height:parent.height;
                color:Configs.color_font_text;
                font.pointSize: Configs.font_size_text;
                padding:14;
                maximumLength: 400; //after this length the wrapper will be bugged and i dont need more charecter right there.
                wrapMode: TextInput.WrapAtWordBoundaryOrAnywhere

                onContentHeightChanged:
                {
                    if(taskTitle.contentHeight>20)//its more than one line, if defualt size box was small or big depens on this. and this depens on font size of textinput, per each line this value will addition with 15 or 18 or something close to that
                    {
                        //linesCount = taskTitle.contentHeight/15
                        addNewQuickTask.height = (12.50*taskTitle.contentHeight/15)+45;//append 12.50px per each line and 45 is defualt value of text.height
                    }
                    else // make base input height to default value
                    {
                        addNewQuickTask.height = 45;
                    }
                }

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
                            //here later add a timer for a sec to load fine and fix the undeinfed tsTitle, tsId, ...
                        }
                    }
                }
            }
            Text
            {
                text: "Add new task";
                color: "#aaa";
                visible: !taskTitle.text;
                padding: 14;
            }
        }

        Rectangle
        {
            id:button;
            color:"transparent"
            width:45;
            height:45;
            radius:parent.radius;
            anchors
            {
                right:parent.right;
                bottom:taskTitleBase.bottom;
            }
            Image
            {
                width:24;
                height:24;
                anchors.centerIn: parent
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
