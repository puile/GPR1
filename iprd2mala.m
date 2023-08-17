
function iprd2mala(file)
% 此程序为读取impulse_radar文件读取结果到DATA里面
HeaderFile=[file '.iprh'];
DataFile=[file '.iprb'];

fid=fopen(HeaderFile);
if fid == -1
    error('Can not open file');
end
count=0;
while 1
    linein=fgetl(fid);
    if linein==-1
        break
    else
        count=count+1;
        Head{count}=linein;
    end
end
Header=[];
for k=1:count
    SeparatorLocation=findstr(Head{k},':');
    tempfield=strrep(Head{k}(1:SeparatorLocation-1),' ','_');
    tempfield=genvarname(tempfield);
    tempvalue=str2num(Head{k}(SeparatorLocation+1:end));
    Header=setfield(Header,tempfield,tempvalue);
end
fid1=fopen(DataFile);
if fid1 == -1
    error('Can not open file');
end
Data=fread(fid1,[Header.SAMPLES inf],'int16');
fclose(fid);
fclose(fid1);  
% 定义元数据参数
samples = Header.SAMPLES;
frequency = Header.FREQUENCY;
frequency_steps = 1;
signal_position = Header.SIGNAL_POSITION;
raw_signal_position = Header.SIGNAL_POSITION;
distance_flag = 1;
time_flag = 0;
program_flag = 0;
external_flag = 0;
time_interval = 0;
distance_interval = Header.DISTANCE_INTERVAL;
operator = '';
customer = '';
site = '';
antennas = 0;
antenna_orientation = '';
antenna_separation = 0.0000;
comment = '';
timewindow = Header.TIMEWINDOW;
stacks = 1;
stack_exponent = 1;
stacking_time = 0;
last_trace = Header.LAST_TRACE;
stop_position = Header.STOP_POSITION;
system_calibration = 0;
start_position = Header.START_TIME;

% 打开文件以进行写操作
fid = fopen([file '.RAD'], 'w');

% 写入元数据
fprintf(fid, 'SAMPLES:%d\n', samples);
fprintf(fid, 'FREQUENCY:%f\n', frequency);
fprintf(fid, 'FREQUENCY STEPS:%d\n', frequency_steps);
fprintf(fid, 'SIGNAL POSITION:%d\n', signal_position);
fprintf(fid, 'RAW SIGNAL POSITION:%d\n', raw_signal_position);
fprintf(fid, 'DISTANCE FLAG:%d\n', distance_flag);
fprintf(fid, 'TIME FLAG:%d\n', time_flag);
fprintf(fid, 'PROGRAM FLAG:%d\n', program_flag);
fprintf(fid, 'EXTERNAL FLAG:%d\n', external_flag);
fprintf(fid, 'TIME INTERVAL:%f\n', time_interval);
fprintf(fid, 'DISTANCE INTERVAL:%f\n', distance_interval);
fprintf(fid, 'OPERATOR:%s\n', operator);
fprintf(fid, 'CUSTOMER:%s\n', customer);
fprintf(fid, 'SITE:%s\n', site);
fprintf(fid, 'ANTENNAS:%d\n', antennas);
fprintf(fid, 'ANTENNA ORIENTATION:%s\n', antenna_orientation);
fprintf(fid, 'ANTENNA SEPARATION:%f\n', antenna_separation);
fprintf(fid, 'COMMENT:%s\n', comment);
fprintf(fid, 'TIMEWINDOW:%f\n', timewindow);
fprintf(fid, 'STACKS:%d\n', stacks);
fprintf(fid, 'STACK EXPONENT:%d\n', stack_exponent);
fprintf(fid, 'STACKING TIME:%d\n', stacking_time);
fprintf(fid, 'LAST TRACE:%d\n', last_trace);
fprintf(fid, 'STOP POSITION:%f\n', stop_position);
fprintf(fid, 'SYSTEM CALIBRATION:%d\n', system_calibration);
fprintf(fid, 'START POSITION:%f\n', start_position);

% 关闭文件
fclose(fid);
fid1 = fopen([file '.RD3'], 'w');
fwrite(fid1,Data,'int16');
fclose(fid1);