//default values window setting
const application_width = 370  //  720/2+10;
const application_height = 787 //  1339/1.7;
const application_title = "TuTu List";
const application_homePage = 1;


//components setting
const topTitleBar_height = 50;
const bottomMenu_height = 50;
const defaultValueForContentHeight = 18; //this is for ContentHeight to count how much lines a text has. this number depend on the font of that text.


//font settings
const font_size_title = 20;
const font_size_text = 12; //also used for TextInputs
const font_size_task = 15;
const font_size_stepTask = 10;
const font_size_task_description = 10;
const font_size_stepTask_description = 10;




//color section
const colorPackLight =
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
};
const colorPackDark =
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
}


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
