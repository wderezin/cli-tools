function show-colors
    set -n  | egrep '^fish_color' | while read x
        echo  (set_color $$x)$x(set_color $fish_color_normal)
    end
end