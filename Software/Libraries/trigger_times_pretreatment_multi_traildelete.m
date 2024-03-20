function trigger_times = trigger_times_pretreatment_multi_traildelete(upindex,trial_from,interval,...
    trial_number,delete,h)

trigger_times = upindex*interval;

total_trial_number_in_file = length(trigger_times);
if trial_number > total_trial_number_in_file - trial_from + 1
    trial_number = total_trial_number_in_file - trial_from + 1;
    if ~isempty(h)
        set(h,'String',num2str(trial_number));
    end
end

trigger_times = trigger_times((trial_from:(trial_from + trial_number - 1)))';

delete(delete(:)==0)=[];

delete(delete(:)>length(trigger_times))=[];

trigger_times(delete)=[];