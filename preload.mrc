alias demo_preload {

        var %tot $lines($scriptdirprecalc.dss)

        if (%dm.preload.cnt < %tot) {

                drawtext -nr @demo $rgb(255, 255, 255) Arial 10 15  72 Another Poo-brain Kwalli™ release
                drawtext -nr @demo $rgb(255, 255, 255) Arial 10 185 95 For your viewing pleasure

                drawrect -nr  @demo $rgb(255,255,255) 1 13 83 294 14                

                var %read $($read($scriptdirprecalc.dss, %dm.preload.cnt), 1)

                %read

                :error

                inc %dm.preload.cnt

                var %pct $calc((%dm.preload.cnt / %tot) * 100)

                echo @dm.log $+([,$calc($ticks - %dm.ticks),][,%dm.preload.cnt,]) %read

        }

        if (%dm.preload.cnt >= %tot) {

                drawtext -nr  @demo $rgb(255, 255, 255) Arial 10 15  72 Another Poo-brain Kwalli™ release
                drawtext -nr  @demo $rgb(255, 255, 255) Arial 10 185 95 For your viewing pleasure
                drawrect -nr  @demo $rgb(255, 255, 255) 1 13 83 294 14
                drawrect -nrf @demo $rgb(255, 255, 255) 0 15 85 290 10

                drawrect -nrf @demo 0 0 0 45 320 %dm.preload.c

                drawline -nr @demo $gettok(%dm.preload.ctab, %dm.preload.c, 32) 1 0 $calc(45 + %dm.preload.c) 320 $calc(45 + %dm.preload.c)

                if (%dm.preload.c < 99) {

                        dinc dm.preload.c .05
                }

                else {

                        set %dm.time $ctime

                        if (%dm.music != $null) {

                               splay -w $qt(%dm.music)                               
                        }                        

                        .signal -n dmSelectPart %dm.flags
                        halt
                }
        }        

        var %w $calc($+(0.,$iif(%pct < 10, $+(0,%pct), %pct)) * 290)

        drawrect -nrf @demo $rgb(255,255,255) 0 15 85 %w 10

        drawrect -nrfi @demo 0 0 0 0 320 180

        dmDrawFrame demo_preload
}