


//window setting
const application_width = 720/2+10;
const application_height = 1339/1.7;
const application_title = "TuTu List";
const application_theme = "light"; //light //dark

//components setting
const topTitleBar_height = 50;
const bottomMenu_height = 50;



//database table names
const table_allTasks = "tutu_allTasks1";
const table_completedTasks = "tutu_completedTasks4";
const table_todayTasks = "tutu_todayTasks3";
const table_taskSteps = "tutu_taskSteps1";
const table_settings = "tutu_settings1";


//icon section
const iconPackMode = application_theme == "dark" ? "darkMode/" : "lightMode/";
const iconSize =
{
    Small: "24x24/",
    Medium: "50x50/",
    Larg: "100x100/"
};
const pathToIcon = "/theResources/"+ iconPackMode;



//color section
const colorPackMode = application_theme == "light" ?
{
    "background":"#F5F8FA",
    "button_background":"#c0dcf7",
    "button_text":"black",
    "button_background_cancel":"#f9b1b1",
    "task_background":"white",
    "stepTask_background":"white",
    "stepTask_text":"black",
    "task_text":"black",
    "input_background":"white",
    "input_text":"black",
    "input_placeholder":"#aaa",
    "bg_indicator":"#90e0ef",
    "font_text":"black",
    "font_title":"black",
    "priorty_unknown":"#90e0ef",
    "priorty_1":"#E42926",
    "priorty_2":"#FFAB25",
    "priorty_3":"#FFFF29",
    "priorty_4":"#31E929",
    "priorty_5":"#33A0FD",
    "priorty_6":"#C632FF",
    "priorty_7":"#fc05b2",
    "priorty_8":"#000000"
}: application_theme == "dark" ?
{
    "background":"#2D2E33",
    "button_background":"#9190F0",
    "button_text":"black",
    "button_background_cancel":"#f9b1b1",
    "task_background":"#3D3C3F",//"#333339",
    "stepTask_background":"#3D3C3F",
    "stepTask_text":"white",
    "task_text":"white",
    "input_background":"#42454D",
    "input_text":"white",
    "input_placeholder":"#aaa",
    "bg_indicator":"#9190F0",
    "font_text":"white",
    "font_title":"white",
    "priorty_unknown":"#9190F0",
    "priorty_1":"#E42926",
    "priorty_2":"#FFAB25",
    "priorty_3":"#FFFF29",
    "priorty_4":"#31E929",
    "priorty_5":"#33A0FD",
    "priorty_6":"#C632FF",
    "priorty_7":"#fc05b2",
    "priorty_8":"#000000"
}:
{
    //here place some code for custom theme colors
}


//font settings
const font_size_title = 20;
const font_size_text = 12; //also used for TextInputs
const font_size_task = 15;
const font_size_stepTask = 10;
const font_size_task_description = 10;
const font_size_stepTask_description = 10;


const defaultValueForContentHeight = 18; //this is for ContentHeight to count how much lines a text has. this number depend on the font of that text.

//theme colors
const color_bg_indicator = colorPackMode["bg_indicator"]//"#90e0ef";
//const color_bg_text = colorPackMode["bg_text"]//"white"; //wants to remove.
const color_font_text = colorPackMode["font_text"]//"black";
const color_font_title = colorPackMode["font_title"]//"black";
const color_background = colorPackMode["background"]//"#F5F8FA";
const color_button_background = colorPackMode["button_background"]//"#c0dcf7"; //light cyan
const color_button_text = colorPackMode["button_text"];//"black";
//const color_button_text_cancel = colorPackMode["button_text_cancel"];//"#AB193C";
const color_button_background_cancel = colorPackMode["button_background_cancel"];//"#f9b1b1";
const color_task_background = colorPackMode["task_background"]//"white";
const color_task_text =colorPackMode["task_text"]//color_button_text;
const color_stepTask_background = colorPackMode["stepTask_background"]//"white";
const color_stepTask_text = colorPackMode["stepTask_text"]//"black";
const color_input_background = colorPackMode["input_background"]//"white";
const color_input_text = colorPackMode["input_text"]//"black";
const color_input_placeholder = colorPackMode["input_placeholder"];
const colorList_for_task_priority =
[
    colorPackMode["priorty_unknown"], //unknown - not prioritized - default value for quickly task creation
    colorPackMode["priorty_1"],//"#E42926",
    colorPackMode["priorty_2"],//"#FFAB25",
    colorPackMode["priorty_3"],//"#FFFF29",
    colorPackMode["priorty_4"],//"#31E929",
    colorPackMode["priorty_5"],//"#33A0FD",
    colorPackMode["priorty_6"],//"#C632FF",
    colorPackMode["priorty_7"],//"#fc05b2",
    colorPackMode["priorty_8"]//"#000000"
];
//const color_unknown = "white"; //ithink didnt used yet


