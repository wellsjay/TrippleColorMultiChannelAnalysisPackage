function Video_Player(hObject,eventdata,handles,varargin)
%
tic
% global index;
% index=index+1
handles=guidata(gcf);
cal_play_index=handles.cal_play_index;
objindex=get(handles.PlayVideo,'Value');
if objindex==1
    set(handles.slider1,'Value',handles.frame_index);
    video_index=find(handles.video_frame_bine_2-handles.frame_index>=0,1,'first');
    current_frame=handles.frame_index-handles.video_frame_bine(video_index);
    eval(['Current_frame=read(handles.ReaderObj_' num2str(video_index) ',' num2str(current_frame) ');']);
%     axes();
    
    %     drawnow;
    %
    %     %     drawnow update
    %     %    drawnow limitrate nocallbacks
    %     drawnow limitrate
    %      drawnow
    %    refreshdata
    set(handles.current_frame,'String',num2str(handles.videotime(handles.frame_index)));
    %%
    
    if cal_play_index==1
        global passdata
        interval=passdata.interval_cal;
        cal_current=passdata.cal_current;
        if handles.frame_index<handles.video_index
            axes(handles.axes2);
            index_start=handles.start_frame_upindex;
            if index_start<length(cal_current)
                if (handles.frame_upindex2(handles.frame_index))<length(cal_current)
                    t=index_start:1:handles.frame_upindex2(handles.frame_index);
                    t=t*interval;
                    plot(t,cal_current(index_start:handles.frame_upindex2(handles.frame_index))');
                    xlim([index_start*interval index_start*interval+handles.cal_duration_num]);
%                     box off;
                else
                    t=index_start:1:length(cal_current);
                    t=t*interval;
                    plot(t,cal_current(index_start:handles.frame_upindex2(handles.frame_index))');
                    xlim([index_start*interval index_start*interval+handles.cal_duration_num]);
%                     box off;
                end
            end
            
        elseif handles.frame_index>=handles.video_index
            axes(handles.axes2);
            index_end=handles.frame_upindex2(handles.frame_index)*interval;
            index_start=round((index_end-handles.cal_duration_num)/interval);
            if index_start<=0
                index_start=1;
            end
            if index_start<length(cal_current)
                if index_end<=length(cal_current)
                    a=cal_current(index_start:round(index_end/interval))';
                    t=1:1:length(a);
                    t=t*interval+index_start*interval;
                    plot(t,a)                   
                    xlim([t(1) t(end)]);
%                     box off;
                else
                    a=cal_current(index_start:end)';
                    t=1:1:length(a);
                    t=t*interval+index_start*interval;
                    plot(t,a)                    
                    xlim([t(1) t(end)]);
%                      off;
                end
            end
            
        end
    end
    image(handles.axes1,Current_frame);
    set(handles.axes1,'xtick',[],'ytick',[]);
    set(handles.axes2,'xtick',[],'XColor',[1,1,1],'box','off');
%     axis off
    %% ¼ì²â×îºóÒ»Ö¡Í¼Ïñ
    if handles.frame_index<=(handles.frames_all-1)
        handles.frame_index=handles.frame_index+1;
    elseif handles.frame_index==handles.frames_all
        set(handles.PlayVideo,'Value',0);
        set(handles.PlayVideo, 'CData', handles.Unpressed);
        stop(handles.VideoPlayer);
        set(handles.Cue1,'Enable','on');
        set(handles.Cue2,'Enable','on');
        set(handles.Cue3,'Enable','on');
        set(handles.Cue4,'Enable','on');
    end
elseif objindex==0
    stop(handles.VideoPlayer);
    set(handles.PlayVideo,'Value',0);
    set(handles.PlayVideo,'CData',handles.Unpressed);
end
guidata(gcf,handles);
pause(0.01);
toc;
end