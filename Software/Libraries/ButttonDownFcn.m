function ButttonDownFcn(~,~)
clc
global passdata;


switch(get(gcf,'SelectionType'))
    case 'normal'
        passdata.mouseSign = 0;
        passdata.singalclick=1;
        str = '单机左键';
    case 'alt'
        str = '单机右键/ctrl+左';
    case 'open'
        passdata.doubleclick=1;
        str = '双击任意键';
    otherwise
        str = '其他';
end
disp(str);
end

