//window setting
const application_width = 720/2+10;
const application_height = 1339/1.7;
const application_title = "TuTu List";
const topTitleBar_height = 40;
const bottomMenu_height = 60;
const pathToIcon = "/theResources/lightMode/"; // light -> dark or etc to change icons theme



//indicator colors
const color_bg_indicator ="#90e0ef";
const color_bg_text = "#90e0ef";
const color_font_text = "black";
const color_bg_button = "transparent";

//theme colors
const color_background = "white";
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
const icon_backward = pathToIcon + "24x24/"+"backward.png"; //https://icons8.com/icons/authors/v03BjHji0KTr/tanah-basah/external-tanah-basah-basic-outline-tanah-basah/external-arrows-pack-tanah-basah-basic-outline-tanah-basah


//alltasks -> add new step
const icon_cancel = pathToIcon+"24x24/"+"cancel.png";

const icon_add = pathToIcon+"24x24/"+"add.png";

/*
//icon back
//https://icons8.com/icon/set/user-interface/ios

   color chumes:
   https://coolors.co/palettes/trending


    user interface idee


  https://dribbble.com/shots/17777364-Productivity-Mobile-App-iOS-Android-UI



  bottom indicator , search box , back button
  https://dribbble.com/shots/19153569-Mobile-App-iOS-Android-UI

  theme colors , back button, top-left open menu, settings page
  https://dribbble.com/shots/16540622-Finance-App-Dark-Theme


  bottom indicator
  https://dribbble.com/shots/17592730-Mental-Health-App

  tags idee for icon_addTasks
  https://dribbble.com/shots/20127375-ToDo-List

  theme colors.
  https://dribbble.com/shots/17795308-Attio-Mobile-Navigation


  calendar style
  https://dribbble.com/shots/18181992-Streak


  task steps style
  https://dribbble.com/shots/15829912-Done-Create-Task

  mini menu to do actions for task
  https://dribbble.com/shots/15726170-Navigation-panel



  search box
  https://dribbble.com/shots/16473464-Task-Management-App


  calendar style
  https://dribbble.com/shots/15829938-Done-Date-Picker




  goals idee
  https://dribbble.com/shots/15794848--Done-Goals


  show stats and categorization idee
  https://dribbble.com/shots/18627890-Task-Management-App-Design


  forms -> text inputs style, check box style, combo style.
  https://dribbble.com/shots/14794406-Task-detail-desktop-app


  show priority status idee/style , task steps style
  https://dribbble.com/shots/15829896-Done-To-Do-List


  background color
  https://dribbble.com/shots/18468605-Task-Management-App



  idee for texts in completed tasks
  https://dribbble.com/shots/19752197-Task-Management-App


  bg color and calender style and chart style
  https://dribbble.com/shots/17339848-Managy-Task-Manager-Dashboard


  purple color, buttons, serch box
  https://dribbble.com/shots/15182650-Dashboard-Mobile-View-Schedule



  show date style
  https://dribbble.com/shots/20159263-Task-and-Project-Management-Mobile-App

  responsive idee
  https://dribbble.com/shots/17259558-Todoist-Material-Design-Award-Winner-2021



  dashboard idee, form idee,
  https://dribbble.com/shots/19923658-Task-list-mobile-app


  login idee
  https://dribbble.com/shots/14425035-Awayday-Travel-App-Daily-UI-Challenge-001-Sign-up-flow

  show notifications
  https://dribbble.com/shots/16891665-Daily-UI-011-Flash-Message



  settings, theme colors
  https://dribbble.com/shots/14630755-Cards-Dark-UI
  https://dribbble.com/shots/14510224-Cards-White-UI
  https://dribbble.com/shots/17873430-Appearance-Settings
  https://dribbble.com/shots/16838613-Dark-Light-UI-for-Cards-Components
  https://dribbble.com/shots/15375254-End-User-Profile-Settings
  https://dribbble.com/shots/11023100-Daily-UI-006-007-Profile-Settings




























  */
