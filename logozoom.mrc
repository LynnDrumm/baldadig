alias demo_logozoom {

        ;; logo is already drawn in a buffer, so what we do here is get the current zoom level,
        ;; and use it to cut out a 320*320 centered section which is copied over to a 2nd buffer.
        ;; there, we rotate it slightly and then copy anothered centered section (320*180 this
        ;; time) to the main screen.

        drawcopy -n  @dm.logozoom.1 $calc(320 - (%dm.logozoom.zoom / 2)) $calc(320 - (%dm.logozoom.zoom / 2)) $calc(320 + %dm.logozoom.zoom) $calc(320 + %dm.logozoom.zoom) @dm.logozoom.2 0 0 320 320
        drawrot -nc  @dm.logozoom.2 $calc((%dm.c / 16) + -120) 0 0 320 320
        drawcopy -n  @dm.logozoom.2 0 70 320 180 @demo 0 0 320 180

        drawrect -nrf @dm.logozoom.2 0 0 0 0 320 320

        ;; the further we zoom out, the darker the logo should be.

        if (%dm.logozoom.zoom < -2200) {

                drawreplace -nr @demo $rgb(255, 255, 255) $gettok(%dm.logozoom.fade.ctab, %dm.logozoom.fade.c, 32)

                if (%dm.logozoom.fade.c < 254) {

                        dinc dm.logozoom.fade.c .075
                }

                if (%dm.logozoom.fade.c > 255) {

                        set %dm.logozoom.fade.c 255
                }
        }

        ddec dm.logozoom.zoom $calc(.1 + %dm.logozoom.zoom.scale)

        dinc dm.logozoom.zoom.scale .0001

        dmDrawFrame demo_logozoom

        if (%dm.c > 9000) {

                .signal -n dmSelectPart splash
                halt
        }
}