// ICONS
const icon_menubar = pathToIcon+ iconSize.Larg +"menubar.png";//menubar icon https://icons8.com/icons/authors/klDPcgJ2LxJD/febrian-hidayat/external-febrian-hidayat-basic-outline-febrian-hidayat/external-ui-essential-febrian-hidayat-basic-outline-febrian-hidayat
const icon_bottomMenu_allTasks = pathToIcon+ iconSize.Medium +"allTask.png";//(iconPackMode=="darkMode"? pathToIcon+"lightMode"+"50x50/"+"allTask.png": pathToIcon+"darkMode/"+"50x50/"+"allTask.png"); //there is another allTasks.png thats old
const icon_bottomMenu_todayTasks = pathToIcon+ iconSize.Medium +"todayTask.png";
const icon_bottomMenu_completedTasks = pathToIcon+ iconSize.Medium +"completedTask.png";
const icon_back = pathToIcon+ iconSize.Medium +"back.png"; //icon back, setupTask https://icons8.com/icon/set/arrows/ios-filled
const icon_search = pathToIcon+ iconSize.Medium +"search.png";//icon search button https://icons8.com/icon/set/free-icons/ios-filled
const icon_completeTasks = pathToIcon+ iconSize.Medium +"uncheckedTask.png"; //https://icons8.com/icon/set/user-interface/wired\ . completeTask.png
const icon_uncompleteTasks = pathToIcon+ iconSize.Medium +"checkedTask.png";
const icon_addTodayTask = pathToIcon+ iconSize.Medium +"todayTask.png"; //https://icons8.com/icon/set/user-interface/wired
const icon_removeTodayTask = pathToIcon+ iconSize.Medium +"removeTask.png"; //https://icons8.com/icon/set/user-interface/wired
const icon_removeTasks = icon_removeTodayTask;//pathToIcon+"24x24/"+"completedTasks.png"; //https://icons8.com/icon/set/user-interface/wired
const icon_addTasks = pathToIcon+ iconSize.Medium +"emptyList.png"; //to form
const icon_submitTasks = pathToIcon+ iconSize.Medium +"submitQuickTask.png"; //https://icons8.com/icons/authors/v03BjHji0KTr/tanah-basah/external-tanah-basah-basic-outline-tanah-basah/external-arrows-pack-tanah-basah-basic-outline-tanah-basah
const icon_backward = pathToIcon + iconSize.Medium +"backward.png"; //https://icons8.com/icons/authors/v03BjHji0KTr/tanah-basah/external-tanah-basah-basic-outline-tanah-basah/external-arrows-pack-tanah-basah-basic-outline-tanah-basah
const icon_cancel = pathToIcon+ iconSize.Medium +"cancel.png";
const icon_add = pathToIcon+ iconSize.Medium +"add.png";
//const icon_search_colored= pathToIcon+ iconSize.Small +"search-colored.png";


/*

  Used things, Thanks to


  show priority status idee/style , task steps style : https://dribbble.com/shots/15829896-Done-To-Do-List

  button style , text input style from  https://dribbble.com/shots/14794406-Task-detail-desktop-app/attachments/6500905?mode=media

  notifcation from https://dribbble.com/shots/16891665-Daily-UI-011-Flash-Message

  settings from https://dribbble.com/shots/14630755-Cards-Dark-UI

*/




/*
//icon back
//https://icons8.com/icon/set/user-interface/ios


https://cdn.dribbble.com/users/1234247/screenshots/10591656/media/c266bf38b220327fd4165b3ab9d810a9.png
bg color

https://colorffy.com/color-scheme-generator


//action icons https://icons8.com/icon/105072/clipboard
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
