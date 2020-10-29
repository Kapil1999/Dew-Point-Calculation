%For MATLAB Analysis:

readChId = 12397;
writeChId = 1210619;  % replace with your channel number
writeKey = '6CCZMTPWDSH3I1C7'; % Replace with your channel write key

%Read the latest 20 points of temperature data with timestamps and humidity data from the public Weather Station channel into variables
[temp,time] = thingSpeakRead(readChId,'Fields',4,'NumPoints',20);
humidity = thingSpeakRead(readChId,'Fields',3,'NumPoints',20);

%Convert the temperature from Fahrenheit to Celsius
tempC = (5/9)*(temp-32); 
%Specify the constants for water vapor (b) and barometric pressure (c)
b = 17.62;
c = 243.5;

%Calculate the dew point in Celsius
gamma = log(humidity/100) + b*tempC./(c+tempC);
dewPoint = c*gamma./(b-gamma)

%Convert the result back to Fahrenheit
dewPointF = (dewPoint*1.8) + 32;

%Write data to your Dew Point Measurement channel. This code posts all the available data in one operation and includes the correct timestamps
thingSpeakWrite(writeChId,[temp,humidity,dewPointF],'Fields',[1,2,3],...
'TimeStamps',time,'Writekey',writeKey);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%For MATLAB Visulisation:

readChId = 1210619
readKey = 'VA1OANLSI8EWOL56';
%Read data from your channel fields, and get the last 100 points of data
[dewPointData,timeStamps] = thingSpeakRead(readChId,'fields',[1,2,3],...
    'NumPoints',100,'ReadKey',readKey);
%Plot the Data
plot(timeStamps,dewPointData);
xlabel('TimeStamps');
ylabel('Measured Values');
title('Dew Point Measurement');
legend({'Temperature','Humidity','Dew Point'});
grid on;