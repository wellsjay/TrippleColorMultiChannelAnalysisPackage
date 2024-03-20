clc
ManualMark_on=get(handles.cue_channel,'Value');
calmode=get(handles.calmode_pm,'Value');
switch calmode
    case 1
        modeindex='data405';
        cal=passdata.data405;
    case 2
        modeindex='data470';
        cal=passdata.data470;
    case 3
        modeindex='data580';
        cal=passdata.data580;
end
if ManualMark_on>5
    if isfield(passdata,modeindex) && isfield(passdata,'cue')
        if isfield(passdata,'correction_data')
            if ~isempty(passdata.correction_data)&& ~isempty(passdata.cue)
                t=passdata.interval_cal*(1:1:size(cal,1));
                color=['r','g','b','c','m','y','k'];
                axes(handles.DataPreView_axes);
                xlims=get(handles.DataPreView_axes,'Xlim');
                ylims=get(handles.DataPreView_axes,'Ylim');
                cal_index=get(handles.cal_pm,'Value');
                smoothval=round(get(handles.smooth_sli,'Value'));
                exam=cal(:,passdata.cal_correction_index.cal_index+1);
                %             exam=cal(:,cal_index+1);
                passdata.calfig=plot(t,exam,color(1));
                hold on
                plot(t,passdata.correction_data,color(2));
                hold on
                cue_index=get(handles.cue_channel,'Value')-5;
                
                eval(['exam_upindex=passdata.InputMark.upindex_' num2str(cue_index) ';']);
                if ~isempty(exam_upindex)
                    %                 hold on
                    interval=passdata.interval_cal/(passdata.length_cue/size(cal,1));
                    x=[interval*exam_upindex;interval*exam_upindex];
                    y=ones(size(x));
                    y(1,:)=min(exam);
                    y(2,:)=max(exam);
                    passdata.linefig=line(x,y,'Color','b','LineWidth',1);
                    passdata.MarkIndex=x(1,:);
                    passdata.fpsmark=y;
                elseif isempty(exam_upindex)
                    passdata.MarkIndex=[];
                    passdata.fpsmark=[];
                end
                %%  ����mark
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
                    set(handles.MarkTime,'Max',size(listbox_cell,2));
                    set(handles.MarkTime,'Min',1);
                else
                    listbox_cell=cell(1,1);
                    listbox_cell{1,1}='MarkTime';
                    set(handles.MarkTime,'String',listbox_cell);
                    set(handles.MarkTime,'Value',1);
                    set(handles.MarkTime,'Max',size(listbox_cell,2));
                    set(handles.MarkTime,'Min',1);
                end
                %%
                xlabel('Time (s)');
                hold off
%                 legend('Raw Data','Correction Data');
                zoomindex=get(handles.Zoom_On_radio,'Value');
                if zoomindex==1
                    hA = gca;
                    zoom(hA, 'reset');
                    zoom xon;
                elseif zoomindex==0
                    zoom off;
                    set(gcf,'WindowButtonMotionFcn',{@ButtonMotionFcn,handles},'WindowButtonDownFcn',@ButttonDownFcn,'WindowButtonUpFcn',{@ButttonUpFcn,handles});
                end
                
                if xlims(1)==0&&xlims(2)==1&&ylims(1)==0&&ylims(2)==1
                else
                    set(handles.DataPreView_axes,'Xlim',xlims);
                end
                
                passdata.doubleclick=0;
                passdata.singalclick=0;
                passdata.mouseSign=0;
                
                passdata.maxwave=max(exam);
                passdata.minwave=min(exam);
                passdata.currentmode=1;
                passdata.mode1_channel=cue_index;
            end
        end
        
    end
    if isfield(passdata,modeindex) && ~isfield(passdata,'cue')
        if isfield(passdata,'correction_data')
            if ~isempty(passdata.correction_data)
                t=passdata.interval_cal*(1:1:size(cal,1));
                color=['r','g','b','c','m','y','k'];
                axes(handles.DataPreView_axes);
                cal_index=get(handles.cal_pm,'Value');
                xlims=get(handles.DataPreView_axes,'Xlim');
                ylims=get(handles.DataPreView_axes,'Ylim');
                smoothval=round(get(handles.smooth_sli,'Value'));
                exam=cal(:,passdata.cal_correction_index.cal_index+1);
                passdata.calfig=plot(t,exam,color(1));
                hold on
                plot(t,passdata.correction_data,color(2));
                hold off;
