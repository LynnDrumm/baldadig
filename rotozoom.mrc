alias demo_rotozoom {                 

        if (%dm.c < 10000) {

                var %cnt 0
                var %s 16

                while (%cnt < 180) {

                        var %sin $calc(($sin($calc((%dm.c / (%dm.bpm * 4000)) + (%cnt / 8))).deg * 63) + 64)

                        drawrect -nrf @demo $gettok(%dm.rotozoom.ctab, %sin, 32) 0 0 %cnt 320 $calc(%s + %sin)

                        inc %cnt %s

                }
        }

        elseif ((%dm.c > 10000) && (%dm.c < 12100)) {

                drawrect -nrf @demo $rgb(255,255,255) 0 0 0 320 180
        }
        
        elseif (%dm.c > 12100) {

                var %cnt 0
                var %s 16

                while (%cnt < 180) {

                        var %sin $calc(($sin($calc((%dm.c / (%dm.bpm * 1000)) + (%cnt / 8))).deg * 63) + 64)

                        drawrect -nrf @demo $gettok(%dm.rotozoom.ctab, %sin, 32) 0 0 %cnt 320 $calc(%s + %sin)

                        inc %cnt %s

                }
        }

        else {

                drawrect -nrf @demo $rgb(255,255,255) 0 0 0 320 180
        }

        drawrect -nrf @dm.rotozoom.1 0 0 0 0 400 400

        var %c $calc(%dm.c / 16)

        var %cos     $calc((($sin($calc((%c / 4) + 45)  ).deg ^ 4) * 800) + %dm.rotozoom.fadein)
        var %x.start $calc((($sin($calc(%c / 3.7)).deg ^ 5) * 128) - 128)
        var %y       $calc((($cos($calc(%c / 3.4)).deg ^ 4) * 128) - 100)

        if (%dm.c < 4000) {

                if (%dm.rotozoom.fadein > 100) {

                        ddec dm.rotozoom.fadein 1
                }
        }

        while (%y < 400) {

                var %x %x.start

                while (%x < 400) {

                        drawpic -cs @dm.rotozoom.1 %x %y %cos %cos %dm.rotozoom.tex
                        inc %x %cos
                }

                inc %y %cos
        }

        if (%dm.c > 12100) {


                drawrot -cn @dm.rotozoom.1 $calc((($cos(%dm.rotozoom.c).deg * 512) * 5) + 0) 0 0 200 200

                dinc dm.rotozoom.c .005
        }

        drawcopy -nt @dm.rotozoom.1 $rgb(255,255,255) 22.5 45 160 90 @demo 0 0 320 180

        if (%dm.c > 21000) {

                dinc dm.rotozoom.fadein $calc(%c / 3500)
        }

        if (%dm.c > 10000) {

                ;; interlaced logo

                drawrect -nrf @dm.rotozoom.2 $rgb(255,255,255) 0 0 0 320 180

                drawpic -nct @dm.rotozoom.2 $rgb(255,255,255) 18 $calc(63 + (%dm.rotozoom.pic.fade / 2)) 0 %dm.rotozoom.pic.fade 285 $calc(59 - %dm.rotozoom.pic.fade) $qt($scriptdirimg\baldadig.png)

                if (%dm.c > 21000) {

                        dinc dm.rotozoom.pic.fade .05
                }
                
                if (%dm.c < 12100) {

                        drawreplace -nr @dm.rotozoom.2 0 $rgb(255,0,0)

                        ;; invert texture colours

                        drawrect -nrfi @demo 0 0 0 0 320 180
                }

                else {

                        drawreplace -nr @dm.rotozoom.2 0 $rgb(254,254,254)
                }
                
                if (%dm.interlace == 1) {

                        drawcopy -nt @dm.interlace.1 0 0 0 320 180 @dm.rotozoom.2 0 0 320 180

                        set %dm.interlace 2
                }

                else {

                        drawcopy -nt @dm.interlace.2 0 0 0 320 180 @dm.rotozoom.2 0 0 320 180

                        set %dm.interlace 1
                }

                drawcopy -nt @dm.rotozoom.2 $rgb(255,255,255) 0 0 320 180 @demo 0 0 320 180
        }

        if (%dm.c < 2000) {                

                drawcopy -n @dm.starfield.1 0 0 340 180 @dm.starfield.1 $+(-,$calc((%dm.frt * 1.9) / 16)) 0 340 180

                drawcopy -nt @dm.starfield.1 0 0 0 320 180 @demo 0 0 320 180
        }

        dmDrawFrame demo_rotozoom

        if (%dm.c > 27300) {

                .signal -n dmSelectPart cubes
                halt
        }
}