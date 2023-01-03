function translateMonthInputs(m) //m means month
{
    if(isNaN(m))
    {
        m = m.toLowerCase();
        switch(m)
        {
            case "january": return  1;
            case "february" : return  2;
            case "march" : return  3;
            case "april" : return  4;
            case "may" : return  5;
            case "june" : return  6;
            case "july" : return  7;
            case "august" : return  8;
            case "september" : return  9;
            case "october" : return  10;
            case "november" : return  11;
            case "december" : return  12;
            default : return -1; //error
        }
    }
    else
        return m;//means input month is not a string
}




function leapYear_monthDays(year)
{
    year = parseInt(year); //for make sure its int
    return ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0);
}
function monthDays(year,month)
{
    if(!isNaN(month))
    {
        month = parseInt(month);
        if(month===2)
        {
            if(leapYear_monthDays(year))
                return 29;
            else
                return 28;
        }
        else
        {
            switch(month)
            {
                case 1:
                case 3:
                case 5:
                case 7:
                case 8:
                case 10:
                case 12:
                    return 31;
                default:
                    return 30;
            }
        }
    }
    else
    {
        month = translateMonthInputs(month);
        if(month>0)
            monthDays(year,month);
        else
            return -1;//means error
    }
    return -1;//means error
}







/*showMode is another function condintion (by default disabled)for
            make space after the value ONLY FOR SHOW INTHE
            TEXTS TO AVOID ERROR Unable to assign [undefined] to QString*/

// return me space days with fill '0' untill month day started of week and insert other days (maxday)
// e.g : (2022,'january') or (2022,1)
// result must be like : [0,0,0,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15, ... , 31]
// result note: zero means this month dont start at this cell/dayweek/e.g(sat.mon,..)
function automaticMonth(year,month,showMode=0)
{
    var result = [];

    var makeSpaceForValues = weekdayFromDate(year,month,'nontext');  // auto filled day = 1
    if(makeSpaceForValues>-1)
    {
        makeSpaceForValues--;
        if(makeSpaceForValues>=0)
            for(var i=0;i<=makeSpaceForValues;i++)
                result[i] = '0';   //now day space added into result , it was 0 but changed to empty string
    }
    else
        return 100; //error on dayOfWeek result


   var maxDay = monthDays(year,month);
    if(maxDay<0)
        return 101; //error fail on calculate month max day
    else
        for(var j=1; j<= maxDay; j++)
            result.push(j);

    if(showMode)
    {
        for(var a=1; a<= maxDay*2; a++)
            result.push('0');
    }

    return result;
}




//day picker section
function calculateColumns_of_MonthDays(arrayLen)
{

    /*
      how style 7 day in a row

      TITLES are :
      //NOTE start '*' means anyday (28 29 30 31)
      (spaced/nulled) (table columns) -> (max day of month)    (max days + spaced days)

            0                4        -> 28                     (28)

            0                5        -> 29 30 31               (29 , 30 , 31)
            1                5        -> *                      (29 to 32)
            2                5        -> *                      (30 to 33)
            3                5        -> *                      (31 to 34)
            4                5        -> *                      (32 to 35)
            5                5        -> 28 29 30               (33 , 34 , 35)
            6                5        -> 28 29                  (34 , 35)


            5                6        -> 31                     (36)
            6                6        -> 30 31                  (36 , 37)

            x<29 -> 4 column
            x>=29 && x<=35 -> 5 column
            x>=36 or else -> 6 column
      */


    if(arrayLen<29)
        return 4;
    else if(arrayLen >= 29 && arrayLen <= 35)
        return 5;
    else
        return 6;
}




//--------------------------------------------------------------------------------------------------

//from https://ideone.com/aDwLCM
function leapYear_weekdayFromDate(y,m)
{
    if(m<=2)
        y--;
    return ((y/4)-(y/100)+(y/400));
}

