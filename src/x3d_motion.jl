function s=x3d_motion(time,lcn,rtn,scl,grp,x3d)
%% Copyright (C) 2005, Bruce Minaker
%% This file is intended for use with Octave.
%% x3d_motion.m is free software; you can redistribute it and/or modify it
%% under the terms of the GNU General Public License as published by
%% the Free Software Foundation; either version 2, or (at your option)
%% any later version.
%%
%% x3d_motion.m is distributed in the hope that it will be useful, but
%% WITHOUT ANY WARRANTY; without even the implied warranty of
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
%% General Public License for more details at www.gnu.org/copyleft/gpl.html.
%%
%%--------------------------------------------------------------------

pstn='';
rntn='';
scal='';
tme='';

[n,m]=size(time);
for i=1:m-1
	pstn=[pstn sprintf('%f %f %f,\n',lcn(:,i))];
end
pstn=[pstn sprintf('%f %f %f',lcn(:,m))];

for i=1:m-1
	rntn=[rntn sprintf('%f %f %f %f,\n',rtn(:,i))];
end
rntn=[rntn sprintf('%f %f %f %f',rtn(:,m))];

for i=1:m-1
	scal=[scal sprintf('%f %f %f,',scl(:,i))];
end
scal=[scal sprintf('%f %f %f',scl(:,m))];

for i=1:m-1
	tme=[tme sprintf('%f,',time(i))];
end
tme=[tme sprintf('%f',time(m))];


%% color interpolation turned off for now - problems with redundant DEFs
%clr='0 0 1   1 0 0   0 1 0   1 0 0  0 0 1';
%dt=(time(m)-time(1))/4;
%ctme=num2str(time(1):dt:time(m));

%[0 0 1] blue
%[0 1 1] cyan
%[0 1 0] green
%[1 1 0] yellow
%[1 0 0] red
%[1 0 1] magenta

s=['<PositionInterpolator DEF="IDt' grp '" keyValue="' pstn '" key="' tme '" />\n'];
s=[s '<OrientationInterpolator DEF="IDr' grp '" keyValue="' rntn '" key="' tme '" />\n'];
s=[s '<PositionInterpolator DEF="IDs' grp '" keyValue="' scal '" key="' tme '" />\n'];
%s=[s '<ColorInterpolator DEF="IDc' grp '" keyValue="' clr '" key="' ctme '" />\n'];

%x3d=strrep(x3d,'<Material','<Material DEF="rnbw"');
s=[s '<Transform DEF="ID'  grp '" >\n'];
s=[s x3d];
s=[s '</Transform>\n'];

s=[s '<ROUTE fromNode="IDtimer" fromField="fraction_changed" toNode="IDt' grp '" toField="set_fraction" />\n'];
s=[s '<ROUTE fromNode="IDtimer" fromField="fraction_changed" toNode="IDr' grp '" toField="set_fraction" />\n'];
s=[s '<ROUTE fromNode="IDtimer" fromField="fraction_changed" toNode="IDs' grp '" toField="set_fraction" />\n'];
%s=[s '<ROUTE fromNode="IDtimer" fromField="fraction_changed" toNode="IDc' grp '" toField="set_fraction" />\n'];

s=[s '<ROUTE fromNode="IDt' grp '" fromField="value_changed" toNode="ID' grp '" toField="set_translation" />\n'];
s=[s '<ROUTE fromNode="IDr' grp '" fromField="value_changed" toNode="ID' grp '" toField="set_rotation" />\n'];
s=[s '<ROUTE fromNode="IDs' grp '" fromField="value_changed" toNode="ID' grp '" toField="set_scale" />\n'];
%s=[s '<ROUTE fromNode="IDc' grp '" fromField="value_changed" toNode="rnbw" toField="diffuseColor" />\n'];

end