%                 legend('Raw Data','Correction Data');
                zoomindex=get(handles.Zoom_On_radio,'Value');
                if zoomindex==1
                    hA = gca;
                    zoom(hA, 'reset');
                    zoom xon;
                elseif zoomindex==0
                    zoom off;
                    set(gcf,'WindowButtonMotionFcn',{@ButtonMotionFcn,handles},'WindowButtonDownFcn',@ButttonDownFcn,'WindowButtonUpFcn',{@ButttonUpFcn,handles});
                end
                
                if xlims(1)==0&&xlims(2)==1&&ylims(1)==0&&ylims(2)==1
                else
                    set(handles.DataPreView_axes,'Xlim',xlims);
                end
                xlabel('Time (s)');
                passdata.doubleclick=0;
                passdata.singalclick=0;
                passdata.mouseSign=0;
                passdata.MarkIndex=[];
                passdata.fpsmark=[];
                passdata.maxwave=max(exam);
                passdata.minwave=min(exam);
                passdata.currentmode=1;
                cue_index=get(handles.cue_channel,'Value')-5;
                passdata.mode1_channel=cue_index;
            end
        end
    end
elseif ManualMark_on==1
    if isfield(passdata,modeindex)
        if isfield(passdata,'correction_data')
            if ~isempty(passdata.correction_data) && ~isempty(passdata.ManualMark_upindex)
                t=passdata.interval_cal*(1:1:size(cal,1));
                color=['r','g','b','c','m','y','k'];
                axes(handles.DataPreView_axes);
                xlims=get(handles.DataPreView_axes,'Xlim');
                ylims=get(handles.DataPreView_axes,'Ylim');
                cal_index=get(handles.cal_pm,'Value');
                smoothval=round(get(handles.smooth_sli,'Value'));
                exam=cal(:,passdata.cal_correction_index.cal_index+1);
                passdata.calfig=plot(t,exam,color(1));
                hold on
                plot(t,passdata.correction_data,color(2))
                hold on
                x=[passdata.ManualMark_upindex;passdata.ManualMark_upindex];
                y=ones(size(x));
                y(1,:)=min(exam);
                y(2,:)=max(exam);
                passdata.linefig=line(x,y,'Color','b','LineWidth',1);
                xlabel('Time (s)');
                hold off
%                 legend('Raw Data','Correction Data');
                zoomindex=get(handles.Zoom_On_radio,'Value');
                if zoomindex==1
                    hA = gca;
                    zoom(hA, 'reset');
                    zoom xon;
                elseif zoomindex==0
                    zoom off;
                    set(gcf,'WindowButtonMotionFcn',{@ButtonMotionFcn,handles},'WindowButtonDownFcn',@ButttonDownFcn,'WindowButtonUpFcn',{@ButttonUpFcn,handles});
                end
                if xlims(1)==0&&xlims(2)==1&&ylims(1)==0&&ylims(2)==1
                else
                    set(handles.DataPreView_axes,'Xlim',xlims);
                end
                passdata.doubleclick=0;
                passdata.singalclick=0;
                passdata.mouseSign=0;
                passdata.MarkIndex=x(1,:);
                passdata.fpsmark=y;
                passdata.maxwave=max(exam);
                passdata.minwave=min(exam);
                passdata.currentmode=2;
            end
        end
    end
    if isfield(passdata,modeindex) && isempty(passdata.ManualMark_upindex)
        if isfield(passdata,'correction_data')
            if ~isempty(passdata.correction_data)
                t=passdata.interval_cal*(1:1:size(cal,1));
                color=['r','g','b','c','m','y','k'];
                xlims=get(handles.DataPreView_axes,'Xlim');
                ylims=get(handles.DataPreView_axes,'Ylim');
                axes(handles.DataPreView_axes);
                cal_index=get(handles.cal_pm,'Value');
                smoothval=round(get(handles.smooth_sli,'Value'));
                exam=cal(:,passdata.cal_correction_index.cal_index+1);
                passdata.calfig=plot(t,exam,color(1));
                hold on
                plot(t,passdata.correction_data,color(2))
                hold off;
