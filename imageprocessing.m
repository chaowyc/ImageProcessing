function varargout = imageprocessing(varargin)
% IMAGEPROCESSING MATLAB code for imageprocessing.fig
%      IMAGEPROCESSING, by itself, creates a new IMAGEPROCESSING or raises the existing
%      singleton*.
%
%      H = IMAGEPROCESSING returns the handle to a new IMAGEPROCESSING or the handle to
%      the existing singleton*.
%
%      IMAGEPROCESSING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGEPROCESSING.M with the given input arguments.
%
%      IMAGEPROCESSING('Property','Value',...) creates a new IMAGEPROCESSING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before imageprocessing_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to imageprocessing_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help imageprocessing

% Last Modified by GUIDE v2.5 14-Mar-2016 13:17:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @imageprocessing_OpeningFcn, ...
                   'gui_OutputFcn',  @imageprocessing_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before imageprocessing is made visible.
function imageprocessing_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to imageprocessing (see VARARGIN)

% Choose default command line output for imageprocessing
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes imageprocessing wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = imageprocessing_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider




% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename,pathname]=...
    uigetfile({'*.*';'*.bmp';'*.jpg';'*.png'},'select picture');  %选择图片路径
str=[pathname filename];  %合成路径+文件名
imin=imread(str);   %读取图片
imin = rgb2gray(imin);
imin = im2uint8(imin);
axes(handles.axes2);  
imshow(imin);  %显示图片
handles.pic = imin;
guidata(hObject,handles);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% 标记拐点
x0 = 0; y0 = 0;
x1 = 100;y1 = 20;
x2 = 150;y2 = 200;
x3 = 255;y3 = 255;

%% 计算每段的斜率和偏执
a1 = (y1 - y0) / (x1 - x0);
b1 = 0;
a2 = (y2 -y1) / (x2 - x1);
b2 = y1 - a2 * x1;
a3 = (y3 - y2) / (x3 - x2);
b3 = y2 - a3 * x2;
im = handles.pic;
%% 像素值映射
im(im >= x0 & im <= x1) = a1 * im(im >= x0 & im <= x1) + b1;
im(im > x1 & im <= x2) = a2 * (im(im > x1 & im <= x2)) + b2;
im(im > x2 & im <= x3) = a3 * (im(im > x2 & im <= x3)) + b3;

axes(handles.axes3);  
imshow(im);  %显示图片
handles.pic = im;
guidata(hObject,handles);

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imout = handles.pic;
[filename,pathname,filterindex]=...
    uiputfile({'*.bmp';'*.jpg';'*.png'},'save picture');
if filterindex==0
    return  %如果取消操作，返回
else
    str=[pathname filename];  %合成路径+文件名
    axes(handles.axes3);  %使用第二个axes
    imwrite(imout,str);  %写入图片信息，即保存图片
end



function slider_editText_Callback(hObject, eventdata, handles)
% hObject    handle to slider_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of slider_editText as text
%        str2double(get(hObject,'String')) returns contents of slider_editText as a double
sliderValue = get(handles.slider_editText,'String');
sliderValue = str2double(sliderValue);
if(isempty(sliderValue)||sliderValue<0||sliderValue>360)
    set(handles.slider_editText,'String','0');
else
    im = rol(sliderValue);
    axes(handles.axes2);  
    imshow(im);  %显示图片
end
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function slider_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
