clear all
clc

phone_number = input('Lütfen telefon numarasını giriniz: ', 's');
fs = 8000;
duration = 0.1;
t = 0:1/fs:duration-1/fs;
signal = [];

for i = 1:length(phone_number)

    digit = phone_number(i);
    switch digit
        case '0'
            f1 = 941;
            f2 = 1336;
        case '1'
            f1 = 697;
            f2 = 1209;
        case '2'
            f1 = 697;
            f2 = 1336;
        case '3'
            f1 = 697;
            f2 = 1477;
        case '4'
            f1 = 770;
            f2 = 1209;
        case '5'
            f1 = 770;
            f2 = 1336;
        case '6'
            f1 = 770;
            f2 = 1477;
        case '7'
            f1 = 852;
            f2 = 1209;
        case '8'
            f1 = 852;
            f2 = 1336;
        case '9'
            f1 = 852;
            f2 = 1477;
        case '*'
            f1 = 941;
            f2 = 1209;
        case '#'
            f1 = 941;
            f2 = 1336;
    end
    
    % Sinyal üretimi
    digit_signal = sin(2*pi*f1*t) + sin(2*pi*f2*t);
    
    % Sinyalleri birleştirme
      signal = [signal, digit_signal, zeros(1, fs*0.1)];
    
end

% Ses dosyası olarak kaydetme
audiowrite('dtmf_signal.wav', signal, fs);

%Reading the wav file and storing it in a variable
[tel,fs] = audioread('dtmf_signal.wav');
[tel2,fs] = audioread('ornek.wav');
%Reads the character count of the code inputted by the user
n = 11;

%Determines the interval which the signal will be processed
d = floor(length(tel)/n);

%Creating a 2d array that will store the characters
numpad = ['1','2','3' ; '4','5','6' ; '7','8','9' ; '*','0','#'];

figure('name','Inputted Sound')

subplot(2,1,1)
plot(tel)
title('Plot Graph')

subplot(2,1,2)
stem(tel)
title('Stem Graph')

figure('name','Frequency Spectrum')

for soundnum = 1 : n
    %Applying fourier transformation to the desired section of the main
    %signal and storing the output
    teltmp = tel((soundnum-1)*d+1:soundnum*d);
    ftel = abs(fft(teltmp,fs));
    
    %Finding the peaks of the frequencies
    max = 0;
    for i=650:950
        if ftel(i) > max
            max = ftel(i);
            freq1 = i;
        end
    end
    max = 0;
    for i=1200:1500
        if ftel(i) > max
            max = ftel(i);
            freq2 = i;
        end
    end

    %Decrypting the character from the frequencies and storing it in an
    %array
    if freq1 < 720
        i=1;
    elseif freq1 < 800
        i=2;
    elseif freq1 < 900
        i=3;
    else
        i=4;
    end
    
    if freq2 < 1285
        j=1;
    elseif freq2 < 1400
        j=2;
    else 
        j=3;
    end
    
    code(soundnum) = numpad(i,j);
    
    subplot(n,1,soundnum);
    plot(ftel(1:1700));
    title(code(soundnum));
    
end
disp('benim telefon numaram>>>')
disp(code)
%%%%%%%%%%%%%%%%

d = floor(length(tel2)/n);

%Creating a 2d array that will store the characters
numpad = ['1','2','3' ; '4','5','6' ; '7','8','9' ; '*','0','#'];

figure('name','Inputted Sound')

subplot(2,1,1)
plot(tel2)
title('Plot Graph For Example')

subplot(2,1,2)
stem(tel2)
title('Stem Graph For Example')

figure('name','Frequency Spectrum')

for soundnum = 1 : n
    %Applying fourier transformation to the desired section of the main
    %signal and storing the output
    teltmp = tel2((soundnum-1)*d+1:soundnum*d);
    ftel = abs(fft(teltmp,fs));
    
    %Finding the peaks of the frequencies
    max = 0;
    for i=650:950
        if ftel(i) > max
            max = ftel(i);
            freq1 = i;
        end
    end
    max = 0;
    for i=1200:1500
        if ftel(i) > max
            max = ftel(i);
            freq2 = i;
        end
    end

    %Decrypting the character from the frequencies and storing it in an
    %array
    if freq1 < 720
        i=1;
    elseif freq1 < 800
        i=2;
    elseif freq1 < 900
        i=3;
    else
        i=4;
    end
    
    if freq2 < 1285
        j=1;
    elseif freq2 < 1400
        j=2;
    else 
        j=3;
    end
    
    code(soundnum) = numpad(i,j);
    
    subplot(n,1,soundnum);
    plot(ftel(1:1700));
    title(code(soundnum));
    
end
disp('ornek numara>>>')
disp(code)