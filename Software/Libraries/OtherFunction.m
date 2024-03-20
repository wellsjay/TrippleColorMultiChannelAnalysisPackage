function varargout = OtherFunction(varargin)
% OTHERFUNCTION MATLAB code for OtherFunction.fig
%      OTHERFUNCTION, by itself, creates a new OTHERFUNCTION or raises the existing
%      singleton*.
%
%      H = OTHERFUNCTION returns the handle to a new OTHERFUNCTION or the handle to
%      the existing singleton*.
%
%      OTHERFUNCTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OTHERFUNCTION.M with the given input arguments.
%
%      OTHERFUNCTION('Property','Value',...) creates a new OTHERFUNCTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before OtherFunction_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to OtherFunction_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help OtherFunction

% Last Modified by GUIDE v2.5 08-May-2023 14:22:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @OtherFunction_OpeningFcn, ...
                   'gui_OutputFcn',  @OtherFunction_OutputFcn, ...
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


% --- Executes just before OtherFunction is made visible.
function OtherFunction_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to OtherFunction (see VARARGIN)

% Choose default command line output for OtherFunction
handles.output = hObject;
javaFrame=get(hObject,'javaFrame');
set(javaFrame,'FigureIcon',javax.swing.ImageIcon('logo_thinkertech.png'))
clc
set(handles.SingleTrailProcess,'Value',1);
set(handles.MultipleDataAverage,'Value',0);
set(handles.SingleTrailProcess_panel,'Visible','on');
set(handles.MultipleDataAverage_panel,'Visible','off');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes OtherFunction wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = OtherFunction_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in SingleTrailProcess.
function SingleTrailProcess_Callback(hObject, eventdata, handles)
% hObject    handle to SingleTrailProcess (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(handles.SingleTrailProcess,'Value');
if value==1
    set(handles.SingleTrailProcess_panel,'Visible','on');
    set(handles.MultipleDataAverage_panel,'Visible','off');
    set(handles.MultipleDataAverage,'Value',0);
% else
%     set(handles.SingleTrailProcess_panel,'Visible','off');
%     set(handles.MultipleDataAverage_panel,'Visible','on');
%     set(handles.MultipleDataAverage,'Value',1);
end

% --- Executes on button press in MultipleDataAverage.
function MultipleDataAverage_Callback(hObject, eventdata, handles)
% hObject    handle to MultipleDataAverage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(handles.MultipleDataAverage,'Value');
if value==1
    set(handles.SingleTrailProcess_panel,'Visible','off');
    set(handles.MultipleDataAverage_panel,'Visible','on');
    set(handles.SingleTrailProcess,'Value',0);
    
% else
%     set(handles.SingleTrailProcess_panel,'Visible','on');
%     set(handles.MultipleDataAverage_panel,'Visible','off');
%     set(handles.SingleTrailProcess,'Value',1);
end
% Hint: get(hObject,'Value') returns toggle state of MultipleDataAverage



function load_trail_Callback(hObject, eventdata, handles)
% hObject    handle to load_trail (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of load_trail as text
%        str2double(get(hObject,'String')) returns contents of load_trail as a double


% --- Executes during object creation, after setting all properties.
function load_trail_CreateFcn(hObject, eventdata, handles)
% hObject    handle to load_trail (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in LoadTrail.
function LoadTrail_Callback(hObject, eventdata, handles)
% hObject    handle to LoadTrail (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
global passdata
if isfield(passdata,'readpath')
    [FileName_all,FilePath]=uigetfile({'*.mat'},'MultiSelect','on','Open trail data file',passdata.readpath);
else
    [FileName_all,FilePath]=uigetfile({'*.mat'},'MultiSelect','on','Open trial data file');
end

if isnumeric(FileName_all)
    return;
end
passdata.readpath=FilePath(1:end-1);
handles.trail_data.N=0;

passdata.readpath=FilePath(1:end-1);
% [~,~,file_path_and_name_trail_part]=fileparts(file_path_and_name_trail);
%%
if ischar(FileName_all)
    handles.trail_data.N=1;
    file_path_and_name_trail=[FilePath,FileName_all];
    [~,~,file_path_and_name_trail_part]=fileparts(file_path_and_name_trail);
    if strcmp(file_path_and_name_trail_part,'.mat')
        trail_data=load(file_path_and_name_trail);
        if isfield(trail_data,'psth1_mean')
            %             handles.trailmode=1;
            handles.trail_data.trailmode1=1;
            set(handles.AUC_time_1,'String',num2str(min(trail_data.times)));
            set(handles.AUC_time_2,'String',num2str(max(trail_data.times)));
            set(handles.p_v_time1,'String',num2str(min(trail_data.times)));
            set(handles.p_v_time2,'String',num2str(max(trail_data.times)));
            set(handles.event_time_1,'String',num2str(min(trail_data.times)));
            set(handles.event_time_2,'String',num2str(max(trail_data.times)));
        elseif isfield(trail_data,'data')
            
            handles.trail_data.trailmode1=2;
            trail_data.times=trail_data.times-trail_data.times(1);
            set(handles.AUC_time_1,'String',num2str(min(trail_data.times)));
            set(handles.AUC_time_2,'String',num2str(max(trail_data.times)));
            set(handles.p_v_time1,'String',num2str(min(trail_data.times)));
            set(handles.p_v_time2,'String',num2str(max(trail_data.times)));
            set(handles.event_time_1,'String',num2str(min(trail_data.times)));
            set(handles.event_time_2,'String',num2str(max(trail_data.times)));
        else
            msgbox('操作失败，请确定是否读取正确的trail数据格式 !!!!');
            handles.trail_data.N=0;
            return
        end
    else
        msgbox('操作失败，请确定是否读取正确的trail数据格式 !!!!');
        handles.trail_data.N=0;
        return
    end
    handles.file_path_and_name_trail1=file_path_and_name_trail;
    handles.trail_data.data1=trail_data;
else
    handles.trail_data.N=size(FileName_all,2);
    for i=1:size(FileName_all,2)
        file_path_and_name_trail=[FilePath,char(FileName_all(i))];
        [~,~,file_path_and_name_trail_part]=fileparts(file_path_and_name_trail);
        if strcmp(file_path_and_name_trail_part,'.mat')
            trail_data=load(file_path_and_name_trail);
            if isfield(trail_data,'psth1_mean')
%                 handles.trailmode=1;
                eval(['handles.trail_data.trailmode' num2str(i) '=1;']);
                set(handles.AUC_time_1,'String',num2str(min(trail_data.times)));
                set(handles.AUC_time_2,'String',num2str(max(trail_data.times)));
                set(handles.p_v_time1,'String',num2str(min(trail_data.times)));
                set(handles.p_v_time2,'String',num2str(max(trail_data.times)));
                set(handles.event_time_1,'String',num2str(min(trail_data.times)));
                set(handles.event_time_2,'String',num2str(max(trail_data.times)));
            elseif isfield(trail_data,'data')
                
                eval(['handles.trail_data.trailmode' num2str(i) '=2;']);
                trail_data.times=trail_data.times-trail_data.times(1);
                set(handles.AUC_time_1,'String',num2str(min(trail_data.times)));
                set(handles.AUC_time_2,'String',num2str(max(trail_data.times)));
                set(handles.p_v_time1,'String',num2str(min(trail_data.times)));
                set(handles.p_v_time2,'String',num2str(max(trail_data.times)));
                set(handles.event_time_1,'String',num2str(min(trail_data.times)));
                set(handles.event_time_2,'String',num2str(max(trail_data.times)));
            else
                msgbox('操作失败，请确定是否读取正确的trail数据格式 !!!!');
                handles.trail_data.N=0;
                return
            end
        else
            msgbox('操作失败，请确定是否读取正确的trail数据格式 !!!!');
            handles.trail_data.N=0;
            return
        end
        eval(['handles.file_path_and_name_trail' num2str(i) '=file_path_and_name_trail;']);
        eval(['handles.trail_data.data' num2str(i) '=trail_data;']);
    end
end


set(handles.load_trail,'String',FilePath);
%%

% handles.file_path_and_name_trail_part=file_path_and_name_trail_part;
guidata(hObject,handles);
passdata.readpath=FilePath;
msgbox('数据读取成功 !!!!!!!!!!!');


% --- Executes on button press in DrawTrail.
function DrawTrail_Callback(hObject, eventdata, handles)
% hObject    handle to DrawTrail (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
handles=guidata(hObject);
if isfield(handles,'trail_data')
    if ~isempty(handles.trail_data)&&handles.trail_data.N~=0
        
        if handles.trail_data.N>1
            answer=inputdlg(['检测到' num2str(handles.trail_data.N) '个文件被导入，请输入预览第几个文件'],'文件预览编号询问');
            answer=round(str2num(answer{1,1}));
            if isempty(answer)
                answer=1;
                if length(answer)>1
                    answer=answer(1);
                end
                if answer>handles.trail_data.N||answer<1
                    answer=1;
                end
            end
        else
            answer=1;
        end
        eval(['trailmode=handles.trail_data.trailmode' num2str(answer) ';']);
        eval(['trail_data=handles.trail_data.data' num2str(answer) ';']);
        
        if trailmode==1
            %%
            figure('NumberTitle', 'off', 'Name', ['File' num2str(answer) ' Trail Data Preview ']);
            drawErrorLine(trail_data.times,trail_data.psth1_mean,trail_data.psth1_sem,'Red',0.5);
            %%
            figure('NumberTitle', 'off', 'Name', ['File' num2str(answer) ' Heatmap Preview ']);
            imagesc(trail_data.times,1:1:size(trail_data.psth1,1),trail_data.psth1);
            colormap(jet);
            %%
        elseif trailmode==2
            figure('NumberTitle', 'off', 'Name', ['File' num2str(answer) ' Trail data Preview ']);
            plot(trail_data.times,trail_data.data,'color','r','LineWidth',2);
        end
    end
else
    return
end



function AUC_time_1_Callback(hObject, eventdata, handles)
% hObject    handle to AUC_time_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AUC_time_1 as text
%        str2double(get(hObject,'String')) returns contents of AUC_time_1 as a double


% --- Executes during object creation, after setting all properties.
function AUC_time_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AUC_time_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function AUC_time_2_Callback(hObject, eventdata, handles)
% hObject    handle to AUC_time_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AUC_time_2 as text
%        str2double(get(hObject,'String')) returns contents of AUC_time_2 as a double


% --- Executes during object creation, after setting all properties.
function AUC_time_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AUC_time_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function p_v_time1_Callback(hObject, eventdata, handles)
% hObject    handle to p_v_time1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of p_v_time1 as text
%        str2double(get(hObject,'String')) returns contents of p_v_time1 as a double


% --- Executes during object creation, after setting all properties.
function p_v_time1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to p_v_time1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function p_v_time2_Callback(hObject, eventdata, handles)
% hObject    handle to p_v_time2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of p_v_time2 as text
%        str2double(get(hObject,'String')) returns contents of p_v_time2 as a double


% --- Executes during object creation, after setting all properties.
function p_v_time2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to p_v_time2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in AUC.
function AUC_Callback(hObject, eventdata, handles)
% hObject    handle to AUC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
%% AUC计算
handles=guidata(hObject);

if isfield(handles,'trail_data')
    if ~isempty(handles.trail_data)&& handles.trail_data.N~=0
        h=waitbar(0,'数据计算中，请稍等');
        for ii=1:handles.trail_data.N
            eval(['trailmode=handles.trail_data.trailmode' num2str(ii) ';']);
            eval(['trail_data=handles.trail_data.data' num2str(ii) ';']);
            if trailmode==1
                %% 计算中
                times=trail_data.times;
                
                start_time=str2num(get(handles.AUC_time_1,'String'));
                if isempty(start_time)
                    msgbox('请输入正确的时间格式！！！');
                    return
                end
                end_time=str2num(get(handles.AUC_time_2,'String'));
                if isempty(end_time)
                    msgbox('请输入正确的时间格式！！！');
                    return
                end
                if start_time>end_time
                    p=end_time;
                    end_time=start_time;
                    start_time=p;
                    set(handles.AUC_time_1,'String',num2str(start_time));
                    set(handles.AUC_time_2,'String',num2str(end_time));
                elseif start_time==end_time
                    msgbox('参数范围设置错误！！');
                    return
                end
                if start_time<=min(times(:))
                    start_time=min(times(:));
                    set(handles.AUC_time_1,'String',num2str(start_time));
                end
                if end_time>=max(times(:))
                    end_time=max(times(:));
                    set(handles.AUC_time_2,'String',num2str(end_time));
                end
                %%
                psth1=trail_data.psth1;
                psth1_mean=trail_data.psth1_mean;
                psth1_sem=trail_data.psth1_sem;
                %%
                time_rang=times>= start_time & times<=end_time;
                AUC=zeros(1,size(psth1,1)+1);
                for i=1:size(psth1,1)
                    psth_current=psth1(i,:);
                    psth_auc=psth_current(time_rang);
                    AUC(i)=(sum(psth_auc))*(times(2)-times(1));
                end
                psth_current=psth1_mean;
                psth_auc=psth_current(time_rang);
                AUC(size(psth1,1)+1)=(sum(psth_auc))*(times(2)-times(1));
                %% 绘图中
                %             figure('NumberTitle', 'off', 'Name', 'AUC Data Preview ');
                Bar=cell(1,size(psth1,1)+1);
                for i=1:size(psth1,1)+1
                    if i~=size(psth1,1)+1
                        Bar{i}=['Trail' num2str(i) ' AUC'];
                    else
                        Bar{i}='Trail Mean AUC';
                    end
                end
                %             subplot(1,2,1)
                %             bar(categorical(Bar),AUC);
                %             %     AUC_str=num2str(AUC);
                AUC_cell=cell(1,length(AUC));
                for i=1:length(AUC)
                    AUC_cell{i}=num2str(AUC(i));
                end
                %             %     bar(AUC);
                %             subplot(1,2,2)
                %             drawErrorLine(times,psth1_mean,psth1_sem,'Blue',0.5);
                %             hold on
                %             ylim=get(gca,'Ylim');
                %             %     time_r=times(time_rang);
                %             %     time_1=
                %             label=ones(1,size(psth_auc,2))*ylim(2);
                %             label(1)=ylim(1);
                %             label(end)=ylim(1);
                %             plot(times(time_rang),label,'r--');
                %             hold on
                %             label=ones(1,size(psth_auc,2))*ylim(1);
                %             plot(times(time_rang),label,'r--');
                %             ylabel('deltaF/F(%)');
                %             xlabel('Time (s)');
                %% 保存数据中。。
                eval(['file_path_and_name_trail=handles.file_path_and_name_trail' num2str(ii) ';']);
                mat_name=strrep(file_path_and_name_trail,'.mat','_AUC.mat');
                str=['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
%                 if size(psth1,1)+1<=26
%                     xlRange_header=['A1:' str(i) '1'];
%                     xlRange_data=['A2:' str(i) '2'];
%                 elseif size(psth1,1)+1>26
%                     if mod(size(psth1,1)+1,26)==0
%                         str1=fix((size(psth1,1)+1)/26)-1;
%                         str2='Z';
%                         xlRange_header=['A1:' str(str1)  str(str2) '1'];
%                         xlRange_data=['A2:' str(str1)  str(str2) '2'];
%                     else
%                         str1=fix((size(psth1,1)+1)/26);
%                         str2=mod(size(psth1,1)+1,26);
%                         xlRange_header=['A1:' str(str1)  str(str2) '1'];
%                         xlRange_data=['A2:' str(str1)  str(str2) '2'];
%                     end
%                     
%                 end
                xlRange_header=['A1:A' num2str(size(psth1,1)+1)];
                xlRange_data=['B1:B' num2str(size(psth1,1)+1)];
                AUC_trail=cell(2,size(psth1,1)+1);
                for i=1:size(psth1,1)+1
                    AUC_trail{1,i}=Bar{1,i};
                    AUC_trail{2,i}=AUC_cell{1,i};
                end
                %%%%%%%%%%%%%%%%%%%%%%%%%%%
                AUC_trail=cell(2,size(psth1,1)+1);
                for i=1:size(psth1,1)+1
                    
                    AUC_trail{1,i}=Bar{1,i};
                    AUC_trail{2,i}=AUC_cell{1,i};
                end
                %%
                AUC_start_time=start_time;
                AUC_end_time=end_time;
                xlsx_name=strrep(mat_name,'.mat','.csv');
                
                fid = fopen(xlsx_name, 'w+', 'n', 'utf8');    % 创建一个csv文件
                for i=1:length(AUC)
                    fprintf(fid, '%s,', Bar{i}); % 一行两个数据，用逗号分隔；每行结束后加上\n换行
                    fprintf(fid, '%.5f\n', AUC(i)); % 一行两个数据，用逗号分隔；每行结束后加上\n换行
                end
                fclose(fid);
                

                %%
                save(mat_name,'AUC_trail','AUC_start_time','AUC_end_time')
               
                %%
            elseif trailmode==2 && isfield(trail_data,'data_all')
                %% 检测开始结束时间准确性
                times=trail_data.times;
                start_time=str2num(get(handles.AUC_time_1,'String'));
                if isempty(start_time)
                    msgbox('请输入正确的时间格式！！！');
                    return
                end
                end_time=str2num(get(handles.AUC_time_2,'String'));
                if isempty(end_time)
                    msgbox('请输入正确的时间格式！！！');
                    return
                end
                if start_time>end_time
                    p=end_time;
                    end_time=start_time;
                    start_time=p;
                    set(handles.AUC_time_1,'String',num2str(start_time));
                    set(handles.AUC_time_2,'String',num2str(end_time));
                elseif start_time==end_time
                    msgbox('参数范围设置错误！！');
                    return
                end
                if start_time<=min(times(:))
                    start_time=min(times(:));
                    set(handles.AUC_time_1,'String',num2str(start_time));
                end
                if end_time>=max(times(:))
                    end_time=max(times(:));
                    set(handles.AUC_time_2,'String',num2str(end_time));
                end
                
                %% 计算
                time_rang=times>= start_time & times<=end_time;
                %             AUC=0;
                %             psth_auc=handles.trail_data.data(time_rang);
                %             AUC=(sum(psth_auc))*(times(2)-times(1));
                %%
                AUC=zeros(1,size(trail_data.data_all,1)+1);
                for i=1:size(trail_data.data_all,1)
                    psth_current=trail_data.data_all(i,:);
                    psth_auc=psth_current(time_rang);
                    AUC(i)=(sum(psth_auc))*(times(2)-times(1));
                end
                
                psth_auc=trail_data.data(time_rang);
                AUC(end)=(sum(psth_auc))*(times(2)-times(1));
                %% 绘图中
                %             figure('NumberTitle', 'off', 'Name', 'AUC Data Preview ');
                Bar=cell(1,size(trail_data.data_all,1)+1);
                for i=1:size(trail_data.data_all,1)+1
                    if i~=size(trail_data.data_all,1)+1
                        Bar{i}=['data' num2str(i) ' AUC'];
                    else
                        Bar{i}='data Mean AUC';
                    end
                end
                %             subplot(1,2,1)
                %             bar(categorical(Bar),AUC);
                %             %     AUC_str=num2str(AUC);
                AUC_cell=cell(1,length(AUC));
                for i=1:length(AUC)
                    AUC_cell{i}=num2str(AUC(i));
                end
                
                %% 保存数据中。。
                eval(['file_path_and_name_trail=handles.file_path_and_name_trail' num2str(ii) ';']);
                mat_name=strrep(file_path_and_name_trail,'.mat','_AUC.mat');
%                 mat_name=strrep(handles.file_path_and_name_trail,handles.file_path_and_name_trail_part,'_AUC.mat');
                str=['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
                if size(trail_data.data_all,1)+1<=26
                    xlRange_header=['A1:' str(i) '1'];
                    xlRange_data=['A2:' str(i) '2'];
                elseif size(trail_data.data_all,1)+1>26
                    if mod(size(trail_data.data_all,1)+1,26)==0
                        str1=fix((size(trail_data.data_all,1)+1)/26)-1;
                        str2='Z';
                        xlRange_header=['A1:' str(str1)  str(str2) '1'];
                        xlRange_data=['A2:' str(str1)  str(str2) '2'];
                    else
                        str1=fix((size(trail_data.data_all,1)+1)/26);
                        str2=mod(size(trail_data.data_all,1)+1,26);
                        xlRange_header=['A1:' str(str1)  str(str2) '1'];
                        xlRange_data=['A2:' str(str1)  str(str2) '2'];
                    end
                    
                end
                AUC_trail=cell(2,size(trail_data.data_all,1)+1);
                for i=1:size(trail_data.data_all,1)+1
                    AUC_trail{1,i}=Bar{1,i};
                    AUC_trail{2,i}=AUC_cell{1,i};
                end
                %%%%%%%%%%%%%%%%%%%%%%%%%%%
                AUC_trail=cell(2,size(trail_data.data_all,1)+1);
                for i=1:size(trail_data.data_all,1)+1
                    
                    AUC_trail{1,i}=Bar{1,i};
                    AUC_trail{2,i}=AUC_cell{1,i};
                end
                %%
                AUC_start_time=start_time;
                AUC_end_time=end_time;
                xlsx_name=strrep(mat_name,'.mat','.csv');
                fid = fopen(xlsx_name, 'w+', 'n', 'utf8');    % 创建一个csv文件
                for i=1:length(size(trail_data.data_all,1)+1)
                    fprintf(fid, '%s,', Bar{i}); % 一行两个数据，用逗号分隔；每行结束后加上\n换行
                    fprintf(fid, '%.5f\n', AUC(i)); % 一行两个数据，用逗号分隔；每行结束后加上\n换行
                end
                fclose(fid);
                
%                 try
%                     delete(xlsx_name);
%                     warning off
%                     xlswrite(xlsx_name,Bar,xlRange_header);
%                     xlswrite(xlsx_name,AUC,xlRange_data);
%                 catch
%                 end
                %%
                save(mat_name,'AUC_trail','AUC_start_time','AUC_end_time')
                
                %%
                %% 绘图中
                
                %             figure;
                %             plot(handles.trail_data.times,handles.trail_data.data,'color','Blue','Linewidth',0.5);
                %             ylabel('deltaF/F(%)');
                %             hold on
                %             ylim=get(gca,'Ylim');
                %             %     time_r=times(time_rang);
                %             %     time_1=
                %             label=ones(1,size(psth_auc,1))*ylim(2);
                %             label(1)=ylim(1);
                %             label(end)=ylim(1);
                %             plot(times(time_rang),label,'r--');
                %             hold on
                %             label=ones(1,size(psth_auc,1))*ylim(1);
                %             plot(times(time_rang),label,'r--');
                %             ylabel('deltaF/F(%)');
                %             xlabel('Time (s)');
                %% 保存中
                %             mat_name=strrep(handles.file_path_and_name_trail,handles.file_path_and_name_trail_part,'_AUC.mat');
                %             xlsx_name=strrep(mat_name,'.mat','.xlsx');
                %             xlswrite(xlsx_name,AUC);
                %
                %             AUC_start_time=start_time;
                %             AUC_end_time=end_time;
                %
                %             save(mat_name,'AUC','AUC_start_time','AUC_end_time');
                %             msgbox('计算完成!!!')
            elseif trailmode==2 && ~isfield(trail_data,'data_all')
                times=trail_data.times;
                start_time=str2num(get(handles.AUC_time_1,'String'));
                if isempty(start_time)
                    msgbox('请输入正确的时间格式！！！');
                    return
                end
                end_time=str2num(get(handles.AUC_time_2,'String'));
                if isempty(end_time)
                    msgbox('请输入正确的时间格式！！！');
                    return
                end
                if start_time>end_time
                    p=end_time;
                    end_time=start_time;
                    start_time=p;
                    set(handles.AUC_time_1,'String',num2str(start_time));
                    set(handles.AUC_time_2,'String',num2str(end_time));
                elseif start_time==end_time
                    msgbox('参数范围设置错误！！');
                    return
                end
                if start_time<=min(times(:))
                    start_time=min(times(:));
                    set(handles.AUC_time_1,'String',num2str(start_time));
                end
                if end_time>=max(times(:))
                    end_time=max(times(:));
                    set(handles.AUC_time_2,'String',num2str(end_time));
                end
                
                %% 计算
                time_rang=times>= start_time & times<=end_time;
                AUC=0;
                psth_auc=trail_data.data(time_rang);
                AUC=(sum(psth_auc))*(times(2)-times(1));
                
                % 保存中
                eval(['file_path_and_name_trail=handles.file_path_and_name_trail' num2str(ii) ';']);
                mat_name=strrep(file_path_and_name_trail,'.mat','_AUC.mat');
%                 mat_name=strrep(handles.file_path_and_name_trail,handles.file_path_and_name_trail_part,'_AUC.mat');
                xlsx_name=strrep(mat_name,'.mat','.csv');
                
                fid = fopen(xlsx_name, 'w+', 'n', 'utf8');    % 创建一个csv文件
                fprintf(fid, '%.5f\n', AUC); % 一行两个数据，用逗号分隔；每行结束后加上\n换行
                fclose(fid);
                
%                 try
%                     delete(xlsx_name);
%                     warning off
%                     xlswrite(xlsx_name,AUC);
%                 catch
%                 end
                AUC_start_time=start_time;
                AUC_end_time=end_time;
                
                save(mat_name,'AUC','AUC_start_time','AUC_end_time');
                
            end
            waitbar(ii/handles.trail_data.N,h,['第' num2str(ii) '组数据已经完成计算！！！']);
        end
        waitbar(ii/handles.trail_data.N,h,['完成计算！！！']);
        close(h);
    end
    
else
    return
end
guidata(hObject,handles);



% --- Executes on button press in Peak_Valley.
function Peak_Valley_Callback(hObject, eventdata, handles)
% hObject    handle to Peak_Valley (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
%% Peak_Valley计算
handles=guidata(hObject);
if isfield(handles,'trail_data')
    
    if ~isempty(handles.trail_data)&&handles.trail_data.N~=0
        for ii=1:handles.trail_data.N
            eval(['trailmode=handles.trail_data.trailmode' num2str(ii) ';']);
            eval(['trail_data=handles.trail_data.data' num2str(ii) ';']);
            if trailmode==1
                %% 检测开始结束时间准确性
                times=trail_data.times;
                start_time=str2num(get(handles.p_v_time1,'String'));
                if isempty(start_time)
                    msgbox('请输入正确的时间格式！！！');
                    return
                end
                end_time=str2num(get(handles.p_v_time2,'String'));
                if isempty(end_time)
                    msgbox('请输入正确的时间格式！！！');
                    return
                end
                if start_time>end_time
                    p=end_time;
                    end_time=start_time;
                    start_time=p;
                    set(handles.p_v_time1,'String',num2str(start_time));
                    set(handles.p_v_time2,'String',num2str(end_time));
                elseif start_time==end_time
                    msgbox('参数范围设置错误！！');
                    return
                end
                if start_time<=min(times(:))
                    start_time=min(times(:));
                    set(handles.p_v_time1,'String',num2str(start_time));
                end
                if end_time>=max(times(:))
                    end_time=max(times(:));
                    set(handles.p_v_time2,'String',num2str(end_time));
                end
                %%  数据读取
                psth1=trail_data.psth1;
                psth1_mean=trail_data.psth1_mean;
                %% 计算中
                Bar_peak=cell(1,size(psth1,1)+1);
                Bar_Valley=cell(1,size(psth1,1)+1);
                Peak=zeros(1,size(psth1,1)+1);
                Valley=zeros(1,size(psth1,1)+1);
                Peak_time=zeros(1,size(psth1,1)+1);
                Valley_time=zeros(1,size(psth1,1)+1);
                %%
                for i=1:size(psth1,1)+1
                    peak_time=times>=start_time&times<=end_time;
                    if i==size(psth1,1)+1
                        peak_range=psth1_mean(peak_time);
                        peak_times=times(peak_time);
                        Bar_peak{i}='MeanTrailPeak';
                        Bar_Valley{i}='MeanTrailValley';
                    else
                        peak_range=psth1(i,peak_time);
                        peak_times=times(peak_time);
                        Bar_peak{i}=['Trail' num2str(i) 'Peak'];
                        Bar_Valley{i}=['Trail' num2str(i) 'Valley'];
                    end
                    Max=max(peak_range(:));
                    Peak(i)=Max;
                    Min=min(peak_range(:));
                    Valley(i)=Min;
                    Max_label=find(peak_range(:)==Max);
                    Min_label=find(peak_range(:)==Min);
                    Max_time=peak_times(Max_label(1));
                    Min_time=peak_times(Min_label(1));
                    Peak_time(i)=Max_time;
                    Valley_time(i)=Min_time;
                end
                str=['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
%                 if (size(psth1,1)+1)*2<=26
%                     xlRange_header=['A1:' str((size(psth1,1)+1)*2) '1'];
%                     xlRange_data=['A2:' str((size(psth1,1)+1)*2) '3'];
%                 elseif (size(psth1,1)+1)*2>26
%                     if mod((size(psth1,1)+1)*2,26)==0
%                         str1=fix((size(psth1,1)+1)*2/26)-1;
%                         str2='Z';
%                         xlRange_header=['A1:' str(str1)  str(str2) '1'];
%                         xlRange_data=['A2:' str(str1)  str(str2) '3'];
%                     else
%                         str1=fix((size(psth1,1)+1)*2/26);
%                         str2=mod((size(psth1,1)+1)*2,26);
%                         xlRange_header=['A1:' str(str1)  str(str2) '1'];
%                         xlRange_data=['A2:' str(str1)  str(str2) '3'];
%                     end
%                 end
                xlRange_header=['A1:A' num2str((size(psth1,1)+1)*2)];
                xlRange_data=['B1:C' num2str((size(psth1,1)+1)*2)];
                
                %% 保存数据中。。
                eval(['file_path_and_name_trail=handles.file_path_and_name_trail' num2str(ii) ';']);
                MAT_name=strrep(file_path_and_name_trail,'.mat','_Peak_Valley.mat');
                xlsx_name=strrep(MAT_name,'.mat','.csv');
                
                fid = fopen(xlsx_name, 'w+', 'n', 'utf8');    % 创建一个csv文件
                for i=1:size(psth1,1)+1
                    fprintf(fid, '%s,', Bar_peak{i}); % 一行两个数据，用逗号分隔；每行结束后加上\n换行
                    fprintf(fid, '%.5f,%.5f\n',Peak(i),Peak_time(i)); % 一行两个数据，用逗号分隔；每行结束后加上\n换行
                end
                for i=1:size(psth1,1)+1
                    fprintf(fid, '%s,', Bar_Valley{i}); % 一行两个数据，用逗号分隔；每行结束后加上\n换行
                    fprintf(fid, '%.5f,%.5f\n',Valley(i),Valley_time(i)); % 一行两个数据，用逗号分隔；每行结束后加上\n换行
                end
                fclose(fid);
                %                 try
%                     delete(xlsx_name);
%                     warning off;
%                     xlswrite(xlsx_name,[Bar_peak,Bar_Valley]', xlRange_header);
%                     xlswrite(xlsx_name,[Peak,Valley;Peak_time,Valley_time]',xlRange_data);
%                 catch
%                 end
                stattime=start_time;
                endtime=end_time;
                save(MAT_name,'Bar_peak','Bar_Valley','Peak','Valley','Peak_time','Valley_time','stattime','endtime');
              
                %%
            elseif trailmode==2 && ~isfield(trail_data,'data_all')
                %% 检测开始结束时间准确性
                times=trail_data.times;
                start_time=str2num(get(handles.p_v_time1,'String'));
                if isempty(start_time)
                    msgbox('请输入正确的时间格式！！！');
                    return
                end
                end_time=str2num(get(handles.p_v_time2,'String'));
                if isempty(end_time)
                    msgbox('请输入正确的时间格式！！！');
                    return
                end
                if start_time>end_time
                    p=end_time;
                    end_time=start_time;
                    start_time=p;
                    set(handles.p_v_time1,'String',num2str(start_time));
                    set(handles.p_v_time2,'String',num2str(end_time));
                elseif start_time==end_time
                    msgbox('参数范围设置错误！！');
                    return
                end
                if start_time<=min(times(:))
                    start_time=min(times(:));
                    set(handles.p_v_time1,'String',num2str(start_time));
                end
                if end_time>=max(times(:))
                    end_time=max(times(:));
                    set(handles.p_v_time2,'String',num2str(end_time));
                end
                %% 计算中
                peak_time=times>=start_time&times<=end_time;
                peak_range=trail_data.data(peak_time);
                peak_times=times(peak_time);
                Bar=cell(1,4);
                Bar{1}='Peak Value';
                Bar{2}='Peak Time';
                Bar{3}='Valley Value';
                Bar{4}='Valley Time';
                Max=max(peak_range(:));
                Min=min(peak_range(:));
                Max_label=find(peak_range(:)==Max);
                Min_label=find(peak_range(:)==Min);
                Max_time=peak_times(Max_label(1));
                Min_time=peak_times(Min_label(1));
                Peak=cell(1,4);
                Peak{1}=num2str(Max);
                Peak{2}=num2str(Max_time);
                Peak{3}=num2str(Min);
                Peak{4}=num2str(Min_time);
                %% 绘图中
                eval(['file_path_and_name_trail=handles.file_path_and_name_trail' num2str(ii) ';']);
                MAT_name=strrep(file_path_and_name_trail,'.mat','_Peak_Valley.mat');
%                 MAT_name=strrep(handles.file_path_and_name_trail,handles.file_path_and_name_trail_part,'_Peak_Valley.mat');
                xlsx_name=strrep(MAT_name,'.mat','.csv');
                
                fid = fopen(xlsx_name, 'w+', 'n', 'utf8');    % 创建一个csv文件
                fprintf(fid, '%s,%s,%s,%s\n', 'Peak Value','Peak Time','Valley Value','Valley Time'); % 一行两个数据，用逗号分隔；每行结束后加上\n换行
                fprintf(fid, '%.5f,%.5f,%.5f,%.5f\n',Max,Max_time,Min,Min_time); % 一行两个数据，用逗号分隔；每行结束后加上\n换行
                fclose(fid);
%                 try
%                     delete(xlsx_name);
%                     warning off
%                     xlswrite(xlsx_name,[Bar; Peak]);
%                 catch
%                 end
                Peak_Valley=[Max,Max_time,Min,Min_time];
                Peak_Valley_Name=cell(1,4);
                Peak_Valley_Name{1,1}='MAX';
                Peak_Valley_Name{1,2}='MAX_time';
                Peak_Valley_Name{1,3}='Min';
                Peak_Valley_Name{1,4}='Min_time';
                
                stattime=start_time;
                endtime=end_time;
                save(MAT_name,'Peak_Valley','Peak_Valley_Name','stattime','endtime');
               
            elseif trailmode==2 && isfield(trail_data,'data_all')
                %% 检测开始结束时间准确性
                times=trail_data.times;
                start_time=str2num(get(handles.p_v_time1,'String'));
                if isempty(start_time)
                    msgbox('请输入正确的时间格式！！！');
                    return
                end
                end_time=str2num(get(handles.p_v_time2,'String'));
                if isempty(end_time)
                    msgbox('请输入正确的时间格式！！！');
                    return
                end
                if start_time>end_time
                    p=end_time;
                    end_time=start_time;
                    start_time=p;
                    set(handles.p_v_time1,'String',num2str(start_time));
                    set(handles.p_v_time2,'String',num2str(end_time));
                elseif start_time==end_time
                    msgbox('参数范围设置错误！！');
                    return
                end
                if start_time<=min(times(:))
                    start_time=min(times(:));
                    set(handles.p_v_time1,'String',num2str(start_time));
                end
                if end_time>=max(times(:))
                    end_time=max(times(:));
                    set(handles.p_v_time2,'String',num2str(end_time));
                end
                %%
                %%  数据读取
                psth1=trail_data.data_all;
                psth1_mean=trail_data.data;
                %% 计算中
                Bar_peak=cell(1,size(psth1,1)+1);
                Bar_Valley=cell(1,size(psth1,1)+1);
                Peak=zeros(1,size(psth1,1)+1);
                Valley=zeros(1,size(psth1,1)+1);
                Peak_time=zeros(1,size(psth1,1)+1);
                Valley_time=zeros(1,size(psth1,1)+1);
                %%
                for i=1:size(psth1,1)+1
                    peak_time=times>=start_time&times<=end_time;
                    if i==size(psth1,1)+1
                        peak_range=psth1_mean(peak_time);
                        peak_times=times(peak_time);
                        Bar_peak{i}='MeanDataPeak';
                        Bar_Valley{i}='MeanDataValley';
                    else
                        peak_range=psth1(i,peak_time);
                        peak_times=times(peak_time);
                        Bar_peak{i}=['Data' num2str(i) 'Peak'];
                        Bar_Valley{i}=['Data' num2str(i) 'Valley'];
                    end
                    Max=max(peak_range(:));
                    Peak(i)=Max;
                    Min=min(peak_range(:));
                    Valley(i)=Min;
                    Max_label=find(peak_range(:)==Max);
                    Min_label=find(peak_range(:)==Min);
                    Max_time=peak_times(Max_label(1));
                    Min_time=peak_times(Min_label(1));
                    Peak_time(i)=Max_time;
                    Valley_time(i)=Min_time;
                end
                str=['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
                
                if (size(psth1,1)+1)*2<=26
                    xlRange_header=['A1:' str((size(psth1,1)+1)*2) '1'];
                    xlRange_data=['A2:' str((size(psth1,1)+1)*2) '3'];
                elseif (size(psth1,1)+1)*2>26
                    if mod((size(psth1,1)+1)*2,26)==0
                        str1=fix((size(psth1,1)+1)*2/26)-1;
                        str2='Z';
                        xlRange_header=['A1:' str(str1)  str(str2) '1'];
                        xlRange_data=['A2:' str(str1)  str(str2) '3'];
                    else
                        str1=fix((size(psth1,1)+1)*2/26);
                        str2=mod((size(psth1,1)+1)*2,26);
                        xlRange_header=['A1:' str(str1)  str(str2) '1'];
                        xlRange_data=['A2:' str(str1)  str(str2) '3'];
                    end
                end
                
                %% 保存数据中。。
                eval(['file_path_and_name_trail=handles.file_path_and_name_trail' num2str(ii) ';']);
                MAT_name=strrep(file_path_and_name_trail,'.mat','_Peak_Valley.mat');
%                 MAT_name=strrep(handles.file_path_and_name_trail,handles.file_path_and_name_trail_part,'_Peak_Valley.mat');
                xlsx_name=strrep(MAT_name,'.mat','.csv');
                
                fid = fopen(xlsx_name, 'w+', 'n', 'utf8');    % 创建一个csv文件
                for i=1:2*(size(psth1,1)+1)
                    if i<=size(psth1,1)+1
                        fprintf(fid, '%s,', Bar_peak{i});
                    elseif i==2*(size(psth1,1)+1)
                        fprintf(fid, '%s\n', Bar_Valley{i-(size(psth1,1)+1)});
                    else
                        fprintf(fid, '%s,', Bar_Valley{i-(size(psth1,1)+1)});
                    end                 
                end
                
                for i=1:2*(size(psth1,1)+1)
                    if i<=size(psth1,1)+1
                        fprintf(fid, '%.5f,', Peak{i});
                    elseif i==2*(size(psth1,1)+1)
                        fprintf(fid, '%.5f\n', Valley{i-(size(psth1,1)+1)});
                    else
                        fprintf(fid, '%.5f,', Valley{i-(size(psth1,1)+1)});
                    end                 
                end
                
                for i=1:2*(size(psth1,1)+1)
                    if i<=size(psth1,1)+1
                        fprintf(fid, '%.5f,', Peak_time{i});
                    elseif i==2*(size(psth1,1)+1)
                        fprintf(fid, '%.5f\n', Valley_time{i-(size(psth1,1)+1)});
                    else
                        fprintf(fid, '%.5f,', Valley_time{i-(size(psth1,1)+1)});
                    end                 
                end
                fclose(fid);
                
              
                stattime=start_time;
                endtime=end_time;
                save(MAT_name,'Bar_peak','Bar_Valley','Peak','Valley','Peak_time','Valley_time','stattime','endtime');
                
            end
        end
        msgbox('计算完成 !!!!');
    end
else
    return
end
guidata(hObject,handles);



function event_time_1_Callback(hObject, eventdata, handles)
% hObject    handle to event_time_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of event_time_1 as text
%        str2double(get(hObject,'String')) returns contents of event_time_1 as a double


% --- Executes during object creation, after setting all properties.
function event_time_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to event_time_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function event_time_2_Callback(hObject, eventdata, handles)
% hObject    handle to event_time_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of event_time_2 as text
%        str2double(get(hObject,'String')) returns contents of event_time_2 as a double


% --- Executes during object creation, after setting all properties.
function event_time_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to event_time_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Multiple_Callback(hObject, eventdata, handles)
% hObject    handle to Multiple (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Multiple as text
%        str2double(get(hObject,'String')) returns contents of Multiple as a double


% --- Executes during object creation, after setting all properties.
function Multiple_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Multiple (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function duration_Callback(hObject, eventdata, handles)
% hObject    handle to duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of duration as text
%        str2double(get(hObject,'String')) returns contents of duration as a double


% --- Executes during object creation, after setting all properties.
function duration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Event_FPS.
function Event_FPS_Callback(hObject, eventdata, handles)
% hObject    handle to Event_FPS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
handles=guidata(hObject);
if isfield(handles,'trail_data')
    if ~isempty(handles.trail_data)&&handles.trail_data.N~=0
        h=waitbar(0,'数据计算中，请稍等！！！');
        for ii=1:handles.trail_data.N
            eval(['trailmode=handles.trail_data.trailmode' num2str(ii) ';']);
            eval(['trail_data=handles.trail_data.data' num2str(ii) ';']);
            
            if trailmode==1
                times=trail_data.times;
                data=trail_data.psth1_mean;
            elseif trailmode==2
                %% 计算中
                times=trail_data.times;
                data=trail_data.data;
            end
            
            start_time=str2num(get(handles.event_time_1,'String'));
            if isempty(start_time)
                msgbox('请输入正确的时间格式！！！');
                return
            end
            end_time=str2num(get(handles.event_time_2,'String'));
            if isempty(end_time)
                msgbox('请输入正确的时间格式！！！');
                return
            end
            if start_time>end_time
                p=end_time;
                end_time=start_time;
                start_time=p;
                set(handles.event_time_1,'String',num2str(start_time));
                set(handles.event_time_2,'String',num2str(end_time));
            elseif start_time==end_time
                msgbox('参数范围设置错误！！');
                return
            end
            if start_time<=min(times(:))
                start_time=min(times(:));
                set(handles.event_time_1,'String',num2str(start_time));
            end
            if end_time>=max(times(:))
                end_time=max(times(:));
                set(handles.event_time_2,'String',num2str(end_time));
            end
            %%
            wave_FPS_label=times>=start_time & times<=end_time;
            wave_FPS =data(wave_FPS_label);
            %%
            
            data_line_2=zeros(length(wave_FPS),1);
            Multiple=str2num(get(handles.Multiple,'String'));
            if isempty(Multiple)
                set(handles.Multiple,'String',num2str(2.91));
                Multiple=2.91;
            end
            Mean_base=median(abs(wave_FPS(:)-median(wave_FPS)));
            %%
            data_line_index=find(wave_FPS(:)>Multiple*Mean_base);
            data_line_index_1=data_line_index(1:end-1);
            data_line_index_2=data_line_index(2:end);
            data_line_index_3=data_line_index_2-data_line_index_1;
            data_line_index_4=find(data_line_index_3(:)==1);
            data_line_index=[data_line_index data_line_index];
            for i=1:length(data_line_index_4)
                data_line_index(data_line_index_4(i):data_line_index_4(i)+1,2)=1;
            end
            %%
            data_line_index_n=data_line_index(:,2)==1;
            data_line_index_n=data_line_index(data_line_index_n,1);
            duration=str2num(get(handles.duration,'String'));
            if isempty(duration)
                set(handles.duration,'String',num2str(0.1));
                duration=0.1;
            end
            duration=round(duration*(1/(times(2)-times(1))));
            Event_Start_time=0;
            Event_Duration=0;
            Event_Max=0;
            Event_Average=0;
            Event_AUC=0;
            if isempty(data_line_index_n)
                data_line_index_n=data_line_index_n;
                figure('NumberTitle', 'off', 'Name', ['File' num2str(ii) ' Event Preview ']);
                plot(times,data,'red','LineWidth',1.5);
                hold on
                plot([times(1),times(end)],[Multiple*Mean_base,Multiple*Mean_base],'color',[0.5,0.5,0.5],'LineWidth',1.0);
                hold off
                Event_num=0;
                Event_Start_time=0;
                Event_Duration=0;
                Event_Max=0;
                Event_Average=0;
                Event_AUC=0;
                xlabel('Time (s)');
 
                ylabel('DeltaF/F(%)');
            else
                data_line_index_n_2=data_line_index_n(2:end)-data_line_index_n(1:end-1);
                data_line_index_n_2_index=find(data_line_index_n_2~=1);
                if isempty(data_line_index_n_2_index)
                    if length(data_line_index_n)<duration
                        data_line_index_n=[];
                        figure('NumberTitle', 'off', 'Name', ['File' num2str(ii) ' Event Preview ']);
                        time_fps=times(wave_FPS_label);
                        plot(time_fps,wave_FPS,'red','LineWidth',1.5);
                        hold on
                        plot([time_fps(1),time_fps(end)],[Multiple*Mean_base,Multiple*Mean_base],'color',[0.5,0.5,0.5],'LineWidth',1.0);
                        hold off
                        Event_num=0;
                        Event_Start_time=0;
                        Event_Duration=0;
                        Event_Max=0;
                        Event_Average=0;
                        Event_AUC=0;
                        xlabel('Time (s)');
                        ylabel('DeltaF/F(%)');
                    else
                        figure('NumberTitle', 'off', 'Name', ['File' num2str(ii) ' Event Preview ']);
                        time_fps=times(wave_FPS_label);
                        plot(time_fps,wave_FPS,'red','LineWidth',1.5);
                        hold on
                        exam=data_line_index_n;
                        %%
%                         fpsmax=ones(length(exam),1)*max(wave_FPS(:));
%                         fpsmax(1)=min(wave_FPS(:));
%                         fpsmax(end)=min(wave_FPS(:));
%                         fpsmin=ones(length(exam),1)*min(wave_FPS(:));
%                         plot(time_fps(exam),fpsmax,'Color','r','LineWidth',1);
%                         hold on
%                         plot(time_fps(exam),fpsmin,'Color','r','LineWidth',1);
                        
                        patch([time_fps(exam(1)) time_fps(exam(end)) time_fps(exam(end)) time_fps(exam(1))],[min(wave_FPS(:)) min(wave_FPS(:)) max(wave_FPS(:)) max(wave_FPS(:))],'blue','EdgeColor','none','FaceAlpha',0.4);
                        hold on
                        plot([time_fps(1),time_fps(end)],[Multiple*Mean_base,Multiple*Mean_base],'color',[0.5,0.5,0.5],'LineWidth',1.0);
                        hold off
                        xlabel('Time (s)');
    
                        ylabel('DeltaF/F(%)');
                        Event_num=1;
                        Event_Start_time=time_fps(exam(1));
                        Event_Duration=time_fps(exam(end))-time_fps(exam(1));
                        Event_Max=max(wave_FPS(exam));
                        Event_Average=mean(wave_FPS(exam));
                        Event_AUC=sum(wave_FPS(exam))*(time_fps(2)-time_fps(1));
                        
                        %%
                    end
                else
                    %%
                    Event_Start_time=[];
                    data_line_index_n_3=cell(1,length(data_line_index_n_2_index)+1);
                    data_line_index_n_3_size=zeros(1,length(data_line_index_n_2_index)+1);
                    for i=1:length(data_line_index_n_2_index)+1
                        if i==1
                            data_line_index_n_3{i}=data_line_index_n(1:data_line_index_n_2_index(1));
                            data_line_index_n_3_size(i)=length(data_line_index_n_3{i});
                        elseif i==length(data_line_index_n_2_index)+1
                            data_line_index_n_3{i}=data_line_index_n(data_line_index_n_2_index(end)+1:end);
                            data_line_index_n_3_size(i)=length(data_line_index_n_3{i});
                        else
                            data_line_index_n_3{i}=data_line_index_n(data_line_index_n_2_index(i-1)+1:data_line_index_n_2_index(i));
                            data_line_index_n_3_size(i)=length(data_line_index_n_3{i});
                        end
                    end
                    data_line_index_n_3_size_index=find(data_line_index_n_3_size<duration);
                    if ~isempty(data_line_index_n_3_size_index)
                        for i=1:length(data_line_index_n_3_size_index)
                            data_line_index_n_3{data_line_index_n_3_size_index(i)}=[];
                        end
                    end
                    data_line_index_n_3(cellfun(@isempty,data_line_index_n_3))=[];
                    figure('NumberTitle', 'off', 'Name', ['File' num2str(ii) ' Event Preview ']);
                    %%
                    time_fps=times(wave_FPS_label);
                    plot(time_fps,wave_FPS,'red','LineWidth',1.5);
                    hold on
%                     for i=1:length(data_line_index_n_3)
%                         exam=data_line_index_n_3{i};
%                         fpsmax=ones(length(exam),1)*max(wave_FPS(:));
%                         fpsmax(1)=min(wave_FPS(:));
%                         fpsmax(end)=min(wave_FPS(:));
%                         fpsmin=ones(length(exam),1)*min(wave_FPS(:));
%                         plot(time_fps(exam),fpsmax,'Color','r','LineWidth',1);
%                         hold on
%                         plot(time_fps(exam),fpsmin,'Color','r','LineWidth',1);
%                         Event_time=[Event_time;time_fps(exam(1))];
%                     end
                    x=zeros(4,length(data_line_index_n_3));
                    y=zeros(4,length(data_line_index_n_3));
                    y(1,:)=min(wave_FPS(:));
                    y(2,:)=min(wave_FPS(:));
                    y(3,:)=max(wave_FPS(:));
                    y(4,:)=max(wave_FPS(:));
                    for i=1:length(data_line_index_n_3)
                        exam=data_line_index_n_3{i};
                        x(1,i)=time_fps(exam(1));
                        x(2:3,i)=time_fps(exam(end));
                        x(4,i)=time_fps(exam(1));     
%                         fpsmax=ones(length(exam),1)*max(wave_FPS(:));
%                         fpsmax(1)=min(wave_FPS(:));
%                         fpsmax(end)=min(wave_FPS(:));
%                         fpsmin=ones(length(exam),1)*min(wave_FPS(:));
                        Event_Start_time(i,1)=time_fps(exam(1));
                        Event_Duration(i,1)=time_fps(exam(end))-time_fps(exam(1));
                        Event_Max(i,1)=max(wave_FPS(exam));
                        Event_Average(i,1)=mean(wave_FPS(exam));
                        Event_AUC(i,1)=sum(wave_FPS(exam))*(time_fps(2)-time_fps(1));
                    end
                    
                    
                    
                    
                    
                    patch(x,y,'blue','EdgeColor','none','FaceAlpha',0.4);
                    hold on
                    plot([time_fps(1),time_fps(end)],[Multiple*Mean_base,Multiple*Mean_base],'color',[0.5,0.5,0.5],'LineWidth',1.0);
                    hold off
                    xlabel('Time (s)');
   
                    ylabel('DeltaF/F(%)');
                    Event_num=length(data_line_index_n_3);
                end
                
            end
            %%
            Event_fps=Event_num/((end_time-start_time));
            event_cell=cell(1,1);
            event_cell{1}=num2str(Event_fps);
            Name=cell(1,1);
            Name{1}='Event FPS';
            
            EvaluationStartTime=start_time;
            EvaluationEndTime=end_time;
            %%
            eval(['file_path_and_name_trail=handles.file_path_and_name_trail' num2str(ii) ';']);
            MAT_name=strrep(file_path_and_name_trail,'.mat','_Event_FPS.mat');
            xls_name=strrep(MAT_name,'.mat','.csv');
            
           
            %%
            Bar=cell(1,5);
            Bar{1}='Event_fps';
            Bar{2}='EvaluationStartTime';
            Bar{3}='EvaluationEndTime';
            Bar{4}='Multiple';
            Bar{5}='Event_num';
            %         Bar{6}='Event_time';
            value_fps=cell(1,5);
            value_fps{1}=num2str(Event_fps);
            value_fps{2}=num2str(EvaluationStartTime);
            value_fps{3}=num2str(EvaluationEndTime);
            value_fps{4}=num2str(Multiple);
            value_fps{5}=num2str(Event_num);
            %         xlswrite(xlsx_name,Bar,xlRange_header);
            %             xlswrite(xlsx_name,AUC,xlRange_data);
            Bar_data=cell(length(Event_Start_time)+1,5);
            
            Bar_data{1,1}='Event_Start_time';
            Bar_data{1,2}='Event_Duration';
            Bar_data{1,3}='Event_Max';
            Bar_data{1,4}='Event_Average';
            Bar_data{1,5}='Event_AUC';
            
            for i=1:length(Event_Start_time)
                Bar_data{i+1,1}=num2str(Event_Start_time(i));
                Bar_data{i+1,2}=num2str(Event_Duration(i));
                Bar_data{i+1,3}=num2str(Event_Max(i));
                Bar_data{i+1,4}=num2str(Event_Average(i));
                Bar_data{i+1,5}=num2str(Event_AUC(i));
            end
            %%
            xlRange_header=['A1:E2'];
            xlRange_data=['F1:J' num2str(length(Event_Start_time)+1)];
            if isempty(Event_Start_time)
                csvdata=cell(2,5);
                csvdata{1,1}='Event_fps';
                csvdata{1,2}='EvaluationStartTime';
                csvdata{1,3}='EvaluationEndTime';
                csvdata{1,4}='Multiple';
                csvdata{1,5}='Event_num';
                
                csvdata{2,1}=value_fps{1};
                csvdata{2,2}=value_fps{2};
                csvdata{2,3}=value_fps{3};
                csvdata{2,4}=value_fps{4};
                csvdata{2,5}=value_fps{5};
            else
                csvdata=cell(length(Event_Start_time)+1,5);
                csvdata{1,1}='Event_fps';
                csvdata{1,2}='EvaluationStartTime';
                csvdata{1,3}='EvaluationEndTime';
                csvdata{1,4}='Multiple';
                csvdata{1,5}='Event_num';
                
                csvdata{2,1}=value_fps{1};
                csvdata{2,2}=value_fps{2};
                csvdata{2,3}=value_fps{3};
                csvdata{2,4}=value_fps{4};
                csvdata{2,5}=value_fps{5};
                
                csvdata{1,6}='Event_Start_time';
                csvdata{1,7}='Event_Duration';
                csvdata{1,8}='Event_Max';
                csvdata{1,9}='Event_Average';
                csvdata{1,10}='Event_AUC';
                
                for i=1:length(Event_Start_time)
                    csvdata{i+1,6}=num2str(Event_Start_time(i));
                    csvdata{i+1,7}=num2str(Event_Duration(i));
                    csvdata{i+1,8}=num2str(Event_Max(i));
                    csvdata{i+1,9}=num2str(Event_Average(i));
                    csvdata{i+1,10}=num2str(Event_AUC(i));
                end
                
            end
            
            fid = fopen(xls_name, 'w+', 'n', 'utf8');
            for i=1:size(csvdata,1)
                for j=1:size(csvdata,2)
                    if j==size(csvdata,2)
                        fprintf(fid, '%s\n', csvdata{i,j});
                    else
                        fprintf(fid, '%s,', csvdata{i,j});
                    end
                end
            end
            fclose(fid);          
%             try
%                 delete(xls_name);
%                 warning off
%                 xlswrite(xls_name,[Bar; value_fps],xlRange_header);
%                 xlswrite(xls_name,Bar_data,xlRange_data);
%             catch
%             end
            save(MAT_name,'Event_fps','EvaluationStartTime','EvaluationEndTime','Multiple','Event_num','Event_Start_time','Event_Duration','Event_Max','Event_Average','Event_AUC');  
            waitbar(ii/handles.trail_data.N,h,['第' num2str(ii) '组数据已经计算完成']);
        end
        waitbar(1,h,['计算完成']);
        close(h);
    else
        return
    end
end
guidata(hObject,handles);


% --- Executes on button press in Plotting_Mean.
function Plotting_Mean_Callback(hObject, eventdata, handles)
% hObject    handle to Plotting_Mean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
handles=guidata(hObject);
if isfield(handles,'plot_average')
    if handles.plot_average_mode==1
        msgbox('读取的数据时间长度不相同，不能计算平均值！！！！');
        return
    end
    clims_from=str2num(get(handles.clims_from,'String'));
    clims_to=str2num(get(handles.clims_to,'String'));
    if clims_from==clims_to
        clims=[];
    else
        clims=[clims_from,clims_to];
    end
    if ~isempty(handles.plot_average.plot_Data)
        plot_sem = std(handles.plot_average.plot_Data)/(size(handles.plot_average.plot_Data,1)-1)^0.5;%计算psth_sem公式，用数据的方差与数据长度做对比；
        plot_mean = mean(handles.plot_average.plot_Data,1);
        figure('NumberTitle', 'off', 'Name', 'Avearge data Preview ');
        drawErrorLine(handles.plot_average.plot_times,plot_mean,plot_sem,'red',0.5);
        if isempty(clims)
            figure('NumberTitle', 'off', 'Name', 'Heatmap Preview ');
            imagesc(handles.plot_average.plot_times,1:1:size(handles.plot_average.plot_Data,1),handles.plot_average.plot_Data);
        else
            figure('NumberTitle', 'off', 'Name', 'Heatmap Preview ');
            imagesc(handles.plot_average.plot_times,1:1:size(handles.plot_average.plot_Data,1),handles.plot_average.plot_Data,clims);
        end
        colormap(jet);
        data=plot_mean;
        times=handles.plot_average.plot_times;
        times=times-times(1);
        %%
        
        data_all=handles.plot_average.plot_Data;
        data=plot_mean;
        %%
        name=[handles.plot_av_filepath,'PlotMeanData.mat'];
        xlsname=strrep(name,'.mat','.csv');
        %         [~,name2,suffix]=fileparts(name);
        %         name=[name2 suffix];
        dig=['是否想要另存为数据文件? 如果选择no, 数据将保存在 ' name '!!!'];
        choice=questdlg(dig, ...
            'Selection Dialog', ...
            'Yes', 'No','No');
        %%
        
        xlsx_header=cell(1,3+size(data_all,1));
        xlsx_header{1,2}='times';
        xlsx_header{1,1}='data';
        for i=1:size(data_all,1)
            xlsx_header{1,2+i}=['data_read_' num2str(i)];
        end
        if size(data_all,1)==1
            plot_sem=zeros(size(times));
        end
        xlsx_header{1,end}='plot_sem';
        
        times=times-times(1);
        data_plot=[data;times;data_all;plot_sem]';
        
        h=waitbar(0,'数据保存中');
        
        if isempty(choice)
            save(name,'data','times','plot_sem','data_all');
            waitbar(0.4,h);
            fid = fopen(xlsname, 'w+', 'n', 'utf8');
            for i=1:(3+size(data_all,1))
                if i<(3+size(data_all,1))
                    fprintf(fid, '%s,', xlsx_header{1,i});
                else
                    fprintf(fid, '%s\n', xlsx_header{1,i});
                end
            end
            
            for i=1:length(times)
                for j=1:(3+size(data_all,1))
                    if j==1
                        fprintf(fid, '%.5f,', data(i));
                    elseif j==2
                        fprintf(fid, '%.5f,', times(i));
                    elseif j<size(data_all,1)+3&&j>2
                        fprintf(fid, '%.5f,', data_all(j-2,i));
                    elseif j==size(data_all,1)+3
                        fprintf(fid, '%.5f\n', plot_sem(i));
                    end
                end
            end
            fclose(fid);
            %             try
            %                 delete(xlsname);
            %                 waitbar(0.5,h);
            %                 xlswrite(xlsname,xlsx_header,1,'A1');
            %                 waitbar(0.6,h);
            %                 xlswrite(xlsname,data_plot,1,'A2');
            %                 waitbar(0.9,h);
            %             catch
            %             end
            waitbar(1,h);
            close(h)
        else
            if strcmp(choice,'No')
                save(name,'data','times','plot_sem','data_all');
                waitbar(0.4,h);
                fid = fopen(xlsname, 'w+', 'n', 'utf8');
                for i=1:(3+size(data_all,1))
                    if i<(3+size(data_all,1))
                        fprintf(fid, '%s,', xlsx_header{1,i});
                    else
                        fprintf(fid, '%s\n', xlsx_header{1,i});
                    end
                end
                
                for i=1:length(times)
                    for j=1:(3+size(data_all,1))
                        if j==1
                            fprintf(fid, '%.5f,', data(i));
                        elseif j==2
                            fprintf(fid, '%.5f,', times(i));
                        elseif j<size(data_all,1)+3&&j>2
                            fprintf(fid, '%.5f,', data_all(j-2,i));
                        elseif j==size(data_all,1)+3
                            fprintf(fid, '%.5f\n', plot_sem(i));
                        end
                    end
                end
                fclose(fid);
                waitbar(1,h);
                close(h)
            elseif strcmp(choice,'Yes')
                [SaveFileName,SavePathName,SaveIndex] = uiputfile('*.mat;','Save as',handles.plot_av_filepath); %设置默认路径
                if isequal(SaveFileName,0) || isequal(SavePathName,0) || isequal(SaveIndex,0)
                    disp('User seleceted Cancel');
                    save(name,'data','times','plot_sem','data_all');
                    waitbar(0.4,h);
                    fid = fopen(xlsname, 'w+', 'n', 'utf8');
                    for i=1:(3+size(data_all,1))
                        if i<(3+size(data_all,1))
                            fprintf(fid, '%s,', xlsx_header{1,i});
                        else
                            fprintf(fid, '%s\n', xlsx_header{1,i});
                        end
                    end
                    
                    for i=1:length(times)
                        for j=1:(3+size(data_all,1))
                            if j==1
                                fprintf(fid, '%.5f,', data(i));
                            elseif j==2
                                fprintf(fid, '%.5f,', times(i));
                            elseif j<size(data_all,1)+3&&j>2
                                fprintf(fid, '%.5f,', data_all(j-2,i));
                            elseif j==size(data_all,1)+3
                                fprintf(fid, '%.5f\n', plot_sem(i));
                            end
                        end
                    end
                    fclose(fid);
                    waitbar(1,h);
                    close(h)
                else
                    path=[SavePathName SaveFileName];
                    save(path,'data','times','plot_sem','data_all');
                    xlsname=strrep(path,'.mat','.csv');
                    fid = fopen(xlsname, 'w+', 'n', 'utf8');
                    for i=1:(3+size(data_all,1))
                        if i<(3+size(data_all,1))
                            fprintf(fid, '%s,', xlsx_header{1,i});
                        else
                            fprintf(fid, '%s\n', xlsx_header{1,i});
                        end
                    end
                    
                    for i=1:length(times)
                        for j=1:(3+size(data_all,1))
                            if j==1
                                fprintf(fid, '%.5f,', data(i));
                            elseif j==2
                                fprintf(fid, '%.5f,', times(i));
                            elseif j<size(data_all,1)+3&&j>2
                                fprintf(fid, '%.5f,', data_all(j-2,i));
                            elseif j==size(data_all,1)+3
                                fprintf(fid, '%.5f\n', plot_sem(i));
                            end
                        end
                    end
                    fclose(fid);
                    waitbar(1,h);
                    close(h)
                end
            end
        end
        %%
    else
        return
    end
else
    return
end


% --- Executes on button press in LoadPlotDatas.
function LoadPlotDatas_Callback(hObject, eventdata, handles)
% hObject    handle to LoadPlotDatas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
global passdata 
if isfield(passdata,'readpath')
    [FileName_all,FilePath]=uigetfile({'*.mat'},'mat文件读取','MultiSelect','on',passdata.readpath);%读取多个mat文件
else
    [FileName_all,FilePath]=uigetfile({'*.mat'},'mat文件读取','MultiSelect','on');%读取多个mat文件
end

if isnumeric(FileName_all)
    return;
end
passdata.readpath=FilePath(1:end-1);

if ischar(FileName_all)
    plot_AverIndex=1;
    msgbox('读取文件数量为1，请重新读取多个文件');
    return
    file=[FilePath,FileName_all];
    data=load(file);
    if ~isfield(data,'data')
        msgbox('请读取正确的 delatf/f 数据!!!!');
        clc
        handles.plot_average.plot_Data=[];
        handles.plot_average.plot_times=[];
        handles.plot_average.plot_sems=[];
        return;
    end
    if size(data.data,1)~=1
        data.data=data.data';
        
    end
    if size(data.times,1)~=1
        data.times=data.times';
    end
    handles.plot_average.plot_Data=[];
    handles.plot_average.plot_times=[];
    
    handles.plot_average.plot_sems=[];
    if isfield(data,'plot_sem')
        if size(data.plot_sem,1)~=1
            handles.plot_average.plot_sems.data1=data.plot_sem';
        else
            handles.plot_average.plot_sems.data1=data.plot_sem;
        end
    end
    handles.plot_average.plot_Data=data.data;
    handles.plot_average.plot_times=data.times;
    set(handles.plot_files,'String',FilePath);
    handles.plot_av_filepath=FilePath;
    passdata.readpath=FilePath;
else
    plot_AverIndex=size(FileName_all,2);
    file=[FilePath,char(FileName_all(1))];
    data=load(file);
    if ~isfield(data,'data')
        msgbox('请读取正确的 delatf/f 数据!!!!');
        clc
        handles.plot_average.plot_Data=[];
        handles.plot_average.plot_times=[];
        handles.plot_average.plot_sems=[];
        return;
    end
    times=data.times;
    if size(data.data,1)~=1
        data.data=data.data';
        
    end
    if size(data.times,1)~=1
        data.times=data.times';
    end
    %                 plot
    filelength=size(data.data,2);
    
    handles.plot_average.plot_times=data.times-data.times(1);
    handles.plot_average.plot_Data=[];
    handles.plot_average.plot_sems=[];
    plot_average_mode=0;
    for i=1:plot_AverIndex
        file=[FilePath,char(FileName_all(i))];
        data=load(file);
        %%
        if ~isfield(data,'data')
            msgbox('请读取正确的plotting结果数据！！！');
            return
        end
        
        if round(times(end)-times(1))~=round(data.times(end)-data.times(1))
            plot_average_mode=1;
            eval(['handles.plot_average.plot_Data' num2str(i) '=data.data;']);
            eval(['handles.plot_average.plot_times' num2str(i) '=data.times-data.times(1);']);
            %             handles.plot_average.plot_Data=[];
            %             handles.plot_average.plot_times=[];
            
            if isfield(data,'plot_sem')
                if size(data.plot_sem,1)~=1
                    data.plot_sem=data.plot_sem';
                    eval(['handles.plot_average.plot_sems.data' num2str(i) '=data.plot_sem;']);
                else
                    eval(['handles.plot_average.plot_sems.data' num2str(i) '=data.plot_sem;']);
                end
            end
        else
            if size(data.data,1)~=1
                data.data=data.data';
            end
            if size(data.data,2)~=filelength
                data.data=imresize(data.data,[1,filelength]);
                data.times=imresize(data.times,[1,filelength]);
            end
            eval(['handles.plot_average.plot_Data' num2str(i) '=data.data;']);
            eval(['handles.plot_average.plot_times' num2str(i) '=data.times-data.times(1);']);
            
            handles.plot_average.plot_Data=[handles.plot_average.plot_Data;data.data];
            if isfield(data,'plot_sem')
                if size(data.plot_sem,1)~=1
                    data.plot_sem=data.plot_sem';
                    eval(['handles.plot_average.plot_sems.data' num2str(i) '=data.plot_sem;']);
                else
                    eval(['handles.plot_average.plot_sems.data' num2str(i) '=data.plot_sem;']);
                end
            end
        end
        
        %%
        set(handles.plot_files,'String',FilePath);
        handles.plot_av_filepath=FilePath;
        passdata.readpath=FilePath;
    end
    if plot_average_mode==1
        clear handles.plot_average.plot_Data;
        clear handles.plot_average.plot_sems.data;
    end
    handles.plot_average_name=FileName_all;
    handles.plot_AverIndex=plot_AverIndex;
    handles.plot_average_mode=plot_average_mode;
end
guidata(hObject,handles);
msgbox('读取完成！！');
guidata(hObject,handles);



function plot_files_Callback(hObject, eventdata, handles)
% hObject    handle to plot_files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of plot_files as text
%        str2double(get(hObject,'String')) returns contents of plot_files as a double


% --- Executes during object creation, after setting all properties.
function plot_files_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plot_files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rgb6_Callback(hObject, eventdata, handles)
% hObject    handle to rgb6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rgb6 as text
%        str2double(get(hObject,'String')) returns contents of rgb6 as a double


% --- Executes during object creation, after setting all properties.
function rgb6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rgb6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rgb5_Callback(hObject, eventdata, handles)
% hObject    handle to rgb5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rgb5 as text
%        str2double(get(hObject,'String')) returns contents of rgb5 as a double


% --- Executes during object creation, after setting all properties.
function rgb5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rgb5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rgb4_Callback(hObject, eventdata, handles)
% hObject    handle to rgb4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rgb4 as text
%        str2double(get(hObject,'String')) returns contents of rgb4 as a double


% --- Executes during object creation, after setting all properties.
function rgb4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rgb4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rgb3_Callback(hObject, eventdata, handles)
% hObject    handle to rgb3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rgb3 as text
%        str2double(get(hObject,'String')) returns contents of rgb3 as a double


% --- Executes during object creation, after setting all properties.
function rgb3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rgb3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rgb2_Callback(hObject, eventdata, handles)
% hObject    handle to rgb2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rgb2 as text
%        str2double(get(hObject,'String')) returns contents of rgb2 as a double


% --- Executes during object creation, after setting all properties.
function rgb2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rgb2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rgb1_Callback(hObject, eventdata, handles)
% hObject    handle to rgb1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rgb1 as text
%        str2double(get(hObject,'String')) returns contents of rgb1 as a double


% --- Executes during object creation, after setting all properties.
function rgb1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rgb1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in UsingMeanData.
function UsingMeanData_Callback(hObject, eventdata, handles)
% hObject    handle to UsingMeanData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of UsingMeanData


% --- Executes on button press in Average_Mean.
function Average_Mean_Callback(hObject, eventdata, handles)
% hObject    handle to Average_Mean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
handles=guidata(hObject);
if isfield(handles,'load_trails_data')
    if handles.load_trails_mode~=0
        msgbox('读取的数据时间长度不相同，不能计算平均值！！！！');
        return
    end
    clims_from=str2num(get(handles.clims_from,'String'));
    clims_to=str2num(get(handles.clims_to,'String'));
    if clims_from==clims_to
        clims=[];
    else
        clims=[clims_from,clims_to];
    end
    if isempty(handles.load_trails_data.psth_sem_all) || isempty(handles.load_trails_data.psth1)
        return;
    end
    if handles.file_N>1
        usingmean=get(handles.UsingMeanData,'Value');
        if usingmean==1
            N=handles.file_N;
            Data_mean=sum(handles.load_trails_data.psth_ALL)/N;
            psth1=handles.load_trails_data.psth_ALL;
            psth_mean=Data_mean;
            psth_sem=std(handles.load_trails_data.psth_ALL)/(N-1)^0.5;
        else
            Data_mean=sum(handles.load_trails_data.psth1)/size(handles.load_trails_data.psth1,1);
            psth1=handles.load_trails_data.psth1;
            psth_mean=Data_mean;
            psth_sem=std(handles.load_trails_data.psth1)/(size(handles.load_trails_data.psth1,1)-1)^0.5;
        end
    elseif handles.file_N==1
        psth_mean=handles.load_trails_data.psth_mean;
        psth_sem=handles.load_trails_data.psth_sem;
        psth1=handles.load_trails_data.psth1;
    end
    %% 绘图中
    figure('NumberTitle', 'off', 'Name', 'Average/mice delatf/f data Preview ');
    drawErrorLine(handles.load_trails_data.psth_times,psth_mean,psth_sem,'red',0.5);
    xlabel('Time (s)');
    if handles.file_N>1
        if isempty(clims)
            figure('NumberTitle', 'off', 'Name', 'Average/mice Meantrail heatmap Preview ');
            imagesc(handles.load_trails_data.psth_times,1:1:size(handles.load_trails_data.psth_ALL,1),handles.load_trails_data.psth_ALL);
            colormap(jet);
            figure('NumberTitle', 'off', 'Name', 'Average/mice Alltrail heatmap Preview ');
            imagesc(handles.load_trails_data.psth_times,1:1:size(handles.load_trails_data.psth1,1),handles.load_trails_data.psth1);
            colormap(jet);
            xlabel('Time (s)');
        else
            figure('NumberTitle', 'off', 'Name', 'Average/mice Meantrail heatmap Preview ');
            imagesc(handles.load_trails_data.psth_times,1:1:size(handles.load_trails_data.psth_ALL,1),handles.load_trails_data.psth_ALL,clims);
            colormap(jet);
            figure('NumberTitle', 'off', 'Name', 'Average/mice Alltrail heatmap Preview ');
            imagesc(handles.load_trails_data.psth_times,1:1:size(handles.load_trails_data.psth1,1),handles.load_trails_data.psth1,clims);
            colormap(jet);
            xlabel('Time (s)');
        end
    elseif handles.file_N==1
        if isempty(clims)
            figure('NumberTitle', 'off', 'Name', 'Average/mice Alltrail heatmap Preview ');
            imagesc(handles.load_trails_data.psth_times,1:1:size(handles.load_trails_data.psth1,1),handles.load_trails_data.psth1);
            colormap(jet);
            xlabel('Time (s)');
        else
            figure('NumberTitle', 'off', 'Name', 'Average/mice Alltrail heatmap Preview ');
            imagesc(handles.load_trails_data.psth_times,1:1:size(handles.load_trails_data.psth1,1),handles.load_trails_data.psth1,clims);
            colormap(jet);
            xlabel('Time (s)');
        end
    end
    %%

    %%
    psth1_mean=psth_mean;
    
    times=handles.load_trails_data.psth_times;
    psth1_sem=psth_sem;
    %% 保存中
    name=[handles.FilePath,'AverageMeanData.mat'];
    %     [~,name,suffix]=fileparts(name);
    %     name=[name suffix];
    dig=['是否想要另存为数据文件? 如果选择no, 数据将保存在 ' name '!!!'];
    choice=questdlg(dig, ...
        'Selection Dialog', ...
        'Yes', 'No','No');
    xlsname=strrep(name,'.mat','.csv');
    xlsx_header=cell(1,size(psth1,1)+3);
    for i=1:size(psth1,1)
        xlsx_header{1,i}=['psth1_' num2str(i)];
    end
    xlsx_header{1,end}='times';
    xlsx_header{1,end-1}='psth1_sem';
    xlsx_header{1,end-2}='psth1_mean';
    if size(psth1,1)==1
        psth1_sem=zeros(size(psth1_mean));
    end
    data=[psth1;psth1_mean;psth1_sem;times]';
    h=waitbar(0,'数据存储中');
    
    if isempty(choice)
        save([handles.FilePath,'AverageMeanData.mat'],'psth1_mean','psth1','times','psth1_sem');
        
        waitbar(0.4,h);
        %         try
        %             delete(xlsname);
        %             waitbar(0.5,h);
        %             xlswrite(xlsname,xlsx_header,1,'A1');
        %             waitbar(0.6,h);
        %             xlswrite(xlsname,data,1,'A2');
        %             waitbar(0.9,h);
        %         catch
        %         end
        fid = fopen(xlsname, 'w+', 'n', 'utf8');
        for i=1:(size(psth1,1)+3)
            if i<(size(psth1,1)+3)
                fprintf(fid, '%s,', xlsx_header{1,i});
            else
                fprintf(fid, '%s\n', xlsx_header{1,i});
            end
        end
        
        for i=1:length(psth1_sem)
            for j=1:size(psth1,1)+3
                if j<=size(psth1,1)
                    fprintf(fid, '%.5f,', psth1(j,i));
                elseif j==size(psth1,1)+1
                    fprintf(fid, '%.5f,', psth1_mean(i));
                elseif j==size(psth1,1)+2
                    fprintf(fid, '%.5f,', psth1_sem(i));
                elseif j==size(psth1,1)+3
                    fprintf(fid, '%.5f\n', times(i));
                end
            end
        end
        fclose(fid);
        
        waitbar(1,h,'保存完成');
        close(h);
        
    else
        if strcmp(choice,'No')
            save([handles.FilePath,'AverageMeanData.mat'],'psth1_mean','psth1','times','psth1_sem');
            
            waitbar(0.4,h);
            fid = fopen(xlsname, 'w+', 'n', 'utf8');
            for i=1:(size(psth1,1)+3)
                if i<(size(psth1,1)+3)
                    fprintf(fid, '%s,', xlsx_header{1,i});
                else
                    fprintf(fid, '%s\n', xlsx_header{1,i});
                end
            end
            
            for i=1:length(psth1_sem)
                for j=1:size(psth1,1)+3
                    if j<=size(psth1,1)
                        fprintf(fid, '%.5f,', psth1(j,i));
                    elseif j==size(psth1,1)+1
                        fprintf(fid, '%.5f,', psth1_mean(i));
                    elseif j==size(psth1,1)+2
                        fprintf(fid, '%.5f,', psth1_sem(i));
                    elseif j==size(psth1,1)+3
                        fprintf(fid, '%.5f\n', times(i));
                    end
                end
            end
            fclose(fid);
        
%             try
%                 delete(xlsname);
%                 waitbar(0.5,h);
%                 xlswrite(xlsname,xlsx_header,1,'A1');
%                 waitbar(0.6,h);
%                 xlswrite(xlsname,data,1,'A2');
%                 waitbar(0.9,h);
%             catch
%             end
            waitbar(1,h,'保存完成');
            close(h);
            
        elseif strcmp(choice,'Yes')
            [SaveFileName,SavePathName,SaveIndex] = uiputfile('*.mat;','Save as',handles.FilePath); %设置默认路径
            if isequal(SaveFileName,0) || isequal(SavePathName,0) || isequal(SaveIndex,0)
                disp('User seleceted Cancel');
                save([handles.FilePath,'AverageMeanData.mat'],'psth1_mean','psth1','times','psth1_sem');
                waitbar(0.4,h);
                fid = fopen(xlsname, 'w+', 'n', 'utf8');
                for i=1:(size(psth1,1)+3)
                    if i<(size(psth1,1)+3)
                        fprintf(fid, '%s,', xlsx_header{1,i});
                    else
                        fprintf(fid, '%s\n', xlsx_header{1,i});
                    end
                end
                
                for i=1:length(psth1_sem)
                    for j=1:size(psth1,1)+3
                        if j<=size(psth1,1)
                            fprintf(fid, '%.5f,', psth1(j,i));
                        elseif j==size(psth1,1)+1
                            fprintf(fid, '%.5f,', psth1_mean(i));
                        elseif j==size(psth1,1)+2
                            fprintf(fid, '%.5f,', psth1_sem(i));
                        elseif j==size(psth1,1)+3
                            fprintf(fid, '%.5f\n', times(i));
                        end
                    end
                end
                fclose(fid);
                waitbar(1,h,'保存完成');
                close(h);
            else
                path=[SavePathName SaveFileName];
                save(path,'psth1_mean','psth1','times','psth1_sem');
                %这里保存所有读入的视频的处理结果
                xlsname=strrep(path,'.mat','.csv');
                waitbar(0.4,h);
                fid = fopen(xlsname, 'w+', 'n', 'utf8');
                for i=1:(size(psth1,1)+3)
                    if i<(size(psth1,1)+3)
                        fprintf(fid, '%s,', xlsx_header{1,i});
                    else
                        fprintf(fid, '%s\n', xlsx_header{1,i});
                    end
                end
                
                for i=1:length(psth1_sem)
                    for j=1:size(psth1,1)+3
                        if j<=size(psth1,1)
                            fprintf(fid, '%.5f,', psth1(j,i));
                        elseif j==size(psth1,1)+1
                            fprintf(fid, '%.5f,', psth1_mean(i));
                        elseif j==size(psth1,1)+2
                            fprintf(fid, '%.5f,', psth1_sem(i));
                        elseif j==size(psth1,1)+3
                            fprintf(fid, '%.5f\n', times(i));
                        end
                    end
                end
                fclose(fid);
                waitbar(1,h,'保存完成');
                close(h);
            end
        end
    end
    %%
else
    return
end


% --- Executes on button press in LoadTrails.
function LoadTrails_Callback(hObject, eventdata, handles)
% hObject    handle to LoadTrails (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
global passdata
if isfield(passdata,'readpath')
    [FileName_all,FilePath]=uigetfile({'*.mat'},'MultiSelect','on','mat文件读取',passdata.readpath);
else
    [FileName_all,FilePath]=uigetfile({'*.mat'},'MultiSelect','on','mat文件读取');
end
if isnumeric(FileName_all)
    return;
end

passdata.readpath=FilePath(1:end-1);

if ischar(FileName_all)
    N=1;
    msgbox('该模块针对多个数据处理，请重新读取文件！！！');
    return;
    string_path=[FilePath,FileName_all];
    example=load(string_path);
    if ~isfield(example,'psth1_mean')
        msgbox('请读取正确格式average之后的数据！！');
        clc
        handles.load_trails_data.psth1=[];
        handles.load_trails_data.psth_sem_all=[];
        handles.load_trails_data.psth_ALL=[];
        handles.load_trails_data.psth_mean=[];
        handles.load_trails_data.psth_times=[];
        handles.load_trails_data.psth_sem=[];
        return;
    else
        if size(example.times,1)>size(example.times,2)
            example.times=example.times';
        end
        if size(example.psth_mean,1)>size(example.psth_mean,2)
            example.psth_mean=example.psth_mean';
        end
        if size(example.psth_sem,1)>size(example.psth_sem,2)
            example.psth_sem=example.psth_sem';
        end
        if size(example.psth1,1)>size(example.psth1,2)
            example.psth1=example.psth1';
        end
    
        handles.load_trails_data.psth1=example.psth1;
        handles.load_trails_data.psth_sem_all=example.psth1_sem;
        handles.load_trails_data.psth_ALL=example.psth1;
        handles.load_trails_data.psth_mean=example.psth1_mean;
        handles.load_trails_data.psth_times=example.times;
        handles.load_trails_data.psth_sem=example.psth1_sem;
    end
    set(handles.loadtrails_file,'String',FilePath);
    handles.FilePath=FilePath;
else
    N=size(FileName_all,2);
    string_path=[FilePath,char(FileName_all(1))];
    example=load(string_path);
    if ~isfield(example,'psth1_mean')
        msgbox('请读取正确格式average之后的数据！！');
        clc
        handles.load_trails_data.psth1=[];
        handles.load_trails_data.psth_sem_all=[];
        handles.load_trails_data.psth_ALL=[];
        handles.load_trails_data.psth_mean=[];
        handles.load_trails_data.psth_times=[];
        handles.load_trails_data.psth_sem=[];
        return;
    end
    clc
    handles.load_trails_data.psth1=[];
    handles.load_trails_data.psth_sem_all=[];
    handles.load_trails_data.psth_ALL=[];
    handles.load_trails_data.psth_mean=[];
    handles.load_trails_data.psth_times=[];
    handles.load_trails_data.psth_sem=[];
    
    if size(example.times,1)>size(example.times,2)
        example.times=example.times';
    end
    if size(example.psth1_mean,1)>size(example.psth1_mean,2)
        example.psth1_mean=example.psth1_mean';
    end
    if size(example.psth1_sem,1)>size(example.psth1_sem,2)
        example.psth1_sem=example.psth1_sem';
    end
    if size(example.psth1,1)>size(example.psth1,2)
        example.psth1=example.psth1';
    end
    
    %%
    times=example.times;
    handles.load_trails_data.psth_times=example.times;
    Long=length(example.psth1_mean);
    Data=[];
    handles.load_trails_data.psth_sem_all=[];
    load_trails_mode=0;
    for i=1:N
        string_path=[FilePath,char(FileName_all(i))];
        example=load(string_path);
        if ~isfield(example,'psth1_mean')
            msgbox('请读取正确格式average之后的数据！！');
            clc
            handles.load_trails_data.psth1=[];
            handles.load_trails_data.psth_sem_all=[];
            handles.load_trails_data.psth_ALL=[];
            handles.load_trails_data.psth_mean=[];
            handles.load_trails_data.psth_times=[];
            handles.load_trails_data.psth_sem=[];
            return;
        end
        if size(example.psth1_mean,1)>size(example.psth1_mean,2)
            example.psth1_mean=example.psth1_mean';
        end
        if size(example.psth1_sem,1)>size(example.psth1_sem,2)
            example.psth1_sem=example.psth1_sem';
        end
        
        if size(example.psth1,1)>size(example.psth1,2)
            example.psth1=example.psth1';
        end
        if size(example.times,1)>size(example.times,2)
            example.times=example.times';
        end
        
        if round(example.times(1))~=round(times(1)) || round(example.times(end))~=round(times(end))
            load_trails_mode=1;
            eval(['handles.load_trails.psth1_mean' num2str(i) '=example.psth1_mean;']);
            eval(['handles.load_trails.psth1' num2str(i) '=example.psth1;']);
            eval(['handles.load_trails.psth1_sem' num2str(i) '=example.psth1_sem;']);
            eval(['handles.load_trails.times' num2str(i) '=example.times;']);
        else
            if size(example.psth1_mean,2)~=Long
                example.psth1_mean=imresize(example.psth1_mean,[1,Long]);
                example.psth1=imresize(example.psth1,[size(example.psth1,1),Long]);
                example.psth1_sem=imresize(example.psth1_sem,[1,Long]);
                example.times=imresize(example.times,[1,Long]);
            end
            Data=[Data;example.psth1_mean];
            handles.load_trails_data.psth1=[handles.load_trails_data.psth1;example.psth1];
            handles.load_trails_data.psth_sem_all=[handles.load_trails_data.psth_sem_all;example.psth1_sem];
            
            eval(['handles.load_trails.psth1_mean' num2str(i) '=example.psth1_mean;']);
            eval(['handles.load_trails.psth1' num2str(i) '=example.psth1;']);
            eval(['handles.load_trails.psth1_sem' num2str(i) '=example.psth1_sem;']); 
            eval(['handles.load_trails.times' num2str(i) '=example.times;']);
        end

    end
    if load_trails_mode==0
        handles.load_trails_data.psth_ALL=Data;
        
    elseif load_trails_mode==1
        clear handles.load_trails_data.psth1;
        clear handles.load_trails_data.psth_sem_all;
        clear handles.load_trails_data.psth_ALL;
        clear handles.load_trails_data.psth_mean;
        clear handles.load_trails_data.psth_times;
        clear handles.load_trails_data.psth_sem;
    end
    %%
end
handles.load_trails_name=FileName_all;
handles.file_N=N;
handles.load_trails_mode=load_trails_mode;
set(handles.loadtrails_file,'String',FilePath);
passdata.readpath=FilePath;
handles.FilePath=FilePath;
guidata(hObject,handles);
msgbox('数据读取成功!!! ');
guidata(hObject,handles);




function loadtrails_file_Callback(hObject, eventdata, handles)
% hObject    handle to loadtrails_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of loadtrails_file as text
%        str2double(get(hObject,'String')) returns contents of loadtrails_file as a double


% --- Executes during object creation, after setting all properties.
function loadtrails_file_CreateFcn(hObject, eventdata, handles)
% hObject    handle to loadtrails_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function clims_from_Callback(hObject, eventdata, handles)
% hObject    handle to clims_from (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of clims_from as text
%        str2double(get(hObject,'String')) returns contents of clims_from as a double


% --- Executes during object creation, after setting all properties.
function clims_from_CreateFcn(hObject, eventdata, handles)
% hObject    handle to clims_from (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function clims_to_Callback(hObject, eventdata, handles)
% hObject    handle to clims_to (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of clims_to as text
%        str2double(get(hObject,'String')) returns contents of clims_to as a double


% --- Executes during object creation, after setting all properties.
function clims_to_CreateFcn(hObject, eventdata, handles)
% hObject    handle to clims_to (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function Event_FPS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Event_FPS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function AUC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AUC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in Plotting_Combine.
function Plotting_Combine_Callback(hObject, eventdata, handles)
% hObject    handle to Plotting_Combine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles=guidata(hObject);
rgb1=str2num(get(handles.rgb1,'String'));
rgb2=str2num(get(handles.rgb2,'String'));
rgb3=str2num(get(handles.rgb3,'String'));
rgb4=str2num(get(handles.rgb4,'String'));
rgb5=str2num(get(handles.rgb5,'String'));
rgb6=str2num(get(handles.rgb6,'String'));
if length(rgb1)~=3||length(rgb2)~=3||length(rgb3)~=3||length(rgb4)~=3||length(rgb5)~=3||length(rgb6)~=3
    msgbox('请设置正确的颜色RGB数据格式!!!');
    return
end

%%

if handles.plot_AverIndex <=6
    if ~isempty(handles.plot_average.plot_sems)
        figure('NumberTitle', 'off', 'Name', 'Data combine show sem Preview ');
        for i=1:handles.plot_AverIndex
            eval(['color=rgb' num2str(i) '/255;']);
%             data=handles.plot_average.plot_Data(i,:);
            eval(['data=handles.plot_average.plot_Data' num2str(i) ';']);
            eval(['plot_times=handles.plot_average.plot_times' num2str(i) ';']);
            
            
            if ~isempty(handles.plot_average.plot_sems)
                if isfield(handles.plot_average.plot_sems,['data' num2str(i)])
                    eval(['sem=handles.plot_average.plot_sems.data' num2str(i) ';']);
                    drawErrorLine(plot_times,data,sem,color,0.5);
                else
                    plot(plot_times,data,'color',color,'LineWidth',2);
                end
            else
                plot(plot_times,data,'color',color,'LineWidth',2);
            end
            hold on;
        end
        hold off;
        xlabel('Time (s)');
        ylabel('DeltaF/F(%)');
    end
    figure('NumberTitle', 'off', 'Name', 'Data combine show nosem Preview ');
    for i=1:handles.plot_AverIndex
        eval(['color=rgb' num2str(i) '/255;']);
        eval(['data=handles.plot_average.plot_Data' num2str(i) ';']);
        eval(['plot_times=handles.plot_average.plot_times' num2str(i) ';']);
        plot(plot_times,data,'color',color,'LineWidth',2);
        hold on;
    end
    hold off;
    legend(handles.plot_average_name);
    xlabel('Time (s)');
    ylabel('DeltaF/F(%)');
elseif handles.plot_AverIndex >6
    if ~isempty(handles.plot_average.plot_sems)
        figure('NumberTitle', 'off', 'Name', 'Data combine show sem Preview ');
        for i=1:handles.plot_AverIndex
            num=mod(i,6);
            if num==0
                num=6;
            end
            eval(['color=rgb' num2str(num) '/255;']);
            %                 data=handles.plot_average.plot_Data(i,:);
            eval(['data=handles.plot_average.plot_Data' num2str(i) ';']);
            eval(['plot_times=handles.plot_average.plot_times' num2str(i) ';']);
            if isfield(handles.plot_average.plot_sems,['data' num2str(i)])
                eval(['sem=handles.plot_average.plot_sems.data' num2str(i) ';']);
                drawErrorLine(plot_times,data,sem,color,0.5);
            else
                plot(plot_times,data,'color',color,'LineWidth',2);
            end
            hold on;
        end
        hold off;
        xlabel('Time (s)');
        ylabel('DeltaF/F(%)');
    end
    figure('NumberTitle', 'off', 'Name', 'Data combine show nosem Preview ');
    for i=1:handles.plot_AverIndex
        num=mod(i,6);
        if num==0
            num=6;
        end
        eval(['color=rgb' num2str(num) '/255;']);
        %             data=handles.plot_average.plot_Data(i,:);
        eval(['data=handles.plot_average.plot_Data' num2str(i) ';']);
        eval(['plot_times=handles.plot_average.plot_times' num2str(i) ';']);
        plot(plot_times,data,'color',color,'LineWidth',2);
        hold on;
    end
    hold off;
    xlabel('Time (s)');
    ylabel('DeltaF/F(%)');
    legend(handles.plot_average_name);
end



% --- Executes on button press in Average_Combine.
function Average_Combine_Callback(hObject, eventdata, handles)
% hObject    handle to Average_Combine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles=guidata(hObject);
if ~isfield(handles,'load_trails_mode')
    
    return
end
rgb1=str2num(get(handles.rgb1,'String'));
rgb2=str2num(get(handles.rgb2,'String'));
rgb3=str2num(get(handles.rgb3,'String'));
rgb4=str2num(get(handles.rgb4,'String'));
rgb5=str2num(get(handles.rgb5,'String'));
rgb6=str2num(get(handles.rgb6,'String'));
%%
if length(rgb1)~=3||length(rgb2)~=3||length(rgb3)~=3||length(rgb4)~=3||length(rgb5)~=3||length(rgb6)~=3
    msgbox('请设置正确的RGB格式数据，用空格隔开每个颜色分量 !!!');
    return
end
%%

    
if handles.file_N<=6
    
    figure('NumberTitle', 'off', 'Name', 'Data combine show sem Preview ');
    
    for i=1:handles.file_N
        eval(['color=rgb' num2str(i) '/255;']);
        eval(['data=handles.load_trails.psth1_mean' num2str(i) ';']);
        eval(['sem=handles.load_trails.psth1_sem' num2str(i) ';']);
        eval(['data_times=handles.load_trails.times' num2str(i) ';']);
        %         data=handles.load_trails_data.psth_ALL(i,:);
        %         sem=handles.load_trails_data.psth_sem_all(i,:);
        drawErrorLine(data_times,data,sem,color,0.5);
        hold on;
    end
%     legend_str=cell(1,handles.file_N);
    
    
    xlabel('Time (s)');
    set(gca,'Tickdir','out');
    ylabel('DeltaF/F(%)');
    hold off;
    figure('NumberTitle', 'off', 'Name', 'Data combine non sem Preview ');
    for i=1:handles.file_N
        eval(['color=rgb' num2str(i) '/255;']);
        %         data=handles.load_trails_data.psth_ALL(i,:);
        %         data_times=handles.load_trails_data.psth_times;
        eval(['data=handles.load_trails.psth1_mean' num2str(i) ';']);
        %             eval(['sem=handles.load_trails.psth1_sem' num2str(i) ';']);
        eval(['data_times=handles.load_trails.times' num2str(i) ';']);
        %         drawErrorLine(psth_times,data,sem,color,0.5);
        plot(data_times,data,'color',color,'LineWidth',2);
        hold on;
    end
    legend(handles.load_trails_name);
    xlabel('Time (s)');
    set(gca,'Tickdir','out');
    ylabel('DeltaF/F(%)');
    hold off;
    %%
elseif handles.file_N>6
    %%
    figure('NumberTitle', 'off', 'Name', 'Data combine show sem Preview ');
    for i=1:handles.file_N
        num=mod(i,6);
        if num==0
            num=6;
        end
        eval(['color=rgb' num2str(num) '/255;']);
        %             data=handles.load_trails_data.psth_ALL(i,:);
        %             sem=handles.load_trails_data.psth_sem_all(i,:);
        eval(['data=handles.load_trails.psth1_mean' num2str(i) ';']);
        eval(['sem=handles.load_trails.psth1_sem' num2str(i) ';']);
        eval(['data_times=handles.load_trails.times' num2str(i) ';']);
        drawErrorLine(data_times,data,sem,color,0.5);
        hold on;
    end
    xlabel('Time (s)');
    set(gca,'Tickdir','out');
    ylabel('DeltaF/F(%)');
    hold off;
    
    figure('NumberTitle', 'off', 'Name', 'Data combine non sem Preview ');
    for i=1:handles.file_N
        num=mod(i,6);
        if num==0
            num=6;
        end
        eval(['color=rgb' num2str(num) '/255;']);
        %             data=handles.load_trails_data.psth_ALL(i,:);
        eval(['data=handles.load_trails.psth1_mean' num2str(i) ';']);
        %             eval(['sem=handles.load_trails.psth1_sem' num2str(i) ';']);
        eval(['data_times=handles.load_trails.times' num2str(i) ';']);
        plot(data_times,data,'color',color,'LineWidth',2);
        hold on;
    end
    legend(handles.load_trails_name);
    xlabel('Time (s)');
    set(gca,'Tickdir','out');
    ylabel('DeltaF/F(%)');
    hold off;
    %%
end

   
