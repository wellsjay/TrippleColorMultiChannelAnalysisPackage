function ButttonUpFcn(hObject, eventdata, handles)
clc
global passdata

if passdata.doubleclick==1
    %% 获取当前点

    %% 保存修改的数据
    if passdata.currentmode==1 && isfield(passdata,'cue')
        if ~isempty(passdata.cue)
            cueindex=passdata.mode1_channel;
%             interval=1/120;
            eval(['A=passdata.InputMark.upindex_' num2str(cueindex) ';']);
            mousePoint = get(gca,'CurrentPoint');
            mousePonit_x = mousePoint(1,1);
            [val, row]=min(abs(passdata.MarkIndex(:)-mousePonit_x));
            if val<=1.5
                passdata.MarkIndex(row)=[];
                A(row)=[];
                passdata.fpsmark=passdata.fpsmark(:,2:end);
                delete(passdata.linefig);
            else
                if isempty(passdata.MarkIndex)
                    passdata.fpsmark=[passdata.minwave;passdata.maxwave];
                else
                    delete(passdata.linefig);
                    passdata.fpsmark=[passdata.fpsmark,passdata.fpsmark(:,1)];
                end
                passdata.MarkIndex=sort([passdata.MarkIndex,mousePonit_x]);
                A=sort([A,round(mousePonit_x*120)]);
            end
            eval(['passdata.InputMark.upindex_' num2str(cueindex) '=A;']);
            
            linex=[passdata.MarkIndex;passdata.MarkIndex];
            passdata.linefig=line(linex,passdata.fpsmark,'Color','b','LineWidth',1);
            %%  更新mark
            if ~isempty(passdata.MarkIndex)
                
                
                listbox_cell=cell(1,1+length(passdata.MarkIndex));
                listbox_cell{1,1}='MarkTime';
                
                for i=2:(1+length(passdata.MarkIndex))
                    listbox_cell{1,i}=num2str(passdata.MarkIndex(i-1));
                end
                if isfield(passdata,'mouseSignindex')
                    if ~isempty(passdata.mouseSignindex)
                        index=passdata.mouseSignindex+1;
                    else
                        index=1+length(passdata.MarkIndex);
                    end
                else
                    index=1+length(passdata.MarkIndex);
                end
                set(handles.MarkTime,'String',listbox_cell);
                set(handles.MarkTime,'Value',1);
            else
                listbox_cell=cell(1,1);
                listbox_cell{1,1}='MarkTime';
                set(handles.MarkTime,'String',listbox_cell);
                set(handles.MarkTime,'Value',1);
            end
            %%
            
        end
    elseif passdata.currentmode==2
        mousePoint = get(gca,'CurrentPoint');
        mousePonit_x = mousePoint(1,1);
        [val, row]=min(abs(passdata.MarkIndex(:)-mousePonit_x));
        if val<=1.5
            passdata.MarkIndex(row)=[];
            passdata.fpsmark=passdata.fpsmark(:,2:end);
            delete(passdata.linefig);
        else
            if isempty(passdata.MarkIndex)
                passdata.fpsmark=[passdata.minwave;passdata.maxwave];
            else
                delete(passdata.linefig);
                passdata.fpsmark=[passdata.fpsmark,passdata.fpsmark(:,1)];
            end
            passdata.MarkIndex=sort([passdata.MarkIndex,mousePonit_x]);
            
        end
        
        
        linex=[passdata.MarkIndex;passdata.MarkIndex];
        passdata.linefig=line(linex,passdata.fpsmark,'Color','b','LineWidth',1);
        passdata.ManualMark_upindex=passdata.MarkIndex;
        
        if ~isempty(passdata.ManualMark_upindex)
            
            passdata.ManualMark_upindex=sort(passdata.ManualMark_upindex);
            listbox_cell=cell(1,1+length(passdata.ManualMark_upindex));
            listbox_cell{1,1}='MarkTime';
            
            for i=2:(1+length(passdata.ManualMark_upindex))
                listbox_cell{1,i}=num2str(passdata.ManualMark_upindex(i-1));
            end
            if isfield(passdata,'mouseSignindex')
                if ~isempty(passdata.mouseSignindex)
                    index=passdata.mouseSignindex+1;
                else
                    index=1+length(passdata.ManualMark_upindex);
                end
            else
                index=1+length(passdata.ManualMark_upindex);
            end
            set(handles.MarkTime,'String',listbox_cell);
            set(handles.MarkTime,'Value',1);
        else
            listbox_cell=cell(1,1);
            listbox_cell{1,1}='MarkTime';
            set(handles.MarkTime,'String',listbox_cell);
            set(handles.MarkTime,'Value',1);
        end
    elseif passdata.currentmode==3
        mousePoint = get(gca,'CurrentPoint');
        mousePonit_x = mousePoint(1,1);
        [val, row]=min(abs(passdata.MarkIndex(:)-mousePonit_x));
        if val<=1.5
            passdata.MarkIndex(row)=[];
            passdata.fpsmark=passdata.fpsmark(:,2:end);
            delete(passdata.linefig);
        else
            if isempty(passdata.MarkIndex)
                passdata.fpsmark=[passdata.minwave;passdata.maxwave];
            else
                delete(passdata.linefig);
                passdata.fpsmark=[passdata.fpsmark,passdata.fpsmark(:,1)];
            end
            passdata.MarkIndex=sort([passdata.MarkIndex,mousePonit_x]);
            
        end
        
        videoindex=get(handles.cue_channel,'Value')-1;
        linex=[passdata.MarkIndex;passdata.MarkIndex];
        passdata.linefig=line(linex,passdata.fpsmark,'Color','b','LineWidth',1);
        passdata.MarkIndex=sort(passdata.MarkIndex);
        eval(['passdata.videocue' num2str(videoindex) '=passdata.MarkIndex;']);
