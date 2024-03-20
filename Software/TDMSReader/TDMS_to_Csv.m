[filename, path] = uigetfile({'*'}, 'MultiSelect','on','���ȡtdms�ļ�');
if ischar(filename)
    file_num=1;
    full_file_path=fullfile(path,filename);
    [~,~,file_part]=fileparts(full_file_path);
    if strcmp(file_part,'.tdms')
        reading = TDMS_readTDMSFile(full_file_path);
        data=cat(1,reading.data{3:end})';
        csvname=strrep(full_file_path,'.tdms','.csv');
        csvwrite(csvname,data);
    end
    disp(['�ļ�ת����ɣ���']);
else
    filenum=size(filename,2);
    for i=1:filenum
        full_file_path=[path,filename{i}];
        [~,~,file_part]=fileparts(full_file_path);
        if strcmp(file_part,'.tdms')
            reading = TDMS_readTDMSFile(full_file_path);
            data=cat(1,reading.data{3:end})';
            csvname=strrep(full_file_path,'.tdms','.csv');
            csvwrite(csvname,data);
            
        end
        disp(['�ļ�' num2str(i) 'ת����ɣ���']);
    end
end