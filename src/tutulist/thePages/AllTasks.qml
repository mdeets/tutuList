import QtQuick 2.15
import "../theComponents/"

Item
{
    anchors.fill:parent;
    signal mainQMLpleaseOpenSetupTaskForm;
    signal mainQMLpleaseOpenTheModifyTaskForm(int id, string title, string desc, string timeToPerform, string creationDate, string priority,string deadline);

    property string statusQueryDeadlines: "alltasks";
    property string pageTitle: "All Tasks";
    property bool pageSearchStatus:true;
    property int set_addNewTaskBottomMargin:65;
    ShowTasks
    {
        id:showAllTasks;
        componentType: statusQueryDeadlines;
        setPageTitle:pageTitle;
        searchAllowed: pageSearchStatus;
        addNewTaskBottomMargin: set_addNewTaskBottomMargin;
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
    Component.onCompleted:
    {
        console.log("source : AllTasks.qml -> im completed. value QueryForDeadlines = " + statusQueryDeadlines)
    }
}