//from https://ideone.com/aDwLCM
function weekdayFromDate(y,m,outputType,d=1) //outputType == 'text' -> e.g sunday.  outputType == '' or any -> number (nontext)
{
    var dayy=[];
    if(outputType === "text")
        dayy = ["Saturday","Sunday","Monday","Tuesday","Wednesday","Thursday","Friday"];
    else
        dayy = [5,6,0,1,2,3,4];



    var mnDays =[0 ,31, 28, 31, 30, 31, 30,31, 31, 30, 31, 30, 31];
    var totaldays = (y*365)+d;
    for(var ki=1; ki<m; ki++)
        totaldays+=mnDays[ki];
    totaldays+=leapYear_weekdayFromDate(y,m);
    var remm = Math.round(totaldays%7);
    if(remm == 7)
        remm--;

    return dayy[remm];
}








function resetAllSelectedElements(elem)
{
    elem.setAPicked = false;
    elem.setBPicked = false;
    elem.setCPicked = false;
    elem.setDPicked = false;
    elem.setEPicked = false;
    elem.setFPicked = false;
    elem.setGPicked = false;
    elem.outputPickedDays = [];
}

function removeFromArray(value,arra)
{
    const index = arra.indexOf(value);
    if (index > -1)
         arra.splice(index, 1); // 2nd parameter means remove one item only
    return arra;
}


//from https://stackoverflow.com/questions/9229645/remove-duplicate-values-from-js-array
function uniqBy(a, key)  //key is defaulted from code by 'JSON.stringify'
{
    var seen = {};
    return a.filter(function(item)
    {
        var k = key(item);
        return seen.hasOwnProperty(k) ? false : (seen[k] = true);
    })
}

function pickedDays(listOfDays,week) //w means week
{
    listOfDays.forEach((element) =>
                       {
                           for(var ilocal=0; ilocal<=6; ilocal++)
                           {
                               if(parseInt(week.textAPick)===element)
                               {
                                   week.outputPickedDays.push(week.textAPick);
                                   week.setAPicked=true;
                               }
                               if(parseInt(week.textBPick)===element)
                               {
                                   week.outputPickedDays.push(week.textBPick);
                                   week.setBPicked=true;
                               }
                               if(parseInt(week.textCPick)===element)
                               {
                                   week.outputPickedDays.push(week.textCPick);
                                   week.setCPicked=true;
                               }
                               if(parseInt(week.textDPick)===element)
                               {
                                   week.outputPickedDays.push(week.textDPick);
                                   week.setDPicked=true;
                               }
                               if(parseInt(week.textEPick)===element)
                               {
                                   week.outputPickedDays.push(week.textEPick);
                                   week.setEPicked=true;
                               }
                               if(parseInt(week.textFPick)===element)
                               {
                                   week.outputPickedDays.push(week.textFPick);
                                   week.setFPicked=true;
                               }
                               if(parseInt(week.textGPick)===element)
                               {
                                   week.outputPickedDays.push(week.textGPick);
                                   week.setGPicked=true;
                               }
                           }
                           week.outputPickedDays = uniqBy(week.outputPickedDays,JSON.stringify); //JSON.stringify is default ... means nothing for me :|

                       })
}

