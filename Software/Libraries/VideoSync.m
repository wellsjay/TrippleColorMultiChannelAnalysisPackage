function varargout = VideoSync(varargin)
% VIDEOSYNC MATLAB code for VideoSync.fig
%      VIDEOSYNC, by itself, creates a new VIDEOSYNC or raises the existing
%      singleton*.
%
%      H = VIDEOSYNC returns the handle to a new VIDEOSYNC or the handle to
%      the existing singleton*.
%
%      VIDEOSYNC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIDEOSYNC.M with the given input arguments.
%
%      VIDEOSYNC('Property','Value',...) creates a new VIDEOSYNC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before VideoSync_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to VideoSync_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help VideoSync

% Last Modified by GUIDE v2.5 16-Mar-2023 14:45:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @VideoSync_OpeningFcn, ...
                   'gui_OutputFcn',  @VideoSync_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before VideoSync is made visible.
function VideoSync_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to VideoSync (see VARARGIN)

% Choose default command line output for VideoSync
handles.output = hObject;
% global passdata;
% passdata.videocue1=[];
% passdata.videocue2=[];
% passdata.videocue3=[];
% passdata.videocue4=[];
handles.videocue1=[];
handles.videocue2=[];
handles.videocue3=[];
handles.videocue4=[];

handles.Unpressed = imread('Start.PNG');
handles.Pressed = imread('Stop.PNG');
set(handles.PlayVideo, 'CData', handles.Unpressed);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes VideoSync wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = VideoSync_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in PlayVideo.
function PlayVideo_Callback(hObject, eventdata, handles)
% hObject    handle to PlayVideo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
global passdata
handles=guidata(hObject);
if ~isfield(handles,'ReaderObj_1')
    msgbox('请选择视频数据之后再使用该功能！！！');
    return
end

if ~isfield(handles,'timedata')
    msgbox('请选择视频的时间数据之后使用该功能');
    return
end
if ~isfield(passdata,'time0')
    msgbox('请读取钙信号的时间文件之后使用该功能');
    return
end

if get(handles.PlayVideo,'Value')==1
    clc
    if handles.cal_play_index==1
%         cal_current=passdata.cal_current;
        interval=passdata.interval_cal;
        cal_duration=str2num(get(handles.cal_duration,'String'));
        cal_duration_index=cal_duration/interval;
        handles.cal_duration_num=cal_duration;
        examp=abs(handles.frame_upindex2-handles.frame_upindex2(1)-cal_duration_index);
        handles.video_index= find(examp==min(examp));%I
    end
    handles.frame_index=round(get(handles.slider1,'Value'));
    %%
    video_index=find(handles.video_frame_bine_2-handles.frame_index>=0,1,'first');
    current_frame=handles.frame_index-handles.video_frame_bine(video_index); 
    eval(['handles.Current_frame=read(handles.ReaderObj_' num2str(video_index) ',' num2str(current_frame) ');']);
    %%
    guidata(hObject,handles);
    set(handles.PlayVideo,'CData', handles.Pressed);
    set(handles.Cue1,'Enable','off');
    set(handles.Cue2,'Enable','off');
    set(handles.Cue3,'Enable','off');
    set(handles.Cue4,'Enable','off');
    guidata(hObject,handles);
    axes(handles.axes1);
    start(handles.VideoPlayer);
    tic
elseif get(handles.PlayVideo,'Value')==0
    set(handles.Cue1,'Enable','on');
    set(handles.Cue2,'Enable','on');
    set(handles.Cue3,'Enable','on');
    set(handles.Cue4,'Enable','on');
    handles.VideoPlayer=timerfind;
    set(handles.PlayVideo,'CData', handles.Unpressed);
    stop(handles.VideoPlayer);
end




% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
if ~isfield(handles,'ReaderObj_1')
    msgbox('请选择视频数据之后再使用该功能！！！');
    return
