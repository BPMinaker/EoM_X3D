function s=vrml_cyl(x,varargin)
%%
%%
%% This program is free software; you can redistribute it and/or modify it
%% under the terms of the GNU General Public License as published by the
%% Free Software Foundation; either version 2, or (at your option) any
%% later version.
%%
%% This is distributed in the hope that it will be useful, but WITHOUT
%% ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
%% FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
%% for more details.
%%

%%       s=x3d_cyl(x,...)
%%
%% Makes a cylinder that links x(:,1) to x(:,2) 
%% 
%% Options : 
%%
%% 'rad' , radius          : Radius of segments         default=0.05
%% 'cone'          : Make a cone rather than cyl
%% 'tran', transparency    : Transparency                  default=0
%% 'col' , col             : Color           default=[ 0.3 0.4 0.9 ]
%% 'emit'          : Use or not emissiveColor default=false

%% A version of E. Grossmann's vrml_cyl
%% Modification by Bruce Minaker, Jan. 2006, Aug. 2011
%% Original Author:        Etienne Grossmann <etienne@cs.uky.edu>

rad=0.005;
cone=0;
tran=0;
col=[0.3;0.4;0.9];

i = 1;
while(i <= nargin-1)
	tmp=varargin{i};
	i=i+1;
	if(strcmp(tmp,'cone'))
		cone=1;
	elseif(strcmp(tmp,'rad'))
		rad=varargin{i};
		i=i+1;
	elseif(strcmp(tmp,'col'))
		col=varargin{i};
		i=i+1;
	elseif(strcmp(tmp,'tran'))
		tran=varargin{i};
		i=i+1;
	end
end

s='';
[m,n]=size(x);

% Make col 3xn
if(prod(size(col))==3)
	col=col(:);
	col=col(:, ones(1,n));
end

col=col*0.5;

if(prod(size(tran))==1)
	tran=tran(ones(1,n));
end

if(cone)
	shptype='Cone ';
	radtype='bottomRadius ';
else
	shptype='Cylinder ';
	radtype='radius ';
end

for i=2:n

  	d=x(:,i)-x(:,i-1);
  	n=norm(d);
  	if(n)

		t=mean(x(:,[i,i-1])');
		aa=axisang(x(:,i),x(:,i-1));

		pstn=sprintf('%f %f %f',t);
		rtn=sprintf('%f %f %f %f',aa);
		radius=sprintf('%f',rad);
		height=sprintf('%f',n);
		color=sprintf('%f %f %f',col(:,i));
		if(tran(i))
			trans=sprintf('          transparency %f\n',tran(i)');
		else
			trans='';
		end

		s=[s 'Transform {\n'];
		s=[s '  translation ' pstn '\n'];
		s=[s '  rotation ' rtn '\n'];
		s=[s '  children [\n'];
		s=[s '    Shape {\n'];
		s=[s '      appearance Appearance {\n'];
		s=[s '        material Material {\n'];
		s=[s '          emissiveColor ' color '\n'];
		s=[s '          diffuseColor ' color '\n'];
		s=[s trans];
		s=[s '        }\n'];
		s=[s '      }\n'];
		s=[s '      geometry ' shptype '{\n'];
		s=[s '        height ' height '\n'];
		s=[s '        ' radtype radius '\n'];
		s=[s '      }\n'];
		s=[s '    }\n'];
		s=[s '  ]\n'];
		s=[s '}\n'];
	end
end

end %% Leave
