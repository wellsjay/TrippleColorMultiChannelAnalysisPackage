function ButttonDownFcn(~,~)
clc
global passdata;


switch(get(gcf,'SelectionType'))
    case 'normal'
        passdata.mouseSign = 0;
        passdata.singalclick=1;
        str = '�������';
    case 'alt'
        str = '�����Ҽ�/ctrl+��';
    case 'open'
        passdata.doubleclick=1;
        str = '˫�������';
    otherwise
        str = '����';
end
disp(str);
end

