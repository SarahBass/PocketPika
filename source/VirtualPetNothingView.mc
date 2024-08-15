import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Time;
import Toybox.Weather;
import Toybox.Activity;
import Toybox.ActivityMonitor;
import Toybox.Time.Gregorian;

class VirtualPetNothingView extends WatchUi.WatchFace {
  
function initialize() {  WatchFace.initialize(); }

function onLayout(dc as Dc) as Void { }

function onShow() as Void { }

function onUpdate(dc as Dc) as Void {
       var mySettings = System.getDeviceSettings();
       var screenHeightY = System.getDeviceSettings().screenHeight;
       var adjustTextX = 1;
       var adjustTextY = 1;
       if (screenHeightY ==416){ adjustTextX = 1.15; adjustTextY = 1.17;}
       else if (screenHeightY ==390){ adjustTextX = 1.1; adjustTextY = 1.1;}
       else if (screenHeightY ==454){ adjustTextX = 1.25; adjustTextY = 1.28;}
       else if (mySettings.screenShape != 1){ adjustTextX = 1.25; adjustTextY = 0.9;}
       else{ adjustTextX = 1; adjustTextY = 1;}

       var VXAdjust = ((System.getDeviceSettings().screenWidth)/360)*adjustTextX;
       var VYAdjust =((System.getDeviceSettings().screenHeight)/360)*adjustTextY;
       var myStats = System.getSystemStats();
       var info = ActivityMonitor.getInfo();
       var timeFormat = "$1$:$2$";
       var clockTime = System.getClockTime();
       var today = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
              var hours = clockTime.hour;
               if (!System.getDeviceSettings().is24Hour) {
            if (hours > 12) {
                hours = hours - 12;
            }
        } else {   
                timeFormat = "$1$:$2$";
                hours = hours.format("%02d"); }
        var timeString = Lang.format(timeFormat, [hours, clockTime.min.format("%02d")]);
        var timeStamp= new Time.Moment(Time.today().value());
        var weekdayArray = ["Day", "SUNDAY", "MONDAY", "TUESDAY", "WEDNESDAY", "THURSDAY", "FRIDAY", "SATURDAY"] as Array<String>;
        var monthArray = ["Month", "JANUARY", "FEBRUARY", "MARCH", "APRIL", "MAY", "JUNE", "JULY", "AUGUST", "SEPTEMBER", "OCTOBER", "NOVEMBER", "DECEMBER"] as Array<String>;
 var arrayPokemon = ["a","b","c", "d", "e", "f", "j", "h", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
 "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","1","2","3","4","5","6","7","8","9","0"];
 var userBattery = "000";
 var batteryMeter = 1;
   if (myStats.battery != null){userBattery = Lang.format("$1$",[((myStats.battery.toNumber())).format("%02d")]);}else{userBattery="000";} 
if (myStats.battery != null){batteryMeter = myStats.battery.toNumber();}else{batteryMeter="1";} 
   var userSTEPS = 0;
   if (info.steps != null){userSTEPS = info.steps.toNumber();}else{userSTEPS=0;} 

     var userCAL = 0;
   if (info.calories != null){userCAL = info.calories.toNumber();}else{userCAL=0;}  
   
   var getCC = Toybox.Weather.getCurrentConditions();
    var TEMP = "000";
    var FC = "0";
     if(getCC != null && getCC.temperature!=null){     
        if (System.getDeviceSettings().temperatureUnits == 0){  
    FC = "C";
    TEMP = getCC.temperature.format("%d");
    }else{
    TEMP = (((getCC.temperature*9)/5)+32).format("%d"); 
    FC = "F";   
    }}
     else {TEMP = "000";}
    
    var cond=0;
    if (getCC != null){ cond = getCC.condition.toNumber();}
    else{cond = 0;}//sun
 /*
 var AMPM = "";       
    if (!System.getDeviceSettings().is24Hour) {
        if (clockTime.hour > 12) {
                AMPM = "N";
            }else{
                AMPM = "M";
            }}
*/
 var positions;
        if (Toybox.Weather.getCurrentConditions().observationLocationPosition == null){
        positions=new Position.Location( 
    {
        :latitude => 33.684566,
        :longitude => -117.826508,
        :format => :degrees
    }
    );
    }else{
      positions= Toybox.Weather.getCurrentConditions().observationLocationPosition;
    }
    
  

  var sunrise = Time.Gregorian.info(Toybox.Weather.getSunrise(positions, timeStamp), Time.FORMAT_MEDIUM);
        
	var sunriseHour;
  if (Toybox.Weather.getSunrise(positions, timeStamp) == null){sunriseHour = 6;}
    else {sunriseHour= sunrise.hour;}
         if (!System.getDeviceSettings().is24Hour) {
            if (sunriseHour > 12) {
                sunriseHour = (sunriseHour - 12).abs();
            }
        } else {
           
                timeFormat = "$1$:$2$";
                sunriseHour = sunriseHour.format("%02d");
        }
        
    var sunset;
    var sunsetHour;
    sunset = Time.Gregorian.info(Toybox.Weather.getSunset(positions, timeStamp), Time.FORMAT_MEDIUM);
    if (Toybox.Weather.getSunset(positions, timeStamp) == null){sunsetHour = 6;}
    else {sunsetHour= sunset.hour ;}
        
	
         if (!System.getDeviceSettings().is24Hour) {
            if (sunsetHour > 12) {
                sunsetHour = (sunsetHour - 12).abs();
            }
        } else {
            
                timeFormat = "$1$:$2$";
                sunsetHour = sunsetHour.format("%02d");
        }           

 var userNotify = "0";
   if (mySettings.notificationCount != null){userNotify = Lang.format("$1$",[((mySettings.notificationCount.toNumber())).format("%2d")]);}else{userNotify="0";} 
var numberNotify = 0;
   if (mySettings.notificationCount != null){numberNotify = mySettings.notificationCount.toNumber();}else{numberNotify =0;} 
var userHEART = "000";
if (getHeartRate() == null){userHEART = "000";}
else if(getHeartRate() == 255){userHEART = "000";}
else{userHEART = getHeartRate().toString();}

var moonnumber = getMoonPhase(today.year, ((today.month)-1), today.day);  
var moon1 = moonArrFun(moonnumber);
var centerX = (dc.getWidth()) / 2;
var smallFont =  WatchUi.loadResource( Rez.Fonts.WeatherFont );
var wordFont =  WatchUi.loadResource( Rez.Fonts.smallFont );
var xsmallFont =  WatchUi.loadResource( Rez.Fonts.xsmallFont );
var smallpoke =  WatchUi.loadResource( Rez.Fonts.smallpoke );

View.onUpdate(dc);



dc.setColor(0x415F5F, Graphics.COLOR_TRANSPARENT);        
dc.fillCircle(centerX, centerX, centerX) ;     
dc.setColor(0x3F5E4F, Graphics.COLOR_TRANSPARENT);       
dc.fillCircle(centerX, centerX, centerX*2/3) ;   
dc.setColor(0x4D6A5D, Graphics.COLOR_TRANSPARENT);        
dc.drawCircle(centerX, centerX, centerX) ; 
dc.setColor(0x4D6A5D, Graphics.COLOR_TRANSPARENT);       
dc.drawCircle(centerX, centerX, centerX*1/2) ;   
dc.setColor(0x7B8863, Graphics.COLOR_TRANSPARENT);       
dc.fillCircle(centerX, centerX, centerX*1/2) ;        

//Draw Objects
moon1.draw(dc);
var dog = dogPhase(today.sec,userSTEPS); //userSTEPS
dog.draw(dc);

//Every 360 Steps Pikachu Levels up
dc.setPenWidth(16);
dc.setColor(0x6C7778, Graphics.COLOR_TRANSPARENT);
dc.drawCircle(centerX, centerX, centerX*310/360);
dc.setColor(0x2F4237, Graphics.COLOR_TRANSPARENT);
dc.drawArc(centerX, centerX, centerX*310/360, Graphics.ARC_COUNTER_CLOCKWISE, 1, (userSTEPS+2) ); 

//Battery Meter
dc.setColor(0x17231B, Graphics.COLOR_TRANSPARENT);  
if(batteryMeter<33 &&batteryMeter>9){
    dc.fillRectangle(centerX*350/360, (centerX*245/360)+40, 9, 50/14);}
else if(batteryMeter>33 && batteryMeter<66){
dc.fillRectangle(centerX*350/360, (centerX*235/360)+40, 9, 50/14);
dc.fillRectangle(centerX*350/360, (centerX*245/360)+40, 9, 50/14);}
else if (batteryMeter >66){
dc.fillRectangle(centerX*350/360, (centerX*225/360)+40, 9, 50/14);
dc.fillRectangle(centerX*350/360, (centerX*235/360)+40, 9, 50/14);
dc.fillRectangle(centerX*350/360, (centerX*245/360)+40, 9, 50/14);}
else{}


}


function onHide() as Void { }
function onExitSleep() as Void {}
function onEnterSleep() as Void {}

function weather(cond) {
  if (cond == 0 || cond == 40){return "b";}//sun
  else if (cond == 50 || cond == 49 ||cond == 47||cond == 45||cond == 44||cond == 42||cond == 31||cond == 27||cond == 26||cond == 25||cond == 24||cond == 21||cond == 18||cond == 15||cond == 14||cond == 13||cond == 11||cond == 3){return "a";}//rain
  else if (cond == 52||cond == 20||cond == 2||cond == 1){return "e";}//cloud
  else if (cond == 5 || cond == 8|| cond == 9|| cond == 29|| cond == 30|| cond == 33|| cond == 35|| cond == 37|| cond == 38|| cond == 39){return "g";}//wind
  else if (cond == 51 || cond == 48|| cond == 46|| cond == 43|| cond == 10|| cond == 4){return "i";}//snow
  else if (cond == 32 || cond == 37|| cond == 41|| cond == 42){return "f";}//whirlwind 
  else {return "c";}//suncloudrain 
}



function dogPhase(seconds, steps){
  var screenHeightY = System.getDeviceSettings().screenHeight;
  var screenWidthX = System.getDeviceSettings().screenWidth;
  var venus2X = 110*screenWidthX/360;
  var venus2Y = (190*screenHeightY/360);
  var dogARRAY = [
    (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.dog0,
            :locX=> venus2X,
            :locY=>venus2Y
 })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.dog1,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
                (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.dog2,
            :locX=> venus2X+2,
            :locY=>venus2Y+3
        })),
                (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.dog3,
            :locX=> venus2X+2,
            :locY=>venus2Y+3
        })),
                (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.dog4,
            :locX=> venus2X+2,
            :locY=>venus2Y+3
        })),
                   (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.dog5,
            :locX=> venus2X+2,
            :locY=>venus2Y+3
        })),
                (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.dog6,
            :locX=> venus2X*1.3,
            :locY=>venus2Y*1.2
        })),
                (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.dog7,
            :locX=> venus2X*1.3,
            :locY=>venus2Y*1.2
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.dog8,
            :locX=> venus2X+2,
            :locY=>venus2Y+3
        })),
