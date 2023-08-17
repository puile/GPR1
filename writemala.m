function writemala(data,header,filename)
% WRITEMALA writes GPR data to a file in Mala format
% If the filename is not provided, a files save dialog box will appear
%
% input:
%    data     : raw data matrix [samples,traces]
%    header   : header structure
%    filename : optional filename to write to (with or without extension)
%
% V1.0
% Written by W.P.J. van der Meer, (c) July 2004
% vdmeer@geosearch.co.jp

%open file dialog in case filename is not given
if nargin < 3
    [fn,pn] = uiputfile({'*.rd3','Mala data format (*.rd3)';'*.*','All Files (*.*)'},'Save Data File');
    if fn == 0 %cancel button pressed
        return;
    end
    filename = fullfile(pn,fn);
end
[pn,fn,ext] = fileparts(filename);
data_file=fullfile(pn,[fn '.rd3']);
header_file = fullfile(pn,[fn '.rad']);

%write the header file
[fid, message] = fopen(header_file,'wt');
if fid==-1
    error(['writemala: Can''t open "' header_file '": ' message]);
    return;
end;
fld_names = fieldnames(header);
for n = 1:length(fld_names)
    val = header.(fld_names{n});
    if isnumeric(val)
        val = num2str(val);
    end
    fprintf(fid,'%s:%s\n',upper(strrep(fld_names{n},'_',' ')),val);
end
fclose(fid);

%write the data file
[fid,message]=fopen(data_file,'wb');
if fid==-1;
    error(['writemala: can''t open "' data_file '": ' message ]);
    return;
end
fwrite(fid,data,'int16');
fclose(fid);

