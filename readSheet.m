function [l w d t names]=readSheet()
% read from google sheet, adjust for each individual sheet setup
% For reference: https://docs.google.com/spreadsheets/d/1v_54WAXZj2wyBye62ZFX1V3sIqkmemBQhNdAfD6Ojj4/edit?usp=sharing
DOCID='1v_54WAXZj2wyBye62ZFX1V3sIqkmemBQhNdAfD6Ojj4'; % google sheet key
sheet=GetGoogleSpreadsheet(DOCID);
numStart = 2; % Change row start index accordingly
names = sheet(numStart:end, 1); % Change column index accordingly
l = str2double(sheet(numStart:end, 3)); % Change column index accordingly
w = str2double(sheet(numStart:end, 4));
d = str2double(sheet(numStart:end, 5));
t = str2double(sheet(numStart:end, 6));
end