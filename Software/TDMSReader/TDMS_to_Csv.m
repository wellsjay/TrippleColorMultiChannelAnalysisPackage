[filename, path] = uigetfile({'*'}, 'MultiSelect','on','请读取tdms文件');
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
    disp(['文件转换完成！！']);
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
        disp(['文件' num2str(i) '转换完成！！']);
    end
end