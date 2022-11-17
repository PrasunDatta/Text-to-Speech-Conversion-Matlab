%% TEXT TO SPEECH %%
%==================%
clc 
clear all;
close all;          %Clearing the command window and workspace

%%image processing part

i=imread('pro.png');   %Here you have to put which photo you want to read(MAIN INPUT)
figure
imshow(i)
title('Input Image/Original Unprocessed Image');
gray=rgb2gray(i);
figure
imshow(gray);
title('The Grayscale Image');
th=graythresh(i);

bw=~im2bw(i,th);        %Binary Image
figure
imshow(bw);  %See this image and make sure that image has been processed correctly,if it not happens correctly then you will get garbage output    
title('The Binary Image');


ocrResults=ocr(bw) %Using Optical Character Recognition for recognizing the text 
%Recognize Text Within an image.
recognizedText = ocrResults.Text;    
figure;
imshow(i);
title('Recognized Text Part of The Image');
text(200, 100, recognizedText, 'BackgroundColor', [1 1 1]);

%Display Bounding Boxes Of Words & Recognition Confidences
 Iocr         = insertObjectAnnotation(i, 'rectangle', ...
                           ocrResults.WordBoundingBoxes, ...
                           ocrResults.WordConfidences);
figure;title('Bounding Boxes Of Words & Recognbition Confidences'); 
imshow(Iocr);

for n=1:numel(ocrResults.Words)     %iterate speech part for all text in the photo
    
word = ocrResults.Words{n};         %We are taking each word in a variable and express it one after one

%%Speech processing part

NET.addAssembly('System.Speech')
mysp=System.Speech.Synthesis.SpeechSynthesizer;    %We are using Matlab's in built voice synthesizer for speech
mysp.Volume=100;                        %Volume of voice(Range : 1-100)
mysp.Rate=5;                             %Speed of voice (Range : -10 to 10 )
 a = audiorecorder(96000,16,1);   % create object for recording audio
record(a,5);

Speak(mysp,word);                      %Expressing each word

b = getaudiodata(a);                   %store the recorded data in a numeric array.
b = double(b);
figure
plot(b);
title('plot of the sound wave');
end
