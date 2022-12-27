//window setting
const application_width = 720/2+10;
const application_height = 1339/1.7;
const application_title = "TuTu List";
const topTitleBar_height = 40;
const bottomMenu_height = 60;

const pathToIcon = "/theResources/lightMode/"; // light -> dark or etc to change icons theme

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
const icon_bottomMenu_allTasks = pathToIcon+"24x24/"+"allTask.png"; //there is another allTasks.png thats old
const icon_bottomMenu_todayTasks = pathToIcon+"24x24/"+"todayTask.png";
const icon_bottomMenu_completedTasks = pathToIcon+"24x24/"+"completedTask.png";


const icon_completeTasks = pathToIcon+"24x24/"+"uncheckedTask.png"; //https://icons8.com/icon/set/user-interface/wired\ . completeTask.png
const icon_uncompleteTasks = pathToIcon+"24x24/"+"checkedTask.png";

const icon_addTodayTask = pathToIcon+"24x24/"+"todayTask.png"; //https://icons8.com/icon/set/user-interface/wired
const icon_removeTodayTask = pathToIcon+"24x24/"+"removeTask.png"; //https://icons8.com/icon/set/user-interface/wired


//action icons https://icons8.com/icon/105072/clipboard
const icon_removeTasks = icon_removeTodayTask;//pathToIcon+"24x24/"+"completedTasks.png"; //https://icons8.com/icon/set/user-interface/wired
const icon_addTasks = pathToIcon+"24x24/"+"emptyList.png"; //to form
const icon_submitTasks = pathToIcon+"24x24/"+"submitQuickTask.png"; //https://icons8.com/icons/authors/v03BjHji0KTr/tanah-basah/external-tanah-basah-basic-outline-tanah-basah/external-arrows-pack-tanah-basah-basic-outline-tanah-basah
