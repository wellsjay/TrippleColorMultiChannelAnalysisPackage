clc
ManualMark_on=get(handles.cue_channel,'Value');
if ManualMark_on>1
    if isfield(passdata,'cal') && isfield(passdata,'cue')
        if isfield(passdata,'correction_data')
            if ~isempty(passdata.correction_data)&& ~isempty(passdata.cue)
                t=passdata.interval_cal*(1:1:size(passdata.cal,1));
                color=['r','g','b','c','m','y','k'];
                axes(handles.DataPreView_axes);
                xlims=get(handles.DataPreView_axes,'Xlim');
                ylims=get(handles.DataPreView_axes,'Ylim');
                cal_index=get(handles.cal_pm,'Value');
                smoothval=round(get(handles.smooth_sli,'Value'));
                exam=passdata.cal(:,passdata.cal_correction_index+1);
                %             exam=passdata.cal(:,cal_index+1);
                passdata.calfig=plot(t,exam,color(1));
                hold on
                plot(t,passdata.correction_data,color(2));
                hold on
                cue_index=ManualMark_on-1;
                
                eval(['exam_upindex=passdata.InputMark.upindex_' num2str(cue_index) ';']);
                if ~isempty(exam_upindex)
                    %                 hold on
                    interval=passdata.interval_cal/(passdata.length_cue/size(passdata.cal,1));
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
                
                xlabel('Time (s)');
                hold off
                legend('Raw Data','Correction Data');
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
    if isfield(passdata,'cal') && ~isfield(passdata,'cue')
        if isfield(passdata,'correction_data')
            if ~isempty(passdata.correction_data)
                t=passdata.interval_cal*(1:1:size(passdata.cal,1));
                color=['r','g','b','c','m','y','k'];
                axes(handles.DataPreView_axes);
                cal_index=get(handles.cal_pm,'Value');
                xlims=get(handles.DataPreView_axes,'Xlim');
                ylims=get(handles.DataPreView_axes,'Ylim');
                smoothval=round(get(handles.smooth_sli,'Value'));
                exam=passdata.cal(:,passdata.cal_correction_index+1);
                passdata.calfig=plot(t,exam,color(1));
                hold on 
                plot(t,passdata.correction_data,color(2));
                hold off;
                legend('Raw Data','Correction Data');
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
                cue_index=get(handles.cue_channel,'Value');
                passdata.mode1_channel=cue_index;
            end
        end
    end
elseif ManualMark_on==1
    if isfield(passdata,'cal')
        if isfield(passdata,'correction_data')
            if ~isempty(passdata.correction_data) && ~isempty(passdata.ManualMark_upindex)
                t=passdata.interval_cal*(1:1:size(passdata.cal,1));
                color=['r','g','b','c','m','y','k'];
                axes(handles.DataPreView_axes);
                xlims=get(handles.DataPreView_axes,'Xlim');
                ylims=get(handles.DataPreView_axes,'Ylim');
                cal_index=get(handles.cal_pm,'Value');
                smoothval=round(get(handles.smooth_sli,'Value'));
                exam=passdata.cal(:,passdata.cal_correction_index+1);
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
                legend('Raw Data','Correction Data');
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
    if isfield(passdata,'cal') && isempty(passdata.ManualMark_upindex)
        if isfield(passdata,'correction_data')
            if ~isempty(passdata.correction_data)
                t=passdata.interval_cal*(1:1:size(passdata.cal,1));
                color=['r','g','b','c','m','y','k'];
                xlims=get(handles.DataPreView_axes,'Xlim');
                ylims=get(handles.DataPreView_axes,'Ylim');
                axes(handles.DataPreView_axes);
                cal_index=get(handles.cal_pm,'Value');
                smoothval=round(get(handles.smooth_sli,'Value'));
                exam=passdata.cal(:,passdata.cal_correction_index+1);
                passdata.calfig=plot(t,exam,color(1));
                hold on
                plot(t,passdata.correction_data,color(2))
                hold off;
                legend('Raw Data','Correction Data');
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
                
                %%   设定手动打标自动调节
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
        if ~isempty(passdata.cal)
            
        end
    end
end