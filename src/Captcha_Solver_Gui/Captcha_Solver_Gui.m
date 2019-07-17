function varargout = Captcha_Solver_Gui(varargin)
% CAPTCHA_SOLVER_GUI MATLAB code for Captcha_Solver_Gui.fig
%      CAPTCHA_SOLVER_GUI, by itself, creates a new CAPTCHA_SOLVER_GUI or raises the existing
%      singleton*.
%
%      H = CAPTCHA_SOLVER_GUI returns the handle to a new CAPTCHA_SOLVER_GUI or the handle to
%      the existing singleton*.
%
%      CAPTCHA_SOLVER_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CAPTCHA_SOLVER_GUI.M with the given input arguments.
%
%      CAPTCHA_SOLVER_GUI('Property','Value',...) creates a new CAPTCHA_SOLVER_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Captcha_Solver_Gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Captcha_Solver_Gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Captcha_Solver_Gui

% Last Modified by GUIDE v2.5 13-Apr-2018 22:59:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Captcha_Solver_Gui_OpeningFcn, ...
                   'gui_OutputFcn',  @Captcha_Solver_Gui_OutputFcn, ...
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


% --- Executes just before Captcha_Solver_Gui is made visible.
function Captcha_Solver_Gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Captcha_Solver_Gui (see VARARGIN)

% Choose default command line output for Captcha_Solver_Gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
% Set Background Image
% axes
axis=axes('unit','normalized','position',[0 0 1 1]);
% import Back Ground Image
background=imread('bj.jpg');
imagesc(background);
set(axis,'handlevisibility','off','visible','off')

% UIWAIT makes Captcha_Solver_Gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Captcha_Solver_Gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Browse_Image.
function Browse_Image_Callback(hObject, eventdata, handles)
% hObject    handle to Browse_Image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[Image_Name Path_Name]=uigetfile({'*.jpg';'*.bmp';'*.tiff';'*.png'});
Image=strcat(Path_Name,Image_Name);
axes(handles.browseImage)
imshow(Image);
handles.Image=Image;
guidata(hObject,handles);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bounding Box Image
% I=imread('c.jpeg');
I=imread(Image);
% I=imread('Capture.png');
% figure;imshow(I);title('simple');
Igray = rgb2gray(I);
% figure;imshow(Igray);title('gray scale');
Ibw = im2bw(Igray,graythresh(Igray));
% figure;imshow(Ibw);title('binary');
Iedge = edge(Ibw);
% Iedge2 = edge(uint8(Ibw));
se=strel('square',2);
Iedge2=imdilate(Iedge,se);
Ifill=imfill(Iedge2,'holes');
Ifill2= bwmorph(Ifill,'erode');
Ifill3= bwmorph(Ifill2,'dilate',1);
Ifill4=imfill(Ifill3,'holes');
[Ilabel, num] = bwlabel(Ifill);
%disp(num);
Iprops = regionprops(Ilabel);
Ibox = [Iprops.BoundingBox];
Ibox2=vertcat(Iprops.BoundingBox);
Ibox3=Ibox2;
w = Ibox2(:,3);
h = Ibox2(:,4);
aspectRatio = w-h>4 | h-w>4;
filterIdx = aspectRatio' < 1;
Iprops(filterIdx)=[];
Ibox3=vertcat(Iprops.BoundingBox);
ITextRegion = insertShape(Igray, 'Rectangle', Ibox3,'LineWidth',18);
axes(handles.Bounding_Box)
imshow(ITextRegion);
handles.Image=Image;
guidata(hObject,handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