%                 legend('Raw Data','Correction Data');
                xlabel('Time (s)');
                zoomindex=get(handles.Zoom_On_radio,'Value');
                if zoomindex==1
                    hA = gca;
                    zoom(hA, 'reset');
                    zoom xon;
                elseif zoomindex==0
                    zoom off;
                    set(gcf,'WindowButtonMotionFcn',{@ButtonMotionFcn,handles},'WindowButtonDownFcn',@ButttonDownFcn,'WindowButtonUpFcn',{@ButttonUpFcn,handles});
                end
                
                if xlims(1)==0&&xlims(2)==1&&ylims(1)==0&&ylims(2)==1
                else
                    set(handles.DataPreView_axes,'Xlim',xlims);
                end
                
                %%   �趨�ֶ�����Զ�����
                passdata.doubleclick=0;
                passdata.singalclick=0;
                passdata.mouseSign=0;
                passdata.MarkIndex=[];
                passdata.fpsmark=[];
                passdata.maxwave=max(exam);
                passdata.minwave=min(exam);
                passdata.currentmode=2;
            end
        end
        if ~isempty(cal)
            
        end
    end
    %% ����mark��ʾ
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
        set(handles.MarkTime,'Max',size(listbox_cell,2));
        set(handles.MarkTime,'Min',1);
    else
        listbox_cell=cell(1,1);
        listbox_cell{1,1}='MarkTime';
        set(handles.MarkTime,'String',listbox_cell);
        set(handles.MarkTime,'Value',1);
        set(handles.MarkTime,'Max',size(listbox_cell,2));
        set(handles.MarkTime,'Min',1);
    end
    %%
elseif ManualMark_on>1&&ManualMark_on<=5
    videoindex=get(handles.cue_channel,'Value')-1;
    switch videoindex
        case 1
            videomark=passdata.videocue1;
        case 2
            videomark=passdata.videocue2;
        case 3
            videomark=passdata.videocue3;
        case 4
            videomark=passdata.videocue4;
    end
    
    if isfield(passdata,modeindex)
        if isfield(passdata,'correction_data')
            if ~isempty(passdata.correction_data) && ~isempty(videomark)
                t=passdata.interval_cal*(1:1:size(cal,1));
                color=['r','g','b','c','m','y','k'];
                axes(handles.DataPreView_axes);
                xlims=get(handles.DataPreView_axes,'Xlim');
                ylims=get(handles.DataPreView_axes,'Ylim');
                cal_index=get(handles.cal_pm,'Value');
                smoothval=round(get(handles.smooth_sli,'Value'));
                exam=cal(:,passdata.cal_correction_index.cal_index+1);
                passdata.calfig=plot(t,exam,color(1));
                hold on
                plot(t,passdata.correction_data,color(2))
                hold on
                x=[videomark;videomark];
                y=ones(size(x));
                y(1,:)=min(exam);
                y(2,:)=max(exam);
                passdata.linefig=line(x,y,'Color','b','LineWidth',1);
                xlabel('Time (s)');
                hold off
