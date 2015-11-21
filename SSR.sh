#!/bin/sh
ID="$RANDOM"
VER="1"
PASS="mypass"
SERVEUR="192.168.0.100:5000"
while [ $# -gt 0 ]
do
  key="$1"
  case $key in
    -l|-login)
       echo "Login">/tmp/camres-${ID}.txt 
       VER="1"
       wget -q --keep-session-cookies --save-cookies /tmp/syno-cookies-${ID}.txt -O- "http://${SERVEUR}/webapi/auth.cgi?api=SYNO.API.Auth&method=Login&version=${VER}&account=admin&passwd=${PASS}">>/tmp/camres-${ID}.txt
       ;;
    -logout)
       echo "Logout">>/tmp/camres-${ID}.txt 
       VER="1"
       wget -q --load-cookies /tmp/syno-cookies-${ID}.txt -O- "http://${SERVEUR}/webapi/auth.cgi?api=SYNO.API.Auth&method=Logout&version=${VER}">>/tmp/camres-${ID}.txt
       rm /tmp/syno-cookies-${ID}.txt
       ;;
    -clean)
       rm /tmp/camres-${ID}.txt
       ;;
    -v|-verbose)
       cat /tmp/camres-${ID}.txt
       ;;
    -i=*|-id=*)
       ID="${1#*=}"
       ;;
    -p|-printid)
       echo "${ID}"
       ;;   
    -c=*|-camera=*)
       CAM="${1#*=}"
       ;;
    -e|-enable)
       echo "Enable">>/tmp/camres-${ID}.txt 
       VER="3"
       wget -q --load-cookies /tmp/syno-cookies-${ID}.txt -O-  "http://${SERVEUR}/webapi/entry.cgi?api=SYNO.SurveillanceStation.Camera&method=Enable&version=${VER}&cameraIds=${CAM}">>/tmp/camres-${ID}.txt
       echo "">>/tmp/camres-${ID}.txt 
       ;;
    -d|-disable)
       echo "Disable">>/tmp/camres-${ID}.txt 
       VER="3"
       wget -q --load-cookies /tmp/syno-cookies-${ID}.txt -O-  "http://${SERVEUR}/webapi/entry.cgi?api=SYNO.SurveillanceStation.Camera&method=Disable&version=${VER}&cameraIds=${CAM}">>/tmp/camres-${ID}.txt
       echo "">>/tmp/camres-${ID}.txt 
       ;;
    -notify=*)
       EID="${1#*=}"
       echo "Notify">>/tmp/camres-${ID}.txt 
       VER="1"
       wget -q --load-cookies /tmp/syno-cookies-${ID}.txt -O-  "http://${SERVEUR}/webapi/entry.cgi?api=SYNO.SurveillanceStation.Notification.Filter&method=Set&5=${EID}&version=${VER}">>/tmp/camres-${ID}.txt
       echo "">>/tmp/camres-${ID}.txt 
       ;;
    -event=*)
       EID="${1#*=}"
       echo "Event">>/tmp/camres-${ID}.txt 
       VER="1"
       wget -q --load-cookies /tmp/syno-cookies-${ID}.txt -O-  "http://${SERVEUR}/webapi/entry.cgi?api=SYNO.SurveillanceStation.ExternalEvent&method=Trigger&eventId=${EID}&version=${VER}">>/tmp/camres-${ID}.txt
       echo "">>/tmp/camres-${ID}.txt 
       ;;
    -preset=*)
       PID="${1#*=}"
       echo "Preset">>/tmp/camres-${ID}.txt 
       VER="1"
        wget -q --load-cookies /tmp/syno-cookies-${ID}.txt -O-  "http://${SERVEUR}/webman/3rdparty/SurveillanceStation/cgi/cameraPreset.cgi?action=presetExecute&camId=${CAM}&position=${PID}&speed=3&isPreview=1">>/tmp/camres-${ID}.txt
       echo "">>/tmp/camres-${ID}.txt 
       ;;
    -recordon)
       echo "recordon">>/tmp/camres-${ID}.txt 
       VER="1"
       wget -q --load-cookies /tmp/syno-cookies-${ID}.txt -O-  "http://${SERVEUR}/webapi/entry.cgi?api=SYNO.SurveillanceStation.ExternalRecording&method=Record&action=start&version=${VER}&cameraId=${CAM}">>/tmp/camres-${ID}.txt
       echo "">>/tmp/camres-${ID}.txt 
       ;;
    -recordoff)
       echo "recordoff">>/tmp/camres-${ID}.txt 
       VER="1"
       wget -q --load-cookies /tmp/syno-cookies-${ID}.txt -O-  "http://${SERVEUR}/webapi/entry.cgi?api=SYNO.SurveillanceStation.ExternalRecording&method=Record&action=stop&version=${VER}&cameraId=${CAM}">>/tmp/camres-${ID}.txt
       echo "">>/tmp/camres-${ID}.txt 
       ;;
    -h|-help)
       echo "[-camera=camid] [-enable] [-disable] [-recordon] [-recordoff] [-preset=prstid] [-notify=0|1] [-printid] [-id=logid] [-login] [-logout] [-verbose] [-clean]"
       ;;
    *)
       echo "unknown:$1"
       ;;
  esac
  shift
done
