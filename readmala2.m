function [Header,Data]=readmala2(file)
% READMALA is a function that imports GPR data collected with a MALA GPR 
% Header is a structure with fields the definition of the mala *.rad file
% Data is a matrix of [samples,traces] size which is read from the *.rd3 file
% file is a string containing the name of the scan without the extension!
% A. Giannopoulos, 2003

HeaderFile=[file '.rad'];
DataFile=[file '.rd3'];

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
    tempvalue=str2num(Head{k}(SeparatorLocation+1:end));
    Header=setfield(Header,tempfield,tempvalue);
end
fid2=fopen(DataFile);
if fid2 == -1
    error('Can not open file');
end

Data=fread(fid2,[Header.SAMPLES inf],'short');
   
fclose(fid);
fclose(fid2);

      
        