(new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.dog9,
            :locX=> venus2X+2,
            :locY=>venus2Y+3
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.dog10,
            :locX=> venus2X+2,
            :locY=>venus2Y+3
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.dog11,
            :locX=> venus2X+2,
            :locY=>venus2Y+3
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.dog12,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.dog13,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.dog14,
            :locX=> venus2X+2,
            :locY=>venus2Y+3
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.dog15,
            :locX=> venus2X+2,
            :locY=>venus2Y+3
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.dog16,
            :locX=> venus2X+2,
            :locY=>venus2Y+3
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.dog17,
            :locX=> venus2X+2,
            :locY=>venus2Y+3
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.dog18,
            :locX=> venus2X+2,
            :locY=>venus2Y+3
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.dog19,
            :locX=> venus2X+2,
            :locY=>venus2Y+3
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.dog20,
            :locX=> venus2X+2,
            :locY=>venus2Y+3
        })),
                (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.dog21,
            :locX=> venus2X+2,
            :locY=>venus2Y+3
        })),
                (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.dog22,
            :locX=> venus2X+2,
            :locY=>venus2Y+3
        })),
                (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.dog23,
            :locX=> venus2X+2,
            :locY=>venus2Y+3
        })),
                (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.dog24,
            :locX=> venus2X+2,
            :locY=>venus2Y+3
        })),
                (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.dog25,
            :locX=> venus2X+2,
            :locY=>venus2Y+3
        })),
                (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.dog26,
            :locX=> venus2X+2,
            :locY=>venus2Y+3
        })),
                (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.dog27,
            :locX=> venus2X+2,
            :locY=>venus2Y+3
        })),
                (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.dog28,
            :locX=> venus2X+2,
            :locY=>venus2Y+3
        })),
                (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.dog29,
            :locX=> venus2X+2,
            :locY=>venus2Y+3
        })),
                (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.dog30,
            :locX=> venus2X+2,
            :locY=>venus2Y+3
        })),
                (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.dog31,
            :locX=> venus2X+2,
            :locY=>venus2Y+3
        })),
                (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.dog32,
            :locX=> venus2X*1.25,
            :locY=>venus2Y*1.25
        })),
                     (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.dog33,
            :locX=> venus2X*1.25,
            :locY=>venus2Y*1.25
        }))
        ];
        if (steps > 5750){return dogARRAY[32 + seconds%2];}else{return dogARRAY[((steps/360)*2) + seconds%2 ];}
        
        
  
}

