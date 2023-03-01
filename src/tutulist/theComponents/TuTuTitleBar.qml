import QtQuick 2.15
import "../theScripts/config.js" as Configs
import QtQuick.Layouts 1.15

Item
{
    width:parent.width;
    height: Configs.topTitleBar_height;
    signal buttonMainMenuClicked;

    Rectangle
    {
        id:local_root;
        anchors.fill:parent;
        color:appColors.c_background;
    }
    Rectangle
    {
        id:baseMenuBarIcon
        height:parent.height
        width:height
        color:"transparent";
        anchors
        {
            leftMargin:10;
            left:parent.left
        }
        Image
        {
            anchors.fill: parent;
            source: appIcons.icon_menubar;
        }
        MouseArea
        {
            anchors.fill: parent;
            onClicked:
            {
                console.log("source : TutuTitleBar.qml -> on menubar clicked");
                buttonMainMenuClicked();
            }
        }
    }
    Text
    {
        function todayDate()
        {
            const tempDate = new Date();
            const daynum = tempDate.getDate();
            switch(tempDate.getMonth())
            {
            case 0: return "January "+daynum;
            case 1: return "February "+daynum;
            case 2: return "March "+daynum;
            case 3: return "April "+daynum;
            case 4: return "May "+daynum;
            case 5: return "June "+daynum;
            case 6: return "July "+daynum;
            case 7: return "August "+daynum;
            case 8: return "September "+daynum;
            case 9: return "October "+daynum;
            case 10:return "November "+daynum;
            case 11:return "December "+daynum;
            default : return -1; //error
            }
        }

        id:orginal_date;
        text:todayDate()
        color:appColors.c_font_title;
        font.pointSize: Configs.font_size_text;
        anchors
        {
            verticalCenter:parent.verticalCenter;
            right:parent.right
            rightMargin:15;
        }


    }

    Text
    {

        //.............. Jalali date ...............

        /**  Gregorian & Jalali (Hijri_Shamsi,Solar) Date Converter Functions
    Author: JDF.SCR.IR =>> Download Full Version :  http://jdf.scr.ir/jdf
    License: GNU/LGPL _ Open Source & Free :: Version: 2.81 : [2020=1399]
    ---------------------------------------------------------------------
    355746=361590-5844 & 361590=(30*33*365)+(30*8) & 5844=(16*365)+(16/4)
    355666=355746-79-1 & 355668=355746-79+1 &  1595=605+990 &  605=621-16
    990=30*33 & 12053=(365*33)+(32/4) & 36524=(365*100)+(100/4)-(100/100)
    1461=(365*4)+(4/4) & 146097=(365*400)+(400/4)-(400/100)+(400/400)  */


        function convertNumberToPersian(num)
        {
            console.log("convertNumber starts");
            var resu="";
            for(var ix=0; ix< num.toString().length; ix++)
            {
                console.log(ix);
                switch(num.toString().slice(ix,ix+1))
                {
                    case "0": resu+= "۰"; break;
                    case "1": resu+= "۱";break;
                    case "2": resu+= "۲";break;
                    case "3": resu+= "۳";break;
                    case "4": resu+= "۴";break;
                    case "5": resu+= "۵";break;
                    case "6": resu+= "۶";break;
                    case "7": resu+= "۷";break;
                    case "8": resu+= "۸";break;
                    case "9": resu+= "۹";break;
                    default: resu+= "?";break;
                }
            }
            return resu;
        }

        function gregorian_to_jalali()
        {
            const ndt=new Date();
            var gy=ndt.getFullYear();
            var gm=ndt.getMonth()+1;
            var gd=ndt.getDate();

            var g_d_m, jy, jm, jd, gy2, days;
            g_d_m = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334];
            gy2 = (gm > 2) ? (gy + 1) : gy;
            days = 355666 + (365 * gy) + ~~((gy2 + 3) / 4) - ~~((gy2 + 99) / 100) + ~~((gy2 + 399) / 400) + gd + g_d_m[gm - 1];
            jy = -1595 + (33 * ~~(days / 12053));
            days %= 12053;
            jy += 4 * ~~(days / 1461);
            days %= 1461;
            if (days > 365) {
                jy += ~~((days - 1) / 365);
                days = (days - 1) % 365;
            }
            if (days < 186) {
                jm = 1 + ~~(days / 31);
                jd = 1 + (days % 31);
            } else {
                jm = 7 + ~~((days - 186) / 30);
                jd = 1 + ((days - 186) % 30);
            }
//            return "j=" + jy+ "/" + jm + "/" + jd;


            jd = convertNumberToPersian(jd);
            switch(jm)
            {
            case 1: return jd + "فروردین ";
            case 2: return jd+"اردیبهشت";
            case 3: return jd+"خرداد ";
            case 4: return jd+"تیر ";
            case 5: return jd+"مرداد ";
            case 6: return jd+"شهریور ";
            case 7: return jd+ "مهر ";
            case 8:return jd + "آبان ";
            case 9:return jd + "آدر ";
            case 10:return jd +"دی " ;
            case 11: return jd + "بهمن ";
            case 12: return jd + "اسفند ";
            default : return jy+ "/" + jm + "/" + jd; //error
            }
        }

        id:jalali_date;
        text:gregorian_to_jalali()//todayDate();
        color:appColors.c_font_title;
        font.pointSize: Configs.font_size_text;
        anchors
        {
            verticalCenter:parent.verticalCenter;
            top:orginal_date.bottom
            right:parent.right
            rightMargin:15;
        }
        horizontalAlignment: Text.AlignRight;

    }

}
