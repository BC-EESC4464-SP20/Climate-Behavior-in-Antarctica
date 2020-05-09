function[baseline_mean,baseline_std,anomaly,slopeint,annual_temp_mean,annual_temp_std]=temperature(station_number)
monthly_temp_whole_range= NaN(12,30)
annual_temp_mean= NaN(30, 1)
annual_temp_std= NaN(30, 1)
%monthlymean

for ii = 1973:2002
        filename = [num2str(890550) '_' num2str(ii) '.dat'];
        
        %Read the lat,lon, and elevation by 'importdata'.
A = importdata(filename,'\t');

% air temperature: dbt, Variable 17; month variable 2; date variable 3
opts = detectImportOptions(filename)
opts.SelectedVariableNames = {'Var2','Var17'}
T=readtable(filename,opts)
summary(T)

B=table2array(T);
B(B==9999)=NaN; 


%%
i1=1;
if ismember(i1,B(:,1))==1
H1=find(B(:,1)==i1);
x1=1:length(H1);
Jan_temp=nanmean(B(H1,:));
else
    Jan_temp=[1,NaN]
end 


i2=2;
if ismember(i1,B(:,1))==1
H2=find(B(:,1)==i2);
x2=1:length(H2);
Feb_temp=nanmean(B(H2,:));
else
    Feb_temp=[2,NaN]
end 


i3=3;
if ismember(i1,B(:,1))==1
H3=find(B(:,1)==i3);
x3=1:length(H3);
Mar_temp=nanmean(B(H3,:));
else
    Mar_temp=[3,NaN]
end 


i4=4;
if ismember(i1,B(:,1))==1
H4=find(B(:,1)==i4);
x4=1:length(H4);
Apr_temp=nanmean(B(H4,:));
else
    Apr_temp=[4,NaN]
end 


i5=5;
if ismember(i1,B(:,1))==1
H5=find(B(:,1)==i5);
x5=1:length(H5);
May_temp=nanmean(B(H5,:));
else
    May_temp=[5,NaN]
end 


i6=6;
if ismember(i1,B(:,1))==1
H6=find(B(:,1)==i6);
x6=1:length(H6);
Jun_temp=nanmean(B(H6,:));
else
    Jun_temp=[6,NaN]
end 



i7=7;
if ismember(i1,B(:,1))==1
H7=find(B(:,1)==i7);
x7=1:length(H7);
Jul_temp=nanmean(B(H7,:));
else
    Jul_temp=[7,NaN]
end 



i8=8;
if ismember(i1,B(:,1))==1
H8=find(B(:,1)==i8);
x8=1:length(H8);
Aug_temp=nanmean(B(H8,:));
else
    Aug_temp=[8,NaN]
end 



i9=9;
if ismember(i1,B(:,1))==1
H9=find(B(:,1)==i9);
x9=1:length(H9);
Sep_temp=nanmean(B(H9,:));
else
    Sep_temp=[9,NaN]
end 



i10=10;
if ismember(i1,B(:,1))==1
H10=find(B(:,1)==i10);
x10=1:length(H10);
Oct_temp=nanmean(B(H10,:));
else
    Oct_temp=[10,NaN]
end 


i11=11;
if ismember(i1,B(:,1))==1
H11=find(B(:,1)==i11);
x11=1:length(H11);
Nov_temp=nanmean(B(H11,:));
else
    Nov_temp=[11,NaN]
end 


i12=12;
if ismember(i1,B(:,1))==1
    H12=find(B(:,1)==i12);
   x12=1:length(H12);
    Dec_temp=nanmean(B(H12,:));
else
    Dec_temp=[12,NaN]
end

%%
month=[1;2;3;4;5;6;7;8;9;10;11;12];
temp=vertcat(Jan_temp,Feb_temp,Mar_temp,Apr_temp,May_temp,Jun_temp,Jul_temp,Aug_temp,Sep_temp,Oct_temp,Nov_temp,Dec_temp);
%plot(month,temp(:,2))

%yearlymean=nanmean(Jan_temp(:,1),Feb_temp(:,1),Mar_temp(:,1),Apr_temp(:,1),May_temp(:,1),Jun_temp(:,1),Jul_temp(:,1),Aug_temp(:,1),Sep_temp(:,1),Oct_temp(:,1),Nov_temp(:,1),Dec_temp(:,1))
%% annual mean by averaging monthly mean
yearlymean=nanmean(temp(:,2))
yearlystd=nanstd(temp(:,2))

k=ii-1972
annual_temp_mean(k,1)=yearlymean
annual_temp_std(k,1)=yearlystd
end
 
%%
year=[1973:2002]'

%% define baseline temperature
% The anomaly is the difference from the mean over some baseline period. In
% this case, we will pick the baseline period as the first time year 1973-1983 for consistency
% across each station (though note that this is a choice we are making, and
% that different temperature analyses often pick different baselines!)
%Calculate the annual mean temperature over the period from 1973-1983
  %Use the find function to find rows contain data where stationdata.Year is between 1981 and 2000

baseline_mean=mean(annual_temp_mean(1:10))
baseline_std=std(annual_temp_mean(1:10))

%Calculate the annual mean temperature anomaly as the annual mean
%temperature for each year minus the baseline mean temperature
anomaly=annual_temp_mean-baseline_mean


%% station 890500, The mean annual temperature of the interior is ?57 °C (?70.6 °F).
%The coast is warmer; on the coast Antarctic average temperatures are around ?10 °C (14.0 °F) 
%(in the warmest parts of Antarctica) and in the elevated inland they average about ?55 °C (?67.0 °F) 
%in Vostok

% use -30 here
f=[1:30]'
slopeint=polyfit(f,anomaly,1)
end




