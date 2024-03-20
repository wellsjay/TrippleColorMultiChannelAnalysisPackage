clc
if get(handles.EditInputMark,'Value')==1
    if isfield(passdata,'cal') && isfield(passdata,'cue')
        
        if ~isempty(passdata.cal) && ~isempty(passdata.cue)
            t=passdata.interval_cal*(1:1:size(passdata.cal,1));
            color=['r','g','b','c','m','y','k'];
            axes(handles.DataPreView_axes);
            xlims=get(handles.DataPreView_axes,'Xlim');
            ylims=get(handles.DataPreView_axes,'Ylim');
            cal_index=get(handles.cal_pm,'Value');
            smoothval=round(get(handles.smooth_sli,'Value'));
            exam=smooth(passdata.cal(:,cal_index+1),smoothval);
%             exam=passdata.cal(:,cal_index+1);
            passdata.calfig=plot(t,exam,color(1));
            hold on
            
            cue_index=get(handles.cue_channel,'Value');
            
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
            
            zoomindex=get(handles.Zoom_On_radio,'Value');
            if zoomindex==1
                hA = gca;
                zoom(hA, 'reset');
                zoom xon;
            elseif zoomindex==0
                hA = gca;
                zoom(hA, 'reset');
                zoom off;
                set(gcf,'WindowButtonMotionFcn',{@ButtonMotionFcn,handles},'WindowButtonDownFcn',@ButttonDownFcn,'WindowButtonUpFcn',{@ButttonUpFcn,handles});
            end
            
            if xlims(1)==0&&xlims(2)==1&&ylims(1)==0&&ylims(2)==1
            else
                
%                 axis([xlims(1) xlims(2) min(exam) max(exam)]);
                set(handles.DataPreView_axes,'Xlim',xlims);
%                 set(handles.DataPreView_axes,'Ylim',ylims);
            end
            
            
%             set(gcf,'WindowButtonMotionFcn',@ButtonMotionFcn,'WindowButtonDownFcn',@ButttonDownFcn,'WindowButtonUpFcn',@ButttonUpFcn);
            passdata.doubleclick=0;
            passdata.singalclick=0;
            passdata.mouseSign=0;
            
            passdata.maxwave=max(exam);
            passdata.minwave=min(exam);
            passdata.currentmode=1;
            passdata.mode1_channel=cue_index;
        end
    end
    if isfield(passdata,'cal') && ~isfield(passdata,'cue')
        if ~isempty(passdata.cal)
            t=passdata.interval_cal*(1:1:size(passdata.cal,1));
            color=['r','g','b','c','m','y','k'];
            axes(handles.DataPreView_axes);
            cal_index=get(handles.cal_pm,'Value');
            xlims=get(handles.DataPreView_axes,'Xlim');
            ylims=get(handles.DataPreView_axes,'Ylim');
            smoothval=round(get(handles.smooth_sli,'Value'));
            exam=smooth(passdata.cal(:,cal_index+1),smoothval);
            
            %             exam=passdata.cal(:,cal_index+1);
            passdata.calfig=plot(t,exam,color(1));
            
            hold off;
            zoomindex=get(handles.Zoom_On_radio,'Value');
            if zoomindex==1
                hA = gca;
                zoom(hA, 'reset');
                zoom xon;
            elseif zoomindex==0
                hA = gca;
                zoom(hA, 'reset');
                zoom off;
                set(gcf,'WindowButtonMotionFcn',{@ButtonMotionFcn,handles},'WindowButtonDownFcn',@ButttonDownFcn,'WindowButtonUpFcn',{@ButttonUpFcn,handles});
            end
            
            if xlims(1)==0&&xlims(2)==1&&ylims(1)==0&&ylims(2)==1
            else
                set(handles.DataPreView_axes,'Xlim',xlims);
%                 axis([xlims(1) xlims(2) min(exam) max(exam)]);
                %                 set(handles.DataPreView_axes,'Ylim',ylims);
            end
            xlabel('Time (s)');
            