end
global passdata
%% 停止播放视频
set(handles.PlayVideo,'CData', handles.Unpressed);
set(handles.PlayVideo,'Value',0);
stop(handles.VideoPlayer);
%% 设置滑动条
slider_frame_index=round(get(handles.slider1,'Value'));
set(handles.slider1,'Value',slider_frame_index);
%% 计算当前图像帧
handles.frame_index=slider_frame_index;
video_frame_bine=handles.video_frame_bine;
video_frame_bine_2=video_frame_bine(2:end);
video_index=find(video_frame_bine_2-handles.frame_index>=0,1,'first');
current_frame=handles.frame_index-video_frame_bine(video_index);
eval(['Current_frame=read(handles.ReaderObj_' num2str(video_index) ',' num2str(current_frame) ');']);
% axes(handles.axes1);
% imshow(Current_frame);
%% 钙信号显示
% set(handles.axes1,'xtick',[],'ytick',[]);
% set(handles.axes2,'xtick',[],'XColor',[1,1,1],'box','off');
cal_play_index=handles.cal_play_index;
if cal_play_index==1
    interval=passdata.interval_cal;
    cal_current=passdata.cal_current;
    cal_duration=str2num(get(handles.cal_duration,'String'));
    cal_duration_index=cal_duration/interval;
    handles.cal_duration_num=cal_duration;
    examp=abs(handles.frame_upindex2-handles.frame_upindex2(1)-cal_duration_index);
    handles.video_index= find(examp==min(examp));%I
    handles.video_index=handles.video_index(1);
    if cal_play_index==1
        %% handles.frame_index存储当前视频帧    handles.video_index存储的是cal duration分界凌
        if (handles.frame_index-handles.start_frame_upindex)<handles.video_index && (handles.frame_index-handles.start_frame_upindex)>0
            axes(handles.axes2);
            index_start=handles.start_frame_upindex;
            
            if index_start<length(cal_current)
                if (handles.frame_upindex2(handles.frame_index))<length(cal_current)
                    t=index_start:1:handles.frame_upindex2(handles.frame_index);
                    t=t*interval;
                    plot(t,cal_current(index_start:handles.frame_upindex2(handles.frame_index))');
                    xlim([index_start*interval index_start*interval+handles.cal_duration_num]);
                else
                    t=index_start:1:length(cal_current);
                    t=t*interval;
                    plot(t,cal_current(index_start:handles.frame_upindex2(handles.frame_index))');
                    xlim([index_start*interval index_start*interval+handles.cal_duration_num]);
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
                else
                    a=cal_current(index_start:end)';
                    t=1:1:length(a);
                    t=t*interval+index_start*interval;
                    plot(t,a)                    
                    xlim([t(1) t(end)]);
                end
            end
        elseif (handles.frame_index-handles.start_frame_upindex)<=0
            
        end
    end
end
image(handles.axes1,Current_frame);
set(handles.axes1,'xtick',[],'ytick',[]);
set(handles.axes2,'xtick',[],'XColor',[1,1,1],'box','off');
%% 恢复按钮控制
set(handles.current_frame,'String',num2str(handles.videotime(handles.frame_index)));
set(handles.Cue1,'Enable','on');
set(handles.Cue2,'Enable','on');
set(handles.Cue3,'Enable','on');
set(handles.Cue4,'Enable','on');
disp(['the number of frame_index =' num2str(handles.frame_index) ';']);
guidata(hObject, handles);



% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in Cue1.
function Cue1_Callback(hObject, eventdata, handles)
% hObject    handle to Cue1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
global passdata;
handles=guidata(hObject);
if ~isfield(handles,'ReaderObj_1')
    msgbox('请选择视频数据之后再使用该功能！！！');
    return
end
if ~isfield(handles,'timedata')
    msgbox('请选择视频的时间数据之后使用该功能');
    return
end
if ~isfield(passdata,'time0')
    msgbox('请读取钙信号的时间文件之后使用该功能');
    return
end
%% 检测播放器状态
if get(handles.PlayVideo,'Value')~=0
    return
end
frame_index=handles.frame_index;
% Event_time=handles.timedata(frame_index);
% time0=passdata.time0;
% %%
% exam=handles.timedata{frame_index,1};
% index1=find(exam(:)==' ');
% index2=find(exam(:)=='.');
% if index2(1)-index1==2
%     time_shi=['0' exam(index1+1:index2(1)-1)];
% else
%     time_shi=exam(index1+1:index2(1)-1);
% end
% if index2(2)-index2(1)==2
%     time_fen=['0' exam(index2(1)+1:index2(2)-1)];
% else
%     time_fen=exam(index2(1)+1:index2(2)-1);
% end
% 
% if index2(3)-index2(2)==2
%     time_miao=['0' exam(index2(2)+1:index2(3)-1)];
% else
%     time_miao=exam(index2(2)+1:index2(3)-1);
% end
% if length(exam)-index2(3)==2
%     time_haomiao=['0' exam(index2(3)+1:end)];
% elseif length(exam)-index2(3)==1
%     time_haomiao=['00' exam(index2(3)+1:end)];
% else
%     time_haomiao=exam(index2(3)+1:end);
% end
% exam=[exam(1:index1) time_shi '.' time_fen '.' time_miao '.' time_haomiao];
% Event_time=datenum(exam,'yyyy-mm-dd HH.MM.SS.FFF'); 
%%
% Event_time=datenum(Event_time,'yyyy-mm-dd HH.MM.SS.FFF');
Event_time=handles.timedata(frame_index);
time_cal_duration=passdata.time_duration;
if Event_time<=0||Event_time>=time_cal_duration
    msgbox('操作失败!! 当前时间点超出了钙信号的实际采集时间，请重新设置 !!!');
    return
end
handles.videocue1=[handles.videocue1,Event_time];
guidata(hObject,handles);
msgbox('VideoCue1 打标设置成功!!!!');



% --- Executes on button press in Cue2.
function Cue2_Callback(hObject, eventdata, handles)
% hObject    handle to Cue2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
global passdata;
handles=guidata(hObject);
if ~isfield(handles,'ReaderObj_1')
    msgbox('请选择视频数据之后再使用该功能！！！');
    return
end
if ~isfield(handles,'timedata')
    msgbox('请选择视频的时间数据之后使用该功能');
    return
end
if ~isfield(passdata,'time0')
    msgbox('请读取钙信号的时间文件之后使用该功能');
    return
end
%% 检测播放器状态
if get(handles.PlayVideo,'Value')~=0
    return
end
frame_index=handles.frame_index;
Event_time=handles.timedata(frame_index);
% time0=passdata.time0;
% %%
% exam=handles.timedata{frame_index,1};
% index1=find(exam(:)==' ');
% index2=find(exam(:)=='.');
% if index2(1)-index1==2
%     time_shi=['0' exam(index1+1:index2(1)-1)];
% else
%     time_shi=exam(index1+1:index2(1)-1);
% end
% if index2(2)-index2(1)==2
%     time_fen=['0' exam(index2(1)+1:index2(2)-1)];
% else
%     time_fen=exam(index2(1)+1:index2(2)-1);
% end
% 
% if index2(3)-index2(2)==2
%     time_miao=['0' exam(index2(2)+1:index2(3)-1)];
% else
%     time_miao=exam(index2(2)+1:index2(3)-1);
% end
% if length(exam)-index2(3)==2
%     time_haomiao=['0' exam(index2(3)+1:end)];
% elseif length(exam)-index2(3)==1
%     time_haomiao=['00' exam(index2(3)+1:end)];
% else
%     time_haomiao=exam(index2(3)+1:end);
% end
% exam=[exam(1:index1) time_shi '.' time_fen '.' time_miao '.' time_haomiao];
% Event_time=datenum(exam,'yyyy-mm-dd HH.MM.SS.FFF'); 
% %%
% % Event_time=datenum(Event_time,'yyyy-mm-dd HH.MM.SS.FFF');
% Event_time=(Event_time-time0)*24*60*60;
time_cal_duration=passdata.time_duration;
if Event_time<=0||Event_time>=time_cal_duration
    msgbox('操作失败!! 当前时间点超出了钙信号的实际采集时间，请重新设置 !!! !!!');
    return
end
handles.videocue2=[handles.videocue2,Event_time];

guidata(hObject,handles);
msgbox('VideoCue2 打标设置成功 !!!!');


% --- Executes on button press in Cue3.
function Cue3_Callback(hObject, eventdata, handles)
% hObject    handle to Cue3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
global passdata;
handles=guidata(hObject);
if ~isfield(handles,'ReaderObj_1')
    msgbox('请选择视频数据之后再使用该功能！！！');
    return
end
if ~isfield(handles,'timedata')
    msgbox('请选择视频的时间数据之后使用该功能');
    return
end
if ~isfield(passdata,'time0')
    msgbox('请读取钙信号的时间文件之后使用该功能');
    return
end
%% 检测播放器状态
if get(handles.PlayVideo,'Value')~=0
    return
end
frame_index=handles.frame_index;
Event_time=handles.timedata(frame_index);
%%
% exam=handles.timedata{frame_index,1};
% index1=find(exam(:)==' ');
% index2=find(exam(:)=='.');
% if index2(1)-index1==2
%     time_shi=['0' exam(index1+1:index2(1)-1)];
% else
%     time_shi=exam(index1+1:index2(1)-1);
% end
% if index2(2)-index2(1)==2
%     time_fen=['0' exam(index2(1)+1:index2(2)-1)];
% else
%     time_fen=exam(index2(1)+1:index2(2)-1);
% end
% 
% if index2(3)-index2(2)==2
%     time_miao=['0' exam(index2(2)+1:index2(3)-1)];
% else
%     time_miao=exam(index2(2)+1:index2(3)-1);
% end
% if length(exam)-index2(3)==2
%     time_haomiao=['0' exam(index2(3)+1:end)];
% elseif length(exam)-index2(3)==1
%     time_haomiao=['00' exam(index2(3)+1:end)];
% else
%     time_haomiao=exam(index2(3)+1:end);
% end
% exam=[exam(1:index1) time_shi '.' time_fen '.' time_miao '.' time_haomiao];
% Event_time=datenum(exam,'yyyy-mm-dd HH.MM.SS.FFF'); 
% %%
% % Event_time=datenum(Event_time,'yyyy-mm-dd HH.MM.SS.FFF');
% time0=passdata.time0;
% Event_time=(Event_time-time0)*24*60*60;
time_cal_duration=passdata.time_duration;
if Event_time<=0||Event_time>=time_cal_duration
    msgbox('操作失败!! 当前时间点超出了钙信号的实际采集时间，请重新设置 !!!');
    return
end
handles.videocue3=[handles.videocue3,Event_time];

guidata(hObject,handles);
msgbox('VideoCue3 打标设置成功 !!!!');


% --- Executes on button press in Cue4.
function Cue4_Callback(hObject, eventdata, handles)
% hObject    handle to Cue4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
global passdata;
handles=guidata(hObject);
if ~isfield(handles,'ReaderObj_1')
    msgbox('请选择视频数据之后再使用该功能！！！');
    return
end
if ~isfield(handles,'timedata')
    msgbox('请选择视频的时间数据之后使用该功能');
    return
end
if ~isfield(passdata,'time0')
    msgbox('请读取钙信号的时间文件之后使用该功能');
    return
end
%% 检测播放器状态
if get(handles.PlayVideo,'Value')~=0
    return
end
frame_index=handles.frame_index;
Event_time=handles.timedata(frame_index);
%%
% exam=handles.timedata{frame_index,1};
% index1=find(exam(:)==' ');
% index2=find(exam(:)=='.');
% if index2(1)-index1==2
%     time_shi=['0' exam(index1+1:index2(1)-1)];
% else
%     time_shi=exam(index1+1:index2(1)-1);
% end
% if index2(2)-index2(1)==2
%     time_fen=['0' exam(index2(1)+1:index2(2)-1)];
% else
%     time_fen=exam(index2(1)+1:index2(2)-1);
% end
% 
% if index2(3)-index2(2)==2
%     time_miao=['0' exam(index2(2)+1:index2(3)-1)];
% else
%     time_miao=exam(index2(2)+1:index2(3)-1);
% end
% if length(exam)-index2(3)==2
%     time_haomiao=['0' exam(index2(3)+1:end)];
% elseif length(exam)-index2(3)==1
%     time_haomiao=['00' exam(index2(3)+1:end)];
% else
%     time_haomiao=exam(index2(3)+1:end);
% end
% exam=[exam(1:index1) time_shi '.' time_fen '.' time_miao '.' time_haomiao];
% Event_time=datenum(exam,'yyyy-mm-dd HH.MM.SS.FFF'); 
% %%
% % Event_time=datenum(Event_time,'yyyy-mm-dd HH.MM.SS.FFF');
% time0=passdata.time0;
% Event_time=(Event_time-time0)*24*60*60;
time_cal_duration=passdata.time_duration;
if Event_time<=0||Event_time>=time_cal_duration
    msgbox('操作失败!! 当前时间点超出了钙信号的实际采集时间，请重新设置 !!!');
    return
end
handles.videocue4=[handles.videocue4,Event_time];
guidata(hObject,handles);
msgbox('VideoCue4 打标设置成功 !!!!');




function current_frame_Callback(hObject, eventdata, handles)
% hObject    handle to current_frame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function current_frame_CreateFcn(hObject, eventdata, handles)
% hObject    handle to current_frame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in GoTo.
function GoTo_Callback(hObject, eventdata, handles)
% hObject    handle to GoTo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
global passdata
handles=guidata(hObject);
if ~isfield(handles,'ReaderObj_1')
    msgbox('请读取视频数据之后再使用该功能！！！');
    return
end

%% 设置滑动条
slider_frame_index=round(str2num(get(handles.current_frame,'String')));
if isempty(slider_frame_index)
    return
else
    if (slider_frame_index>handles.videotime(end))||(slider_frame_index<=0)
        return
    end
end
slider_frame_index=find(abs(slider_frame_index-handles.videotime)==min(abs(slider_frame_index-handles.videotime)));
slider_frame_index=slider_frame_index(1);
set(handles.slider1,'Value',slider_frame_index);
%% 停止播放视频
set(handles.PlayVideo,'CData', handles.Unpressed);
set(handles.PlayVideo,'Value',0);
stop(handles.VideoPlayer);
%% 计算当前图像帧
handles.frame_index=slider_frame_index;
video_frame_bine=handles.video_frame_bine;
video_frame_bine_2=video_frame_bine(2:end);
video_index=find(video_frame_bine_2-handles.frame_index>=0,1,'first');
current_frame=handles.frame_index-video_frame_bine(video_index);
eval(['Current_frame=read(handles.ReaderObj_' num2str(video_index) ',' num2str(current_frame) ');']);


%% 钙信号显示

cal_play_index=handles.cal_play_index;
if cal_play_index==1
    interval=passdata.interval_cal;
    cal_current=passdata.cal_current;
    cal_duration=str2num(get(handles.cal_duration,'String'));
    cal_duration_index=cal_duration/interval;
    handles.cal_duration_num=cal_duration;
    examp=abs(handles.frame_upindex2-handles.frame_upindex2(1)-cal_duration_index);
    handles.video_index= find(examp==min(examp));%I
    handles.video_index=handles.video_index(1);
    if cal_play_index==1
 
        if (handles.frame_index-handles.start_frame_upindex)<handles.video_index && (handles.frame_index-handles.start_frame_upindex)>0
            axes(handles.axes2);
            index_start=handles.start_frame_upindex;
            
            if index_start<length(cal_current)
                if (handles.frame_upindex2(handles.frame_index))<length(cal_current)
                    t=index_start:1:handles.frame_upindex2(handles.frame_index);
                    t=t*interval;
                    plot(t,cal_current(index_start:handles.frame_upindex2(handles.frame_index))');
                    xlim([index_start*interval index_start*interval+handles.cal_duration_num]);
                else
                    t=index_start:1:length(cal_current);
                    t=t*interval;
                    plot(t,cal_current(index_start:handles.frame_upindex2(handles.frame_index))');
                    xlim([index_start*interval index_start*interval+handles.cal_duration_num]);
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
                else
                    a=cal_current(index_start:end)';
                    t=1:1:length(a);
                    t=t*interval+index_start*interval;
                    plot(t,a)                    
                    xlim([t(1) t(end)]);
                end
            end
        elseif (handles.frame_index-handles.start_frame_upindex)<=0
            
        end
    end
end
image(handles.axes1,Current_frame);
set(handles.axes1,'xtick',[],'ytick',[]);
set(handles.axes2,'xtick',[],'XColor',[1,1,1],'box','off');
%% 恢复按钮控制
set(handles.current_frame,'String',num2str(handles.videotime(handles.frame_index)));
set(handles.Cue1,'Enable','on');
set(handles.Cue2,'Enable','on');
set(handles.Cue3,'Enable','on');
set(handles.Cue4,'Enable','on');
disp(['the number of frame_index =' num2str(handles.frame_index) ';']);
guidata(hObject, handles);



% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over slider1.


% --------------------------------------------------------------------
function LoadVideo_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to LoadVideo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%   读取Video数据
clc
handles=guidata(hObject);
global passdata;
if ~isfield(handles,'timedata')
    msgbox('请先读取视频同步软件生成的钙信号文件，在读取视频！！！');
    return
end

if isfield(passdata,'readpath')
    [filename,filepath]=uigetfile({'*.avi';'*.mp4'},'Open Video data','MultiSelect','on',passdata.readpath);
else
    [filename,filepath]=uigetfile({'*.avi';'*.mp4'},'Open Video data','MultiSelect','on');
end
if isequal(filename,0)
    return;
end
passdata.readpath=filepath(1:end-1);
%% 控制按钮操作
set(handles.Cue1,'Enable','off');
set(handles.Cue2,'Enable','off');
set(handles.Cue3,'Enable','off');
set(handles.Cue4,'Enable','off');
set(handles.PlayVideo,'Enable','off');
set(handles.LoadVideo,'Enable','off');
set(handles.slider1,'Enable','off');
%% end
if ischar(filename)
    VideoNum=1;
    pathstring=[filepath,filename];
    [~,~,part]=fileparts(pathstring);
    if ~strcmp(part,'.avi')&& ~strcmp(part,'.mp4')
        msgbox('请读取avi或者mp4格式的视频文件 !!');
        return
    end
    handles.ReaderObj_1=VideoReader(pathstring);
    %% 记录视频的帧数
    video_frame_num=zeros(VideoNum,1);
    video_frame_num(1,1)=handles.ReaderObj_1.NumberOfFrames;
else
    VideoNum=size(filename,2);
    %% 记录视频的帧数
    video_frame_num=zeros(VideoNum,1);
    for i=1:VideoNum
        pathstring=[filepath filename{i}];
        [~,~,part]=fileparts(pathstring);
        if ~strcmp(part,'.avi')&& ~strcmp(part,'.mp4')
            msgbox('请读取avi或者mp4格式的视频文件 !!');
            return
        end
        ReaderObj=VideoReader(pathstring);
        eval(['handles.ReaderObj_' num2str(i) '=ReaderObj;']);
        eval(['video_frame_num(' num2str(i) ')=handles.ReaderObj_' num2str(i) '.NumberOfFrames;']);
    end
end
handles.video_frame_num=video_frame_num;
handles.VideoNum=VideoNum;
handles.frames_all=sum(video_frame_num);
%% 播放钙信号模块
if sum(video_frame_num)~=length(handles.timedata)
    if abs(length(handles.timedata)-sum(video_frame_num))>5
        choice=questdlg('The video frames are not equal to the Sync_Num, whether to reselect the video !!!','Selection Dialog','Yes','No','No');
        switch choice
            case 'Yes'
                handles.cal_play_index=0;
                set(handles.Cue1,'Enable','on');
                set(handles.Cue2,'Enable','on');
                set(handles.Cue3,'Enable','on');
                set(handles.Cue4,'Enable','on');
                set(handles.PlayVideo,'Enable','on');
                set(handles.LoadVideo,'Enable','on');
                set(handles.slider1,'Enable','on');
                return
            case 'No'
                handles.cal_play_index=0;
        end
        
    else
        handles.cal_play_index=1;
        handles.frame_upindex2=round(handles.timedata/passdata.interval_cal);
        handles.frame_upindex2(handles.frame_upindex2(:)<=0)=0;
        index=find(handles.frame_upindex2>0);
        if isempty(index)
            handles.cal_play_index=0;
        else
            handles.start_frame_upindex=handles.frame_upindex2(index(1));
            handles.end_frame_upindex=handles.frame_upindex2(end);
        end
    end
    %% 定义
    %   handles.frame_upindex2存储的视频同步的时间/interval，也即在钙信号中的编号；
    %   
    %%
    %%
else
    handles.cal_play_index=1;
    handles.frame_upindex2=round(handles.timedata/passdata.interval_cal);
    handles.frame_upindex2(handles.frame_upindex2(:)<=0)=0;
    index=find(handles.frame_upindex2>0);
    if isempty(index)
        handles.cal_play_index=0;
    else
        handles.start_frame_upindex=handles.frame_upindex2(index(1));
        handles.end_frame_upindex=handles.frame_upindex2(end);
    end
%         
%     handles.start_frame_upindex=handles.frame_upindex2(1);
%     handles.end_frame_upindex=handles.frame_upindex2(end);
end
%% 记录前n个视频的帧数总和
for i=1:VideoNum
    video_frame_bine(i+1)=sum(video_frame_num(1:i));
end
handles.video_frame_bine=video_frame_bine;
handles.video_frame_bine_2=video_frame_bine(2:end);
guidata(hObject,handles);
%%
Current_frame = read(handles.ReaderObj_1,1);
%% 定时器
handles.VideoPlayer=timer;
timerPeriod=1/30;
%% 设置滑动条
set(handles.slider1,'Max',handles.frames_all);
set(handles.slider1,'Min',1);
set(handles.slider1,'Value',1);
set(handles.slider1,'SliderStep',[1/(handles.frames_all-1), 1/(handles.frames_all-1)]);
%% 
set(handles.current_frame,'String',num2str(handles.videotime(1)));
set(handles.VideoPlayer,'Period',timerPeriod,'TimerFcn',{@Video_Player,handles},'ExecutionMode','fixedRate');
axes(handles.axes1);
imshow(Current_frame);
handles.frame_index=1;
%% 按钮恢复控制
set(handles.PlayVideo,'CData', handles.Unpressed);
set(handles.PlayVideo,'Value',0);
set(handles.Cue1,'Enable','on');
set(handles.Cue2,'Enable','on');
set(handles.Cue3,'Enable','on');
set(handles.Cue4,'Enable','on');
set(handles.PlayVideo,'Enable','on');
set(handles.LoadVideo,'Enable','on');
set(handles.slider1,'Enable','on');
%%
guidata(hObject,handles);
msgbox('视频读取成功 !!!!!');


% --------------------------------------------------------------------
function LoadTimeStamp_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to LoadTimeStamp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%   读取TXT数据
clc
global passdata;
handles=guidata(hObject);

if ~isfield(passdata,'time0')
    msgbox('请读取钙信号的时间文件之后使用该功能');
    return
end

if isfield(passdata,'readpath')
    [filenametxt,filepathtxt]=uigetfile({'*.TXT'},'Open txt_data file','MultiSelect','off',passdata.readpath);
else
    [filenametxt,filepathtxt]=uigetfile({'*.TXT'},'Open txt_data file','MultiSelect','off');
end
if isequal(filenametxt,0)
    return;
end
fullfiletxt=fullfile(filepathtxt,filenametxt);
[~,~,file_part_trail]=fileparts(fullfiletxt);
passdata.readpath=filepathtxt(1:end-1);
if ~strcmp(file_part_trail,'.TXT') && ~strcmp(file_part_trail,'.txt')
    msgbox('操作失败，请读取正确的视频时间文件  !!!!');
    return;
end


set(handles.LoadVideo,'Enable','off');
timedata=importdata(fullfiletxt);
Event_time=zeros(length(timedata),1);
% handles.timedata=zeros(length(timedata),1);
handles.videotime=zeros(length(timedata),1);
h=waitbar(0,'文本文件读取中，请稍等..........');
waitbar(1/100,h);
for i=1:length(timedata)
    if i==1
        exam=timedata{i,1};
        index1=find(exam(:)==' ');
        index2=find(exam(:)=='.');
        if index2(1)-index1==2
            time_shi=['0' exam(index1+1:index2(1)-1)];
        else
            time_shi=exam(index1+1:index2(1)-1);
        end
        if index2(2)-index2(1)==2
            time_fen=['0' exam(index2(1)+1:index2(2)-1)];
        else
            time_fen=exam(index2(1)+1:index2(2)-1);
        end
        
        if index2(3)-index2(2)==2
            time_miao=['0' exam(index2(2)+1:index2(3)-1)];
        else
            time_miao=exam(index2(2)+1:index2(3)-1);
        end
        if length(exam)-index2(3)==2
            time_haomiao=['0' exam(index2(3)+1:end)];
        elseif length(exam)-index2(3)==1
            time_haomiao=['00' exam(index2(3)+1:end)];
        else
            time_haomiao=exam(index2(3)+1:end);
        end
        exam=[exam(1:index1) time_shi '.' time_fen '.' time_miao '.' time_haomiao];
        Event_time(i)=datenum(exam,'yyyy-mm-dd HH.MM.SS.FFF');
        Event_time(i)=(Event_time(i)-passdata.time0)*24*60*60;
        last_sec=(exam(end-5:end-4));
        %         str_ms=timedata{i,1}(end-3:end);
        last_ms=str2num(exam(end-2:end));
        %     end
    elseif i>1
        exam=timedata{i,1};
        index1=find(exam(:)==' ');
        index2=find(exam(:)=='.');
        if index2(1)-index1==2
            time_shi=['0' exam(index1+1:index2(1)-1)];
        else
            time_shi=exam(index1+1:index2(1)-1);
        end
        if index2(2)-index2(1)==2
            time_fen=['0' exam(index2(1)+1:index2(2)-1)];
        else
            time_fen=exam(index2(1)+1:index2(2)-1);
        end
        
        if index2(3)-index2(2)==2
            time_miao=['0' exam(index2(2)+1:index2(3)-1)];
        else
            time_miao=exam(index2(2)+1:index2(3)-1);
        end
        if length(exam)-index2(3)==2
            time_haomiao=['0' exam(index2(3)+1:end)];
        elseif length(exam)-index2(3)==1
            time_haomiao=['00' exam(index2(3)+1:end)];
        else
            time_haomiao=exam(index2(3)+1:end);
        end
        exam=[exam(1:index1) time_shi '.' time_fen '.' time_miao '.' time_haomiao];
        
        string_sec=(exam(end-5:end-4));
        %         str_ms=timedata{i,1}(end-3:end);
        time_ms=str2num(exam(end-2:end));
        if last_sec==string_sec
            Event_time(i)=Event_time(i-1)+(time_ms-last_ms)/1000;
            last_sec=string_sec;
            last_ms=time_ms;
        else
            %                 index=index+1;
            Event_time(i)=Event_time(i-1)+1+(time_ms-last_ms)/1000;
            last_sec=string_sec;
            last_ms=time_ms;
        end
    end
    if i==fix(length(timedata)/4)||i==fix(length(timedata)/3)||i==fix(length(timedata)/2)||i==length(timedata)
        waitbar(i/(length(timedata)),h);
    end
end
close(h)
clear timedata;
% handles.timedata=(Event_time-passdata.time0)*24*60*60;
handles.timedata=Event_time;
handles.videotime=Event_time-Event_time(1)+(1/30);
set(handles.LoadVideo,'Enable','on');
guidata(hObject,handles);
msgbox('时间文件读取成功 !!!');
guidata(hObject,handles);

%% end


% --- Executes on button press in SaveVideoMark.
function SaveVideoMark_Callback(hObject, eventdata, handles)
% hObject    handle to SaveVideoMark (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
handles=guidata(hObject);
global passdata
if isempty(handles.videocue1)&&isempty(handles.videocue2)&&isempty(handles.videocue3)&&isempty(handles.videocue4)
    msgbox('未检测到视频打标标记点，请重新设置！！！');
    return;
end
data.videocue1=handles.videocue1;
data.videocue2=handles.videocue2;
data.videocue3=handles.videocue3;
data.videocue4=handles.videocue4;

passdata.videocue1=handles.videocue1;
passdata.videocue2=handles.videocue2;
passdata.videocue3=handles.videocue3;
passdata.videocue4=handles.videocue4;

if isfield(passdata,'file_path_and_name_cal')
    name=strrep(passdata.file_path_and_name_cal,passdata.file_part_cal,'_Videomark.mat');
else
    name=[passdata.readpath,'\Videomark.mat'];
%     name=save(strrep(passdata.file_path_and_name_cal,passdata.file_part_cal,'_Videomark.mat'),'data');
end

dig=['是否想要另存为数据？如果选择no，文件将保存在 ' name '!!!'];
choice=questdlg(dig, ...
    'Selection Dialog', ...
    'Yes', 'No','No');

if isempty(choice)
    save(name,'data');
else
    if strcmp(choice,'No')
        save(name,'data');
    elseif strcmp(choice,'Yes')
        [SaveFileName,SavePathName,SaveIndex] = uiputfile('*.mat;','Save as',passdata.readpath); %设置默认路径
        if isequal(SaveFileName,0) || isequal(SavePathName,0) || isequal(SaveIndex,0)
            disp('User seleceted Cancel');
            save(name,'data');
        else
            path=[SavePathName SaveFileName];
            save(path,'data');
        end
    end
end
msgbox('操作成功 !!!');
guidata(hObject,handles);



% --- Executes on button press in Cue1Reset.
% function Cue1Reset_Callback(hObject, eventdata, handles)
% % hObject    handle to Cue1Reset (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% clc
% global passdata;
% dig=['请确定是否清除VideoCue1设置的打标时间点数据？'];
% choice=questdlg(dig, ...
%     'Selection Dialog', ...
%     'Yes', 'No','No');
% if isempty(choice)
%     msgbox('User cancel operation !!!');
%     return
% else
%     if strcmp(choice,'No')
%         msgbox('User cancel operation !!!!');
%         return
%     else
%         %% clear mark
%         passdata.videocue1=[];
%     end
% end
% 
% 
% % --- Executes on button press in Cue2Reset.
% function Cue2Reset_Callback(hObject, eventdata, handles)
% % hObject    handle to Cue2Reset (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% clc
% global passdata;
% dig=['请确定是否清除VideoCue2设置的打标时间点数据？'];
% choice=questdlg(dig, ...
%     'Selection Dialog', ...
%     'Yes', 'No','No');
% if isempty(choice)
%     msgbox('User cancel operation !!!');
%     return
% else
%     if strcmp(choice,'No')
%         msgbox('User cancel operation !!!!');
%         return
%     else
%         %% clear mark
%         passdata.videocue2=[];
%     end
% end
% 
% 
% % --- Executes on button press in Cue3Reset.
% function Cue3Reset_Callback(hObject, eventdata, handles)
% % hObject    handle to Cue3Reset (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% clc
% global passdata;
% dig=['请确定是否清除VideoCue3设置的打标时间点数据？'];
% choice=questdlg(dig, ...
%     'Selection Dialog', ...
%     'Yes', 'No','No');
% if isempty(choice)
%     msgbox('User cancel operation !!!');
%     return
% else
%     if strcmp(choice,'No')
%         msgbox('User cancel operation !!!!');
%         return
%     else
%         %% clear mark
%         passdata.videocue3=[];
%     end
% end
% 
% 
% % --- Executes on button press in Cue4Reset.
% function Cue4Reset_Callback(hObject, eventdata, handles)
% % hObject    handle to Cue4Reset (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% clc
% global passdata;
% dig=['请确定是否清除VideoCue4设置的打标时间点数据？'];
% choice=questdlg(dig, ...
%     'Selection Dialog', ...
%     'Yes', 'No','No');
% if isempty(choice)
%     msgbox('User cancel operation !!!');
%     return
% else
%     if strcmp(choice,'No')
%         msgbox('User cancel operation !!!!');
%         return
%     else
%         %% clear mark
%         passdata.videocue4=[];
%     end
% end



function cal_duration_Callback(hObject, eventdata, handles)
% hObject    handle to cal_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cal_duration as text
%        str2double(get(hObject,'String')) returns contents of cal_duration as a double


% --- Executes during object creation, after setting all properties.
function cal_duration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cal_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function step_Callback(hObject, eventdata, handles)
% hObject    handle to step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles=guidata(hObject);
step=str2num(get(handles.step,'String'));
if isempty(step)
    return
end
step=step(1);
set(handles.slider1,'SliderStep',[step/(handles.frames_all-1), step/(handles.frames_all-1)]);
% Hints: get(hObject,'String') returns contents of step as text
%        str2double(get(hObject,'String')) returns contents of step as a double


% --- Executes during object creation, after setting all properties.
function step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
