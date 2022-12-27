//window setting
const application_width = 720/2+10;
const application_height = 1339/1.7;
const application_title = "TuTu List";
const topTitleBar_height = 40;
const bottomMenu_height = 60;

const pathToIcon = "/theResources/lightMode/24x24/"; // light -> dark or etc to change icons theme

//theme colors
const color_background = "#dedede";
const color_text = "red";

const color_button_background = "blue";
const color_button_text = "pink";

const color_input_background = "white";
const color_input_text = "black";

const color_unknown = "white";


//database Tables

const table_allTasks = "tutu_allTasks1";
const table_completedTasks = "tutu_completedTasks4";
const table_todayTasks = "tutu_todayTasks3";
const table_taskSteps = "tutu_taskSteps1";
const table_settings = "tutu_settings1";


//menu icons
const icon_bottomMenu_allTasks = pathToIcon+"allTask.png"; //there is another allTasks.png thats old
const icon_bottomMenu_todayTasks = pathToIcon+"todayTask.png";
const icon_bottomMenu_completedTasks = pathToIcon+"completedTask.png";

//action icons https://icons8.com/icon/105072/clipboard
const icon_removeTasks = pathToIcon+"completedTasks.png";
const icon_addTasks = pathToIcon+"completedTasks.png";
const icon_submitTasks = pathToIcon+"completedTasks.png";
const icon_completeTasks = pathToIcon+"completedTasks.png";
const icon_uncompleteTasks = pathToIcon+"completedTasks.png";
const icon_addTodayTask = pathToIcon+"completedTasks.png";
const icon_removeTodayTask = pathToIcon+"completedTasks.png";