%             set(gcf,'WindowButtonMotionFcn',@ButtonMotionFcn,'WindowButtonDownFcn',@ButttonDownFcn,'WindowButtonUpFcn',@ButttonUpFcn);
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
elseif get(handles.EditInputMark,'Value')==0
    if isfield(passdata,'cal')
        
        if ~isempty(passdata.cal) && ~isempty(passdata.ManualMark_upindex)
            t=passdata.interval_cal*(1:1:size(passdata.cal,1));
            color=['r','g','b','c','m','y','k'];
            %             subplot(1,1,1,'Parent',handles.DataPreView)
            axes(handles.DataPreView_axes);
            xlims=get(handles.DataPreView_axes,'Xlim');
            ylims=get(handles.DataPreView_axes,'Ylim');
            cal_index=get(handles.cal_pm,'Value');
            smoothval=round(get(handles.smooth_sli,'Value'));
            exam=smooth(passdata.cal(:,cal_index+1),smoothval);
%             exam=passdata.cal(:,cal_index+1);
            passdata.calfig=plot(t,exam,color(1));
            hold on
            

            x=[passdata.ManualMark_upindex;passdata.ManualMark_upindex];
            y=ones(size(x));
            y(1,:)=min(exam);
            y(2,:)=max(exam);
            passdata.linefig=line(x,y,'Color','b','LineWidth',1);
            
            xlabel('Time (s)');
            hold off
            zoomindex=get(handles.Zoom_On_radio,'Value');
            if zoomindex==1
                hA = gca;
                zoom(hA, 'reset');
                zoom xon;
            elseif zoomindex==0
                hA = gca;
                zoom(hA, 'reset');
                zoom off;
                set(gcf,'WindowButtonMotionFcn',{@ButtonMotionFcn,handles},'WindowButtonDownFcn',@ButttonDownFcn,'WindowButtonUpFcn',{@ButttonUpFcn,handles});
            end
            
            if xlims(1)==0&&xlims(2)==1&&ylims(1)==0&&ylims(2)==1
                
            else
%                 axis([xlims(1) xlims(2) min(exam) max(exam)]);
                set(handles.DataPreView_axes,'Xlim',xlims);
%                 set(handles.DataPreView_axes,'Ylim',ylims);
            end
            
            
%             set(gcf,'WindowButtonMotionFcn',@ButtonMotionFcn,'WindowButtonDownFcn',@ButttonDownFcn,'WindowButtonUpFcn',@ButttonUpFcn);
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
    if isfield(passdata,'cal') && isempty(passdata.ManualMark_upindex)
        if ~isempty(passdata.cal)
            t=passdata.interval_cal*(1:1:size(passdata.cal,1));
            color=['r','g','b','c','m','y','k'];
            %             subplot(1,1,1,'Parent',handles.DataPreView)
            xlims=get(handles.DataPreView_axes,'Xlim');
            ylims=get(handles.DataPreView_axes,'Ylim');
            axes(handles.DataPreView_axes);
            cal_index=get(handles.cal_pm,'Value');
            smoothval=round(get(handles.smooth_sli,'Value'));
            exam=smooth(passdata.cal(:,cal_index+1),smoothval);
%             exam=passdata.cal(:,cal_index+1);
            passdata.calfig=plot(t,exam,color(1));
            
            
            hold off;
            xlabel('Time (s)');
            
            zoomindex=get(handles.Zoom_On_radio,'Value');
            if zoomindex==1
                hA = gca;
                zoom(hA, 'reset');
                zoom xon;
            elseif zoomindex==0
                hA = gca;
                zoom(hA, 'reset');
                zoom off;
                set(gcf,'WindowButtonMotionFcn',{@ButtonMotionFcn,handles},'WindowButtonDownFcn',@ButttonDownFcn,'WindowButtonUpFcn',{@ButttonUpFcn,handles});
            end
            
            if xlims(1)==0&&xlims(2)==1&&ylims(1)==0&&ylims(2)==1
            else
%                 axis([xlims(1) xlims(2) min(exam) max(exam)]);
                set(handles.DataPreView_axes,'Xlim',xlims);
%                 set(handles.DataPreView_axes,'Ylim',ylims);
            end
            
            %%   设定手动打标自动调节
%             set(gcf,'WindowButtonMotionFcn',@ButtonMotionFcn,'WindowButtonDownFcn',@ButttonDownFcn,'WindowButtonUpFcn',@ButttonUpFcn);
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