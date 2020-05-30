# Lossy Line Tool

A tool to calculate lossy transmission lines.

*Note that MATLAB R2020 is required for full functionality*

## Before Running

Edit readSheet.m query the relevant google sheet. This will be done by changing the DOCID value in this line

```
DOCID='1v_54WAXZj2wyBye62ZFX1V3sIqkmemBQhNdAfD6Ojj4'; % google sheet key
```

Note that the DOCID key can be found in the url, here is the test google sheet used to set the current key

```
https://docs.google.com/spreadsheets/d/1v_54WAXZj2wyBye62ZFX1V3sIqkmemBQhNdAfD6Ojj4/edit?usp=sharing
```

The script will read each relevant column from the google sheet into a vector in matlab. Which columns and where to start reading can be changed in readSheet.m

```
numStart = 2; % Change row start index accordingly
names = sheet(numStart:end, 1); % Change column index accordingly
l = str2double(sheet(numStart:end, 3)); % Change column index accordingly
w = str2double(sheet(numStart:end, 4));
d = str2double(sheet(numStart:end, 5));
t = str2double(sheet(numStart:end, 6));
f = str2double(sheet(numStart:end, 7));
```

Note that numStart denotes which row to start reading from each column. Names, l, w, d, t, and f, are columns with the indexes 1, 3, 4, 5, and 6, respectively. To change where to start reading and which columns, simply change the values. The variable 'sheet' is a matrix of all entries in the google sheet, it can be truncated in whichever fashion is neccessary.
