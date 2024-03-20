function ButtonMotionFcn(hObject, eventdata, handles)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
clc
set(gcf,'Pointer','hand');
global passdata;
passdata.mouseSign=1;
if passdata.mouseSign==1 && passdata.singalclick==1 && ~isempty(passdata.MarkIndex)
    
    if passdata.currentmode==1 && isfield(passdata,'cue')
        cueindex=passdata.mode1_channel;
        if ~isempty(passdata.cue)
            mousePoint = get(gca,'CurrentPoint');
            mousePonit_x = mousePoint(1,1);
            eval(['A=passdata.InputMark.upindex_' num2str(cueindex) ';']);
            
            [val, row]=min(abs(passdata.MarkIndex-mousePonit_x));
            if val<=10
                passdata.MarkIndex(row)=mousePonit_x;
                A(row)=round(mousePonit_x*120);
                delete(passdata.linefig);
                linex=[passdata.MarkIndex;passdata.MarkIndex];
                passdata.linefig=line(linex,passdata.fpsmark,'Color','b','LineWidth',1);
            end
            
            eval(['passdata.InputMark.upindex_' num2str(cueindex) '=A;']);
        end
    elseif passdata.currentmode==2
        
        
        mousePoint = get(gca,'CurrentPoint');
        mousePonit_x = mousePoint(1,1);
        [val, row]=min(abs(passdata.MarkIndex-mousePonit_x));
        if val<=10
            passdata.MarkIndex(row)=mousePonit_x;
            delete(passdata.linefig);
            linex=[passdata.MarkIndex;passdata.MarkIndex];
            passdata.linefig=line(linex,passdata.fpsmark,'Color','b','LineWidth',1);
            passdata.mouseSignindex=find(passdata.ManualMark_upindex==mousePonit_x);
        else
            passdata.mouseSignindex=[];
        end 
        
        passdata.ManualMark_upindex=passdata.MarkIndex;
        
%         if ~isempty(passdata.ManualMark_upindex)
%             
%             passdata.ManualMark_upindex=sort(passdata.ManualMark_upindex);
%             listbox_cell=cell(1,1+length(passdata.ManualMark_upindex));
%             listbox_cell{1,1}='MarkTime';
%             
%             for i=2:(1+length(passdata.ManualMark_upindex))
%                 listbox_cell{1,i}=num2str(passdata.ManualMark_upindex(i-1));
%             end
%             if isfield(passdata,'mouseSignindex')
%                 if ~isempty(passdata.mouseSignindex)
%                     index=passdata.mouseSignindex+1;
%                 else
%                     index=1+length(passdata.ManualMark_upindex);
%                 end
%             else
%                 index=1+length(passdata.ManualMark_upindex);
%             end
%             set(handles.MarkTime,'String',listbox_cell);
%             set(handles.MarkTime,'Value',1);
%         else
%             listbox_cell=cell(1,1);
%             listbox_cell{1,1}='MarkTime';
%             set(handles.MarkTime,'String',listbox_cell);
%             set(handles.MarkTime,'Value',1);
%         end
    end
end

end

