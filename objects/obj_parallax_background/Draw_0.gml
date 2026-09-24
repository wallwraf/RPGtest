var _camx = camera_get_view_x(view_camera[0]);
var _camy = camera_get_view_y(view_camera[0]);

var _p = 1;

draw_sprite_tiled(spr_parallax1, 0, _camx * _p, _camy * _p);
draw_sprite_tiled(spr_parallax1, 1, _camx * .75, _camy * .75);
draw_sprite_tiled(spr_parallax1, 2, _camx * .5, _camy * .5);
draw_sprite_tiled(spr_parallax1, 3, _camx * .25, _camy * .25);