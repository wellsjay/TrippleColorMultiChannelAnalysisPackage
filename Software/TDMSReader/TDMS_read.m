function Data= TDMS_read(filename)

%TDMS_READ Summary of this function goes here
%   Detailed explanation goes here
if ~exist(filename,'file')
    error('The file specified for tdms reading doesn''t exist, FILENAME: %s',filename);
end
rawdata=TDMS_readTDMSFile(filename);
ChannelName=rawdata.chanNames;
Data=rawdata.data;
Data{2,1}=[];
for i=1:length(ChannelName{1,1})
    Data{2,i+2}=ChannelName{1,1}{1,i};
end
disp('Data read completed !!!!');
return
end

