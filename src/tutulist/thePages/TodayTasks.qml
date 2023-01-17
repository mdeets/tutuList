import QtQuick 2.15
import "../theComponents/"
import "../theScripts/todaytasks.js" as TodayTasks
import "../theScripts/config.js" as Configs
import "../theScripts/steptasks.js" as StepTaskManager
import "../theScripts/completedtasks.js" as AddToCompletedTasks //just addToCompletedTasks used.


Item
{
    anchors.fill:parent;
//    signal mainQMLpleaseOpenSetupTaskForm;
    signal mainQMLpleaseOpenTheModifyTaskForm(int id, string title, string desc, string timeToPerform, string creationDate, string priority,string deadline);

    ShowTasks
    {
        id:showTodayTasks
        componentType: "todaytasks";
        searchAllowed:true;
        setPageTitle: "Working on";
        addNewTaskAllowed:false; // not works fine, just add task into alltAsks table not todayTasks.
        setIconDelete: ""; //this section dont need delete button right now.
        setIconLeft: appIcons.icon_back;//appIcons.icon_backward;
        setIconRight:appIcons.icon_completeTasks;
        onSearchTextChanged:  function(text)
        {
            console.log("source : todayTasks.qml -> search allowed here. text="+text);
            showTodayTasks.listModelAccessForOutSide.clear();
            TodayTasks.getList(showTodayTasks.listModelAccessForOutSide,"appendToList","searchOn","likeOn",text);
        }

        onButtonRightClicked: function(tId,tsId,tsCompeteDate)
        {
            console.log("source : todayTasks.qml -> right button clicked");
            console.log("source : todayTasks.qml -> complete this task clicked, id="+tId);
            const res = AddToCompletedTasks.completeTask(tId);
            if(res)
            {
                const res_removeTaskFromToday = TodayTasks.removeTaskFromToday(tId);
                if(res_removeTaskFromToday)
                {
                    //                                            completeImage.source = appIcons.icon_uncompleteTasks;
                    console.log("source : todayTasks.qml -> i confirm the task is removed from todaytask and added into completed tasks.");
                    reloadAllTasks();
                }
                else
                    console.log("source : todayTasks.qml -> something went wrong error="+res_removeTaskFromToday);

            }
            else
                console.log("source : todayTasks.qml -> something went wrong error="+res)

        }

        onButtonLeftClicked: function(tId,tsId,tsCompeteDate)
        {
            console.log("source : todayTasks.qml -> left button clicked");
            try
            {
                if(tsId>0)
                {
                    if(tsCompeteDate==="0")
                    {
                        console.log("source : todayTasks.qml -> complete this step task clicked, tasKStepId="+tsId);
                        const queryResult = StepTaskManager.completeStep(tId,tsId);
                        if(queryResult)
                        {
                            console.log("source: todayTasks.qml -> taskStep completed successfully.");
                            reloadAllTasks()
                        }
                        else
                        {
                            console.log("source: todayTasks.qml -> taskStep failed to complete.");
                        }
                    }
                    else
                    {
                        console.log("source : todayTasks.qml -> lets uncomplete this taskStep. tsId="+tsId);
                        const queryResult = StepTaskManager.uncompleteStep(tId,tsId);
                        if(queryResult)
                        {
                            console.log("source: todayTasks.qml -> taskStep uncompleted successfully.");
                            reloadAllTasks();
                        }
                        else
                        {
                            console.log("source: todayTasks.qml -> taskStep failed to uncomplete.");
                        }
                    }
                }
                else
                {
                    console.log("source : todayTasks.qml -> remove this task from today clicekd., id="+tId);
                    const res = TodayTasks.removeTaskFromToday(tId);
                    if(res)
                    {
                        console.log("source : todayTasks.qml -> i confirm the task is removed from todaytasks.");
                        reloadAllTasks();
                    }
                    else
                        console.log("source : todayTasks.qml -> something went wrong error="+res)
                }
            }
            catch(error)
            {
                console.log("source: todayTasks.qml -> error = " + error);
            }
        }
    }
    Connections //make connection with page showTasks.qml and the showTodayTasks. then this will recive by main.qml
    {
        id:connectionWithShowTodayTasks
        ignoreUnknownSignals: true
        target: showTodayTasks;
//        function onOpenTheSetupTaskForm()
//        {
//            console.log("source : TodayTasks.qml -> signal setupTaskForm recived from showTasks.qml");
//            mainQMLpleaseOpenSetupTaskForm();
//        }
        function onOpenTheModifyTaskForm(id,title, desc, timeToPerform, creationDate,priority,deadline)
        {
            console.log("source : TodayTasks.qml -> signal open-modifytaskform recived from showTasks.qml");
            mainQMLpleaseOpenTheModifyTaskForm(id,title,desc,timeToPerform,creationDate,priority,deadline);
        }
    }
}

