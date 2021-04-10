install arduino
a=arduino('COM6');
LEDred1 = 0; 
LEDred2 = 0; 
LEDgreen = 0; 
a.pinMode(13, 'OUTPUT');

a.pinMode(8, 'OUTPUT');  
a.pinMode(4, 'OUTPUT');

a.digitalWrite(13, 0); 

threshold = -80;
t = 0;
figure; 
hold on;
plot(1:10:3000, threshold, '--r'); 
while t < length(EEG.data)
    blinks = 0; 
timer = 0;
t = t + 1; l
signal_val = EEG.data(1,t); 
a.digitalWrite(4, 0);
a.digitalWrite(8, 0); 

drawnow;
plot(t, signal_val);
if t == 1
axis([0 1000 -250 50]);
elseif rem(t,1000) == 0
axis([t t+1000 -250 50]);
end

if (signal_val >= threshold && EEG.data(1,t-1) < threshold)
    timer = 0; 
    blinks = blinks + 1;
    while (blinks < 3 && timer <= 100 && t <length(EEG.data))
       t = t + 1; 
       timer = timer + 1;
       signal_val = EEG.data(1,t); 
       drawnow;
       plot(t, signal_val);
       if t == 1
         axis([0 1000 -250 50]);
       elseif rem(t,1000) == 0
          axis([t t+1000 -250 50]);
       end
       if (signal_val >= threshold && EEG.data(1,t-1) < threshold)
          blinks = blinks + 1;
       end
       if (blinks == 1)
          a.digitalWrite(4, 1); % Turn LED On
       end
       if (blinks == 2)
          a.digitalWrite(8, 1); % Turn LED On
       end
       if (blinks == 3 && LEDgreen == 0)
         LEDgreen = 1; % Set LED as 'HIGH'
         a.digitalWrite(13, 1); % Turn LED On
       elseif (blinks == 3 && LEDgreen == 1)
         LEDgreen = 0; % Set LED as 'LOW'
         a.digitalWrite(13, 0); % Turn LED Off
       end
    end

end
end