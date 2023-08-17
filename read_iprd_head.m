function [Header,Data]=read_iprd_head(file)

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

