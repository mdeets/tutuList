import QtQuick 2.15
import "../theComponents/"

Item
{
    anchors.fill:parent;
    signal mainQMLpleaseOpenSetupTaskForm;
    signal mainQMLpleaseOpenTheModifyTaskForm(int id, string title, string desc, string timeToPerform, string creationDate, string priority,string deadline);

    ShowTasks
    {
        id:showAllTasks;
        setPageTitle:"All Tasks";
    }
    Connections //make connection with page showTasks.qml and the ShowAllTasks. then this will recive by main.qml
    {
        id:connectionWithShowAllTasks
        ignoreUnknownSignals: true
        target: showAllTasks;
        function onOpenTheSetupTaskForm()
        {
            console.log("source : AllTasks.qml -> signal setupTaskForm recived from showTasks.qml");
            mainQMLpleaseOpenSetupTaskForm();
        }
        function onOpenTheModifyTaskForm(id,title, desc, timeToPerform, creationDate,priority,deadline)
        {
            console.log("source : AllTasks.qml -> signal open-modifytaskform recived from showTasks.qml");
            mainQMLpleaseOpenTheModifyTaskForm(id,title,desc,timeToPerform,creationDate,priority,deadline);
        }

    }
}