function pickWeek(weekDay,status,week1,week2,week3,week4,week5,week6)
{
    weekDay = weekDay.toLowerCase();
    switch(weekDay)
    {
        case "monday":
        {
            if(status)
            {
                week1.setAPicked = status;
                week2.setAPicked = status;
                week3.setAPicked = status;
                week4.setAPicked = status;
                week5.setAPicked = status;
                week6.setAPicked = status;
                if(week1.textAPick!==0)
                    week1.outputPickedDays.push(week1.textAPick);

                if(week2.textAPick!==0)
                    week2.outputPickedDays.push(week2.textAPick);

                if(week3.textAPick!==0)
                    week3.outputPickedDays.push(week3.textAPick);

                if(week4.textAPick!==0)
                    week4.outputPickedDays.push(week4.textAPick);

                if(week5.textAPick!==0)
                    week5.outputPickedDays.push(week5.textAPick);

                if(week6.textAPick!==0)
                    week6.outputPickedDays.push(week6.textAPick);
            }
            else
            {
                week1.setAPicked = status;
                week2.setAPicked = status;
                week3.setAPicked = status;
                week4.setAPicked = status;
                week5.setAPicked = status;
                week6.setAPicked = status;
                if(week1.setAPicked!==0)
                    week1.outputPickedDays = removeFromArray(week1.textAPick,week1.outputPickedDays);

                if(week2.textAPick!==0)
                    week2.outputPickedDays = removeFromArray(week2.textAPick,week2.outputPickedDays);

                if(week3.textAPick!==0)
                    week3.outputPickedDays = removeFromArray(week3.textAPick,week3.outputPickedDays);

                if(week4.textAPick!==0)
                    week4.outputPickedDays = removeFromArray(week4.textAPick,week4.outputPickedDays);

                if(week5.textAPick!==0)
                    week5.outputPickedDays = removeFromArray(week5.textAPick,week5.outputPickedDays);

                if(week6.textAPick!==0)
                    week6.outputPickedDays = removeFromArray(week6.textAPick,week6.outputPickedDays);
            }

        }break;
        case "tuesday":
        {//b
            if(status)
            {
                week1.setBPicked = status;
                week2.setBPicked = status;
                week3.setBPicked = status;
                week4.setBPicked = status;
                week5.setBPicked = status;
                week6.setBPicked = status;
                if(week1.textBPick!==0)
                    week1.outputPickedDays.push(week1.textBPick);

                if(week2.textBPick!==0)
                    week2.outputPickedDays.push(week2.textBPick);

                if(week3.textBPick!==0)
                    week3.outputPickedDays.push(week3.textBPick);

                if(week4.textBPick!==0)
                    week4.outputPickedDays.push(week4.textBPick);

                if(week5.textBPick!==0)
                    week5.outputPickedDays.push(week5.textBPick);

                if(week6.textBPick!==0)
                    week6.outputPickedDays.push(week6.textBPick);
            }
            else
            {
                week1.setBPicked = status;
                week2.setBPicked = status;
                week3.setBPicked = status;
                week4.setBPicked = status;
                week5.setBPicked = status;
                week6.setBPicked = status;
                if(week1.textBPick!==0)
                    week1.outputPickedDays = removeFromArray(week1.textBPick,week1.outputPickedDays);

                if(week2.textBPick!==0)
                    week2.outputPickedDays = removeFromArray(week2.textBPick,week2.outputPickedDays);

                if(week3.textBPick!==0)
                    week3.outputPickedDays = removeFromArray(week3.textBPick,week3.outputPickedDays);

                if(week4.textBPick!==0)
                    week4.outputPickedDays = removeFromArray(week4.textBPick,week4.outputPickedDays);

                if(week5.textBPick!==0)
                    week5.outputPickedDays = removeFromArray(week5.textBPick,week5.outputPickedDays);

                if(week6.textBPick!==0)
                    week6.outputPickedDays = removeFromArray(week6.textBPick,week6.outputPickedDays);
            }


        }break;

        case "wednesday":
        {//c
            if(status)
            {

                week1.setCPicked = status;
                week2.setCPicked = status;
                week3.setCPicked = status;
                week4.setCPicked = status;
                week5.setCPicked = status;
                week6.setCPicked = status;
                if(week1.textCPick!==0)
                    week1.outputPickedDays.push(week1.textCPick);

                if(week2.textCPick!==0)
                    week2.outputPickedDays.push(week2.textCPick);

                if(week3.textCPick!==0)
                    week3.outputPickedDays.push(week3.textCPick);

                if(week4.textCPick!==0)
                    week4.outputPickedDays.push(week4.textCPick);

                if(week5.textCPick!==0)
                    week5.outputPickedDays.push(week5.textCPick);

                if(week6.textCPick!==0)
                    week6.outputPickedDays.push(week6.textCPick);

            }
            else
            {
                week1.setCPicked = status;
                week2.setCPicked = status;
                week3.setCPicked = status;
                week4.setCPicked = status;
                week5.setCPicked = status;
                week6.setCPicked = status;
                if(week1.textCPick!==0)
                    week1.outputPickedDays = removeFromArray(week1.textCPick,week1.outputPickedDays);

                if(week2.textCPick!==0)
                    week2.outputPickedDays = removeFromArray(week2.textCPick,week2.outputPickedDays);

                if(week3.textCPick!==0)
                    week3.outputPickedDays = removeFromArray(week3.textCPick,week3.outputPickedDays);

                if(week4.textCPick!==0)
                    week4.outputPickedDays = removeFromArray(week4.textCPick,week4.outputPickedDays);

                if(week5.textCPick!==0)
                    week5.outputPickedDays = removeFromArray(week5.textCPick,week5.outputPickedDays);

                if(week6.textCPick!==0)
                    week6.outputPickedDays = removeFromArray(week6.textCPick,week6.outputPickedDays);
            }

        }break;

        case "thursday":
        {//d
            if(status)
            {
                week1.setDPicked = status;
                week2.setDPicked = status;
                week3.setDPicked = status;
                week4.setDPicked = status;
                week5.setDPicked = status;
                week6.setDPicked = status;
                if(week1.textDPick!==0)
                    week1.outputPickedDays.push(week1.textDPick);

                if(week2.textDPick!==0)
                    week2.outputPickedDays.push(week2.textDPick);

                if(week3.textDPick!==0)
                    week3.outputPickedDays.push(week3.textDPick);

                if(week4.textDPick!==0)
                    week4.outputPickedDays.push(week4.textDPick);

                if(week5.textDPick!==0)
                    week5.outputPickedDays.push(week5.textDPick);

                if(week6.textDPick!==0)
                    week6.outputPickedDays.push(week6.textDPick);

            }


            else
            {
                week1.setDPicked = status;
                week2.setDPicked = status;
                week3.setDPicked = status;
                week4.setDPicked = status;
                week5.setDPicked = status;
                week6.setDPicked = status;
                if(week1.textDPick!==0)
                    week1.outputPickedDays = removeFromArray(week1.textDPick,week1.outputPickedDays);

                if(week2.textDPick!==0)
                    week2.outputPickedDays = removeFromArray(week2.textDPick,week2.outputPickedDays);

                if(week3.textDPick!==0)
                    week3.outputPickedDays = removeFromArray(week3.textDPick,week3.outputPickedDays);

                if(week4.textDPick!==0)
                    week4.outputPickedDays = removeFromArray(week4.textDPick,week4.outputPickedDays);

                if(week5.textDPick!==0)
                    week5.outputPickedDays = removeFromArray(week5.textDPick,week5.outputPickedDays);

                if(week6.textDPick!==0)
                    week6.outputPickedDays = removeFromArray(week6.textDPick,week6.outputPickedDays);
            }

        }break;

        case "friday":
        {//e
            if(status)
            {
                week1.setEPicked = status;
                week2.setEPicked = status;
                week3.setEPicked = status;
                week4.setEPicked = status;
                week5.setEPicked = status;
                week6.setEPicked = status;
                if(week1.textEPick!==0)
                    week1.outputPickedDays.push(week1.textEPick);

                if(week2.textEPick!==0)
                    week2.outputPickedDays.push(week2.textEPick);

                if(week3.textEPick!==0)
                    week3.outputPickedDays.push(week3.textEPick);

                if(week4.textEPick!==0)
                    week4.outputPickedDays.push(week4.textEPick);

                if(week5.textEPick!==0)
                    week5.outputPickedDays.push(week5.textEPick);

                if(week6.textEPick!==0)
                    week6.outputPickedDays.push(week6.textEPick);

            }
            else
            {
                week1.setEPicked = status;
                week2.setEPicked = status;
                week3.setEPicked = status;
                week4.setEPicked = status;
                week5.setEPicked = status;
                week6.setEPicked = status;
                if(week1.textEPick!==0)
                    week1.outputPickedDays = removeFromArray(week1.textEPick,week1.outputPickedDays);

                if(week2.textEPick!==0)
                    week2.outputPickedDays = removeFromArray(week2.textEPick,week2.outputPickedDays);

                if(week3.textEPick!==0)
                    week3.outputPickedDays = removeFromArray(week3.textEPick,week3.outputPickedDays);

                if(week4.textEPick!==0)
                    week4.outputPickedDays = removeFromArray(week4.textEPick,week4.outputPickedDays);

                if(week5.textEPick!==0)
                    week5.outputPickedDays = removeFromArray(week5.textEPick,week5.outputPickedDays);

                if(week6.textEPick!==0)
                    week6.outputPickedDays = removeFromArray(week6.textEPick,week6.outputPickedDays);
            }


        }break;

        case "saturday":
        {//f
            if(status)
            {
                week1.setFPicked = status;
                week2.setFPicked = status;
                week3.setFPicked = status;
                week4.setFPicked = status;
                week5.setFPicked = status;
                week6.setFPicked = status;
                if(week1.textFPick!==0)
                    week1.outputPickedDays.push(week1.textFPick);

                if(week2.textFPick!==0)
                    week2.outputPickedDays.push(week2.textFPick);

                if(week3.textFPick!==0)
                    week3.outputPickedDays.push(week3.textFPick);

                if(week4.textFPick!==0)
                    week4.outputPickedDays.push(week4.textFPick);

                if(week5.textFPick!==0)
                    week5.outputPickedDays.push(week5.textFPick);

                if(week6.textFPick!==0)
                    week6.outputPickedDays.push(week6.textFPick);

            }
            else
            {
                week1.setFPicked = status;
                week2.setFPicked = status;
                week3.setFPicked = status;
                week4.setFPicked = status;
                week5.setFPicked = status;
                week6.setFPicked = status;
                if(week1.textFPick!==0)
                    week1.outputPickedDays = removeFromArray(week1.textFPick,week1.outputPickedDays);

                if(week2.textFPick!==0)
                    week2.outputPickedDays = removeFromArray(week2.textFPick,week2.outputPickedDays);

                if(week3.textFPick!==0)
                    week3.outputPickedDays = removeFromArray(week3.textFPick,week3.outputPickedDays);

                if(week4.textFPick!==0)
                    week4.outputPickedDays = removeFromArray(week4.textFPick,week4.outputPickedDays);

                if(week5.textFPick!==0)
                    week5.outputPickedDays = removeFromArray(week5.textFPick,week5.outputPickedDays);

                if(week6.textFPick!==0)
                    week6.outputPickedDays = removeFromArray(week6.textFPick,week6.outputPickedDays);
            }

        }break;

        case "sunday":
        {//g
            if(status)
            {
                week1.setGPicked = status;
                week2.setGPicked = status;
                week3.setGPicked = status;
                week4.setGPicked = status;
                week5.setGPicked = status;
                week6.setGPicked = status;
                if(week1.textGPick!==0)
                    week1.outputPickedDays.push(week1.textGPick);

                if(week2.textGPick!==0)
                    week2.outputPickedDays.push(week2.textGPick);

                if(week3.textGPick!==0)
                    week3.outputPickedDays.push(week3.textGPick);

                if(week4.textGPick!==0)
                    week4.outputPickedDays.push(week4.textGPick);

                if(week5.textGPick!==0)
                    week5.outputPickedDays.push(week5.textGPick);

                if(week6.textGPick!==0)
                    week6.outputPickedDays.push(week6.textGPick);

            }
            else
            {
                week1.setGPicked = status;
                week2.setGPicked = status;
                week3.setGPicked = status;
                week4.setGPicked = status;
                week5.setGPicked = status;
                week6.setGPicked = status;
                if(week1.textGPick!==0)
                    week1.outputPickedDays = removeFromArray(week1.textGPick,week1.outputPickedDays);

                if(week2.textGPick!==0)
                    week2.outputPickedDays = removeFromArray(week2.textGPick,week2.outputPickedDays);

                if(week3.textGPick!==0)
                    week3.outputPickedDays = removeFromArray(week3.textGPick,week3.outputPickedDays);

                if(week4.textGPick!==0)
                    week4.outputPickedDays = removeFromArray(week4.textGPick,week4.outputPickedDays);

                if(week5.textGPick!==0)
                    week5.outputPickedDays = removeFromArray(week5.textGPick,week5.outputPickedDays);

                if(week6.textGPick!==0)
                    week6.outputPickedDays = removeFromArray(week6.textGPick,week6.outputPickedDays);
            }
        }break;
    }
}