private function getHeartRate() {// initialize it to null
  var heartRate = null;// Get the activity info if possible
  var info = Activity.getActivityInfo();
  if (info != null) {
    heartRate = info.currentHeartRate;
  } else { // Fallback to `getHeartRateHistory`
    var latestHeartRateSample = ActivityMonitor.getHeartRateHistory(1, true).next();
    if (latestHeartRateSample != null) {
      heartRate = latestHeartRateSample.heartRate;
    } } // Could still be null if the device doesn't support it
  return heartRate;}
/*
  __  __                 ___ _                 
 |  \/  |___  ___ _ _   | _ \ |_  __ _ ___ ___ 
 | |\/| / _ \/ _ \ ' \  |  _/ ' \/ _` (_-</ -_)
 |_|  |_\___/\___/_||_| |_| |_||_\__,_/__/\___|
 
*/
function getMoonPhase(year, month, day) {

      var c=0;
      var e=0;
      var jd=0;
      var b=0;

      if (month < 3) {
        year--;
        month += 12;
      }

      ++month; 

      c = 365.25 * year;

      e = 30.6 * month;

      jd = c + e + day - 694039.09; 

      jd /= 29.5305882; 

      b = (jd).toNumber(); 

      jd -= b; 

      b = Math.round(jd * 8); 

      if (b >= 8) {
        b = 0; 
      }
     
      return (b).toNumber();
    }

     /*
     0 => New Moon
     1 => Waxing Crescent Moon
     2 => Quarter Moon
     3 => Waxing Gibbous Moon
     4 => Full Moon
     5 => Waning Gibbous Moon
     6 => Last Quarter Moon
     7 => Waning Crescent Moon
     */
function moonArrFun(moonnumber){
var venus2Y = ((System.getDeviceSettings().screenHeight)*130/360);
var venus2XL = ((System.getDeviceSettings().screenWidth)*119/360);

  var moonArray= [
          (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.newmoon,//0
            :locX=> venus2XL,
            :locY=> venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.waxcres,//1
            :locX=> venus2XL,
            :locY=> venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.firstquar,//2
            :locX=> venus2XL,
            :locY=> venus2Y
        })),
                (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.waxgib,//3
            :locX=> venus2XL,
            :locY=> venus2Y
        })),
                (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.full,//4
            :locX=> venus2XL,
            :locY=> venus2Y
        })),
                (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.wangib,//5
            :locX=> venus2XL,
            :locY=> venus2Y
        })),
            (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.thirdquar,//6
            :locX=> venus2XL,
            :locY=> venus2Y
        })),
           (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.wancres,//7
            :locX=> venus2XL,
            :locY=> venus2Y,
        })),
        ];
        return moonArray[moonnumber];
}


}
