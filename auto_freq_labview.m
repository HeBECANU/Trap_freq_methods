shots_per_point = 6;

marker = floor((i-1)/shots_per_point)+1; %Counts from 1 to num shots before setpt update


% file = 'C:\Remote\settings202021Jul105753.xml';
file = 'c:\remote\settings202116Mar150002.xml';%'c:\remote\settings202111Mar100454.xml';

%% read in the xml settings file
new_path = 'c:\remote\settings202111Mar100520.xml';%file;
file_id = fopen(file,'r');
j=1;
line = fgetl(file_id);
A{j} = line;
while ischar(line)
    j = j+1;
    line = fgetl(file_id);
    A{j} = line;
end
fclose(file_id);

% delete(file);   % DEBUG - delete xml file
%% make adjustments

freq = [100:5:140];
low_time = (1/freq(marker))-1e-3;
low_time_str = num2str(low_time,6);


multi_pulse_1_low_timie = {{{'<Cluster>',1},{'<Cluster>',7},'Low Time Dev2',low_time_str}};

paths = {
    multi_pulse_1_low_timie{:}
    };  


A = xml_edit(A,paths,i);

%% write out new file
file_id = fopen(new_path,'w');
for j = 1:numel(A)
    if A{j+1} == -1
        fprintf(file_id,'%s', A{j});
        break
    else
        fprintf(file_id,'%s\n', A{j});
    end
end
fclose(file_id);

%%clean up
clear('A')
%%
path_log = 'Y:\TDC_user\ProgramFiles\my_read_tdc_gui_v1.0.1\dld_output\log_freq.txt';
f_log=fopen(path_log,'a');  % append to log-file
fprintf(f_log,[num2str(i),datestr(datetime,'yyyymmdd_HHMMSS'),low_time_str,num2str(freq)]);
fclose(f_log);