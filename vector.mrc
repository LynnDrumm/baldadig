alias demo_vector {

        var %text Einde.

        var %x $calc(160 - ($width(%text, impact, 64) / 2))
        var %y $calc(90 - ($height(%text, impact, 64) / 2))

        drawtext -nr @demo $rgb(128,128,128) impact 64 %x %y %text

        var %c/400 $calc(%dm.c / 400)
        var %c/10 $calc(%dm.c / 64)

        var %sin $sin(%c/400)
        var %cos $cos(%c/400)

        var %sin_color $sin(%c/10)
        var %cos_color $cos(%c/10)

        var %t $numtok(%dm.vector.v, 32)
        var %cnt 1

        while (%cnt <= %t) {

                var %in_x1 $gettok(%dm.vector.v, %cnt, 32)
                var %in_y1 $gettok(%dm.vector.v, $calc(%cnt + 1), 32)
                var %in_z1 $gettok(%dm.vector.v, $calc(%cnt + 2), 32)
                var %in_x2 $gettok(%dm.vector.v, $calc(%cnt + 3), 32)
                var %in_y2 $gettok(%dm.vector.v, $calc(%cnt + 4), 32)
                var %in_z2 $gettok(%dm.vector.v, $calc(%cnt + 5), 32)

                var %out_z1 $calc((%in_x1 * %sin) + (%in_y1 * %cos) + 3)
                var %out_x1 $calc((%in_x1 * %cos) - (%in_y1 * %sin))
                var %out_x1 $calc(((%out_x1 / %out_z1) + 2) * 90)
                var %out_y1 $calc(((%in_z1 / %out_z1) + 1) * 90)

                var %out_z2 $calc((%in_x2 * %sin) + (%in_y2 * %cos) + 3)
                var %out_x2 $calc((%in_x2 * %cos) - (%in_y2 * %sin))
                var %out_x2 $calc(((%out_x2 / %out_z2) + 2) * 90)
                var %out_y2 $calc(((%in_z2 / %out_z2) + 1) * 90)

                drawline -nr @demo $rgb($calc(%sin_color * 64), 255, $calc(%cos_color * 64)) 1 $calc(%out_x1 - 24) %out_y1 $calc(%out_x2 - 24) %out_y2


                inc %cnt 6
        }

        dmDrawFrame demo_vector
}