%         passdata.ManualMark_upindex=passdata.MarkIndex;
        
        if ~isempty(passdata.MarkIndex)
            
            
            listbox_cell=cell(1,1+length(passdata.MarkIndex));
            listbox_cell{1,1}='MarkTime';
            
            for i=2:(1+length(passdata.MarkIndex))
                listbox_cell{1,i}=num2str(passdata.MarkIndex(i-1));
            end
            if isfield(passdata,'mouseSignindex')
                if ~isempty(passdata.mouseSignindex)
                    index=passdata.mouseSignindex+1;
                else
                    index=1+length(passdata.MarkIndex);
                end
            else
                index=1+length(passdata.MarkIndex);
            end
            set(handles.MarkTime,'String',listbox_cell);
            set(handles.MarkTime,'Value',1);
        else
            listbox_cell=cell(1,1);
            listbox_cell{1,1}='MarkTime';
            set(handles.MarkTime,'String',listbox_cell);
            set(handles.MarkTime,'Value',1);
        end
    end
end
%% 单击且移动目标检测
if passdata.mouseSign==1 && passdata.singalclick==1 && ~isempty(passdata.MarkIndex)
    
    if passdata.currentmode==1 && isfield(passdata,'cue')
        if ~isempty(passdata.cue)
            mousePoint = get(gca,'CurrentPoint');
            mousePonit_x = mousePoint(1,1);
            [val, row]=min(abs(passdata.MarkIndex-mousePonit_x));
            
             cueindex=passdata.mode1_channel;
%             interval=1/120;
            eval(['A=passdata.InputMark.upindex_' num2str(cueindex) ';']);
            
            if val<=10
                passdata.MarkIndex(row)=mousePonit_x;
                A(row)=round(mousePonit_x*120);
                delete(passdata.linefig);
                linex=[passdata.MarkIndex;passdata.MarkIndex];
                passdata.linefig=line(linex,passdata.fpsmark,'Color','b','LineWidth',1);
            end
            %%
            %%  更新mark
            if ~isempty(passdata.MarkIndex)
                
                
                listbox_cell=cell(1,1+length(passdata.MarkIndex));
                listbox_cell{1,1}='MarkTime';
                
                for i=2:(1+length(passdata.MarkIndex))
                    listbox_cell{1,i}=num2str(passdata.MarkIndex(i-1));
                end
                if isfield(passdata,'mouseSignindex')
                    if ~isempty(passdata.mouseSignindex)
                        index=passdata.mouseSignindex+1;
                    else
                        index=1+length(passdata.MarkIndex);
                    end
                else
                    index=1+length(passdata.MarkIndex);
                end
                set(handles.MarkTime,'String',listbox_cell);
                set(handles.MarkTime,'Value',1);
            else
                listbox_cell=cell(1,1);
                listbox_cell{1,1}='MarkTime';
                set(handles.MarkTime,'String',listbox_cell);
                set(handles.MarkTime,'Value',1);
            end
            %%
            %%
%             cueindex=passdata.mode1_channel;
%             interval=1/120;
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
        
        if ~isempty(passdata.ManualMark_upindex)
            
            passdata.ManualMark_upindex=sort(passdata.ManualMark_upindex);
            listbox_cell=cell(1,1+length(passdata.ManualMark_upindex));
            listbox_cell{1,1}='MarkTime';
            
            for i=2:(1+length(passdata.ManualMark_upindex))
                listbox_cell{1,i}=num2str(passdata.ManualMark_upindex(i-1));
            end
            if isfield(passdata,'mouseSignindex')
                if ~isempty(passdata.mouseSignindex)
                    index=passdata.mouseSignindex+1;
                else
                    index=1+length(passdata.ManualMark_upindex);
                end
            else
                index=1+length(passdata.ManualMark_upindex);
            end
            set(handles.MarkTime,'String',listbox_cell);
            set(handles.MarkTime,'Value',1);
        else
            listbox_cell=cell(1,1);
            listbox_cell{1,1}='MarkTime';
            set(handles.MarkTime,'String',listbox_cell);
            set(handles.MarkTime,'Value',1);
        end
    elseif passdata.currentmode==3
        
        
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
        videoindex=get(handles.cue_channel,'Value')-1;
        passdata.MarkIndex=sort(passdata.MarkIndex);
        eval(['passdata.videocue' num2str(videoindex) '=passdata.MarkIndex;']);
%         passdata.ManualMark_upindex=passdata.MarkIndex;
        
        if ~isempty(passdata.MarkIndex)
            listbox_cell=cell(1,1+length(passdata.MarkIndex));
            listbox_cell{1,1}='MarkTime';
            
            for i=2:(1+length(passdata.MarkIndex))
                listbox_cell{1,i}=num2str(passdata.MarkIndex(i-1));
            end
            if isfield(passdata,'mouseSignindex')
                if ~isempty(passdata.mouseSignindex)
                    index=passdata.mouseSignindex+1;
                else
                    index=1+length(passdata.MarkIndex);
                end
            else
                index=1+length(passdata.MarkIndex);
            end
            set(handles.MarkTime,'String',listbox_cell);
            set(handles.MarkTime,'Value',1);
        else
            listbox_cell=cell(1,1);
            listbox_cell{1,1}='MarkTime';
            set(handles.MarkTime,'String',listbox_cell);
            set(handles.MarkTime,'Value',1);
        end
    end
end
set(handles.trailfrom1,'String',num2str(1));
set(handles.trailfrom2,'String',num2str(length(passdata.MarkIndex)));

passdata.doubleclick=0;
passdata.mouseSign=0;
passdata.singalclick=0;
end

