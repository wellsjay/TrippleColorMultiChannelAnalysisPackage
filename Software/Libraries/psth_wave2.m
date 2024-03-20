function [psth,psth_mean, sem] = psth_wave2(trigger_times,interval,values, ...
    basal_time,odor_time,control_from,control_to,offset,z_score)
    N = length(values);
    times = 0:interval:(N-1)*interval;
    times = times';
    val1 = cell(1,length(trigger_times));
    val2 = cell(1,length(trigger_times));
    
for i=1:length(trigger_times)
       k1 = times > trigger_times(i) + control_from & times < trigger_times(i) + control_to;
       b = trigger_times(i) - basal_time;
       c = trigger_times(i) + odor_time;
%        d = times(1295:2494)
        k = times >= b & times < c;
        if sum(k) > (basal_time+odor_time)/interval
            m = find(k == 1,1,'first');
            k(m) = [];
        end
        if sum(k) < (basal_time+odor_time)/interval
            m = find(k == 1,1,'first');
            k(m-1)=1;
        end
       
       val1{1,i} = values(k1)-offset;
       val2{1,i} = values(k)-offset;
       average = mean(values(k1)-offset);
       stdev = std(values(k1)-offset);
       if z_score==1
       pre = (values(k)-offset - average)/stdev;
       else
       pre = 100*(values(k)-offset - average)/(average);
       end   
       val2{1,i} = pre;
       
end

psth = cell2mat(val2)';

sem = std(psth)/(length(trigger_times)-1)^0.5;%计算psth_sem公式，用数据的方差与数据长度做对比；
psth_mean = mean(psth,1);