%                 legend('Raw Data','Correction Data');
                zoomindex=get(handles.Zoom_On_radio,'Value');
                if zoomindex==1
                    hA = gca;
                    zoom(hA, 'reset');
                    zoom xon;
                elseif zoomindex==0
                    zoom off;
                    set(gcf,'WindowButtonMotionFcn',{@ButtonMotionFcn,handles},'WindowButtonDownFcn',@ButttonDownFcn,'WindowButtonUpFcn',{@ButttonUpFcn,handles});
                end
                if xlims(1)==0&&xlims(2)==1&&ylims(1)==0&&ylims(2)==1
                else
                    set(handles.DataPreView_axes,'Xlim',xlims);
                end
                passdata.doubleclick=0;
                passdata.singalclick=0;
                passdata.mouseSign=0;
                passdata.MarkIndex=x(1,:);
                passdata.fpsmark=y;
                passdata.maxwave=max(exam);
                passdata.minwave=min(exam);
                passdata.currentmode=2;
            end
        end
    end
    if isfield(passdata,modeindex) && isempty(videomark)
        if isfield(passdata,'correction_data')
            if ~isempty(passdata.correction_data)
                t=passdata.interval_cal*(1:1:size(cal,1));
                color=['r','g','b','c','m','y','k'];
                xlims=get(handles.DataPreView_axes,'Xlim');
                ylims=get(handles.DataPreView_axes,'Ylim');
                axes(handles.DataPreView_axes);
                cal_index=get(handles.cal_pm,'Value');
                smoothval=round(get(handles.smooth_sli,'Value'));
                exam=cal(:,passdata.cal_correction_index.cal_index+1);
                passdata.calfig=plot(t,exam,color(1));
                hold on
                plot(t,passdata.correction_data,color(2))
                hold off;
%                 legend('Raw Data','Correction Data');
                xlabel('Time (s)');
                zoomindex=get(handles.Zoom_On_radio,'Value');
                if zoomindex==1
                    hA = gca;
                    zoom(hA, 'reset');
                    zoom xon;
                elseif zoomindex==0
                    zoom off;
                    set(gcf,'WindowButtonMotionFcn',{@ButtonMotionFcn,handles},'WindowButtonDownFcn',@ButttonDownFcn,'WindowButtonUpFcn',{@ButttonUpFcn,handles});
                end
                
                if xlims(1)==0&&xlims(2)==1&&ylims(1)==0&&ylims(2)==1
                else
                    set(handles.DataPreView_axes,'Xlim',xlims);
                end
                
                %%   �趨�ֶ�����Զ�����
                passdata.doubleclick=0;
                passdata.singalclick=0;
                passdata.mouseSign=0;
                passdata.MarkIndex=[];
                passdata.fpsmark=[];
                passdata.maxwave=max(exam);
                passdata.minwave=min(exam);
                passdata.currentmode=2;
            end
        end

    end
    %% ����mark��ʾ
    if ~isempty(videomark)
        
        videomark=sort(videomark);
        listbox_cell=cell(1,1+length(videomark));
        listbox_cell{1,1}='MarkTime';
        
        for i=2:(1+length(videomark))
            listbox_cell{1,i}=num2str(videomark(i-1));
        end
        if isfield(passdata,'mouseSignindex')
            if ~isempty(passdata.mouseSignindex)
                index=passdata.mouseSignindex+1;
            else
                index=1+length(videomark);
            end
        else
            index=1+length(videomark);
        end
        set(handles.MarkTime,'String',listbox_cell);
        set(handles.MarkTime,'Value',1);
        set(handles.MarkTime,'Max',size(listbox_cell,2));
        set(handles.MarkTime,'Min',1);
    else
        listbox_cell=cell(1,1);
        listbox_cell{1,1}='MarkTime';
        set(handles.MarkTime,'String',listbox_cell);
        set(handles.MarkTime,'Value',1);
        set(handles.MarkTime,'Max',size(listbox_cell,2));
        set(handles.MarkTime,'Min',1);
    end
end
set(handles.trailfrom1,'String',num2str(1));
set(handles.trailfrom2,'String',num2str(length(passdata.MarkIndex)));