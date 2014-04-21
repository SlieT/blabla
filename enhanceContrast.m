function varargout = enhanceContrast(varargin)
% ENHANCECONTRAST MATLAB code for enhanceContrast.fig
%      ENHANCECONTRAST, by itself, creates a new ENHANCECONTRAST or raises the existing
%      singleton*.
%
%      H = ENHANCECONTRAST returns the handle to a new ENHANCECONTRAST or the handle to
%      the existing singleton*.
%
%      ENHANCECONTRAST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ENHANCECONTRAST.M with the given input arguments.
%
%      ENHANCECONTRAST('Property','Value',...) creates a new ENHANCECONTRAST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before enhanceContrast_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to enhanceContrast_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help enhanceContrast

% Last Modified by GUIDE v2.5 19-Apr-2014 01:09:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @enhanceContrast_OpeningFcn, ...
                   'gui_OutputFcn',  @enhanceContrast_OutputFcn, ...
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


% --- Executes just before enhanceContrast is made visible.
function enhanceContrast_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to enhanceContrast (see VARARGIN)

% Choose default command line output for enhanceContrast
handles.output = hObject;

hMain = getappdata(0, 'hMainGui');

% set some data
currTraImg  = getappdata( hMain, 'currTraImg' );
currSagImg  = getappdata( hMain, 'currSagImg' );
currCorImg  = getappdata( hMain, 'currCorImg' );

setappdata(handles.enhanceContrast, 'currView'              , 'tra');
setappdata(handles.enhanceContrast, 'currImg'               , currTraImg);
setappdata(handles.enhanceContrast, 'currTestImg'           , currTraImg);
setappdata(handles.enhanceContrast, 'currTraImg'            , currTraImg );
setappdata(handles.enhanceContrast, 'currSagImg'            , currSagImg );
setappdata(handles.enhanceContrast, 'currCorImg'            , currCorImg );
setappdata(handles.enhanceContrast, 'currMethod'            , 'imadjust' );
setappdata(handles.enhanceContrast, 'methodHistory'         , {} );
setappdata(handles.enhanceContrast, 'methodHistoryIndex'    , 0 );

imshow( currTraImg );

% set global data
setDataMainGui( 'henhanceContrast', handles );
setDataMainGui( 'fhUpdateTestView', @updateTestView );

% Update handles structure
guidata(hObject, handles);

% clear the command line
clc;

% UIWAIT makes enhanceContrast wait for user response (see UIRESUME)
% uiwait(handles.enhanceContrast);


% --- Outputs from this function are returned to the command line.
function varargout = enhanceContrast_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes when user attempts to close enhanceContrast.
function enhanceContrast_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to enhanceContrast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);


% --- setData globallike
function setDataMainGui( name, value )
hMain = getappdata(0, 'hMainGui');
setappdata(hMain, name, value);


% --- getData globallike
function data = getDataMainGui( name )
hMain = getappdata(0, 'hMainGui');
data  = getappdata(hMain, name);


% --- keep the current zoom state
function imshowKeepZoom( img )
xZoom = xlim;
yZoom = ylim;

imshow( img ); 

% set current zoom state
xlim(xZoom);
ylim(yZoom);


function val1_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of val1 as text
%        str2double(get(hObject,'String')) returns contents of val1 as a double

% suppress callback on focusout(/mouse leave + click) if method contains two or more input
% variables
methodNumber = get( handles.chooseMethod, 'Value' );

% 3 = Adaptive histogram equalization, 6 = Contrast-stretching transformation
if methodNumber ~= 3 && methodNumber ~= 6
    applyToView( handles, 1 );
end


% --- Executes during object creation, after setting all properties.
function val1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to val1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function val2_Callback(hObject, eventdata, handles)

% Hints: get(hObject,'String') returns contents of val2 as text
%        str2double(get(hObject,'String')) returns contents of val2 as a double

% suppress callback on focusout(/mouse leave + click) if method contains two or more input
% variables
methodNumber = get( handles.chooseMethod, 'Value' );

% 3 = Adaptive histogram equalization, 6 = Contrast-stretching transformation
if methodNumber ~= 3 && methodNumber ~= 6
    applyToView( handles, 1 );
end

    

% --- Executes during object creation, after setting all properties.
function val2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to val2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function imgEnhanced = applyMethods( img, methodHistory, methodHistoryIndex )
    mH      = methodHistory;
    mHIndex = methodHistoryIndex;

% apply previous methods
    for i = 1:1:mHIndex;
        mName = mH{i}(1);
        
        if strcmp(mName, 'imadjust')
            img = imadjust( img );
            
        elseif strcmp(mName, 'imadjust_coherent')
            u       = mH{i}(2); 
            o       = mH{i}(3);
            u = u{1}(1); o = o{1}(1);
            img = imadjust( img, [ u o ], [ 0 1 ] );
        
        elseif strcmp(mName, 'gamma')
            u       = mH{i}(2);
            o       = mH{i}(3); 
            g       = mH{i}(4);
            u = u{1}(1); o = o{1}(1); g = g{1}(1);
            img = imadjust( img, [ u o ], [ 0 1 ], g );
            
        elseif strcmp(mName, 'adapthisteq')    
            M       = mH{i}(2);
            N       = mH{i}(3);
            M = M{1}(1); N = N{1}(1);
            img = adapthisteq( img , 'NumTiles', [ M N ] );
            
        elseif strcmp(mName, 'imcomplement')
            img = imcomplement( img );     
        
       	elseif strcmp(mName, 'log')
            c    	= mH{i}(2);
            c = c{1}(1);
            img	= im2double( img );
            img	= c*(log( 1 + img ));
            img	= im2uint16( img );
        elseif strcmp(mName, 'stretch')
            m       = mH{i}(2);
            E       = mH{i}(3);
            m = m{1}(1); E = E{1}(1);
            img = im2double(img);
            img = 1./(1 + (m./(img + eps)).^E);
            img = im2uint16(img);  
 
        end 
    end
    
    imgEnhanced = img;


% --- applies to view
function applyToView( handles, applyMethod )

% image or view change, or method undo
if applyMethod == 0
    % get current image
    currImg = getappdata(handles.enhanceContrast, 'currImg' );
    setappdata(handles.enhanceContrast, 'currImg', currImg );
    
    testImg = currImg;
    mH      = getappdata(handles.enhanceContrast, 'methodHistory' );
    mHIndex = getappdata(handles.enhanceContrast, 'methodHistoryIndex' );
    
    % no previous methods
    if mHIndex == 0
        imshowKeepZoom( testImg ); 
        setappdata(handles.enhanceContrast, 'currTestImg', testImg );
        return 
    end
    
    % apply previous methods
    testImg = applyMethods( testImg, mH, mHIndex );
 
    imshowKeepZoom( testImg );     
    setappdata(handles.enhanceContrast, 'currTestImg', testImg );
    return
end

% get current method
method  = getappdata(handles.enhanceContrast, 'currMethod' );
% get current test-image
testImg = getappdata(handles.enhanceContrast, 'currTestImg' );

mH      = getappdata( handles.enhanceContrast, 'methodHistory' );
mHIndex = getappdata( handles.enhanceContrast, 'methodHistoryIndex' );
mHIndex = mHIndex + 1;

if strcmp(method, 'imadjust')
    mH{ mHIndex }   = { 'imadjust' };
    testImg         = imadjust( testImg );
elseif strcmp(method, 'imadjust_coherent')
    u               = double(min(testImg(:))) / double(65535);
    o               = double(max(testImg(:))) / double(65535);
    mH{ mHIndex }   = { 'imadjust_coherent', u, o };
    testImg         = imadjust( testImg, [ u o ], [ 0 1 ] );
    
elseif strcmp(method, 'gamma')
    u               = double(min(testImg(:))) / double(65535);
    o               = double(max(testImg(:))) / double(65535); 
    g               = str2double( get( handles.val1, 'string' ));
    mH{ mHIndex }   = { 'gamma', u, o, g };
    testImg = imadjust( testImg, [ u o ], [ 0 1 ], g );
    
elseif strcmp(method, 'adapthisteq')
    M = round(str2double( get( handles.val1, 'string' )));
    N = round(str2double( get( handles.val2, 'string' )));
    if M < 2
        M = 2;
    elseif N < 2
        N = 2;
    end
    set( handles.val1, 'string', M );
    set( handles.val2, 'string', N );
    
    mH{ mHIndex }   = { 'adapthisteq', M, N };
    testImg         = adapthisteq( testImg , 'NumTiles', [ M N ] );
    
elseif strcmp(method, 'imcomplement')
    mH{ mHIndex }   = { 'imcomplement' };
    testImg         = imcomplement( testImg ); 
    
elseif strcmp(method, 'log')
    c               = str2double( get( handles.val1, 'string' ));
    testImg         = im2double( testImg );
    testImg         = c*(log( 1 + testImg ));
    mH{ mHIndex }   = { 'log', c };
    testImg         = im2uint16( testImg );
    
elseif strcmp(method, 'stretch')
    m = str2double( get( handles.val2, 'string' ));
    if m > 1
        m = m / 65535;
        set( handles.val2, 'string', m );
        return;
    end
    E = str2double( get( handles.val1, 'string' ));
    
    testImg = im2double(testImg);
    testImg = 1./(1 + (m./(testImg + eps)).^E);
    testImg = im2uint16(testImg);
    mH{ mHIndex }   = { 'stretch', m, E };
end

setappdata(handles.enhanceContrast, 'methodHistory'         , mH );
setappdata(handles.enhanceContrast, 'methodHistoryIndex'    , mHIndex );
setappdata(handles.enhanceContrast, 'currTestImg'           , testImg);

imshowKeepZoom( testImg );    

% --- Executes on button press in applyToView.
function applyToView_Callback(hObject, eventdata, handles)
% hObject    handle to applyToView (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

applyToView( handles, 1 );


% --- Executes on button press in applyToImage.
function applyToImage_Callback(hObject, eventdata, handles)
% hObject    handle to applyToImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

currFigure  = gcf();
images      = getDataMainGui( 'Images' );
currTestImg = getappdata( handles.enhanceContrast, 'currTestImg' );
currCiew    = get(handles.chooseView,'Value'); 
hMain       = getDataMainGui( 'handles' );

% apply current image
if currCiew == 1      % transversal
    currIndex             = get( hMain.sliderTra, 'Value' );
	images(:,:,currIndex) = currTestImg;
    
elseif currCiew == 2  % sagittal
    currIndex      = get( hMain.sliderSag, 'Value' );
    sizeI          = size(currTestImg, 2); % 256
    sizeJ          = size(currTestImg, 1); % 170
        
    for i=1:1:sizeI
        for j=1:1:sizeJ
            images(i,currIndex,j) = currTestImg(sizeJ+1 - j, i);
        end
    end
    
else                 % coronal
    currIndex      = get( hMain.sliderCor, 'Max' )+1 - get( hMain.sliderCor, 'Value' );
    sizeI          = size(currTestImg, 2); % 256
    sizeJ          = size(currTestImg, 1); % 170
        
    for i=1:1:sizeI
        for j=1:1:sizeJ
            images(currIndex,i,j) = currTestImg(sizeJ+1 - j, i);
        end
    end
        
end

setDataMainGui( 'Images', images );

% update hMain
hMain          = getDataMainGui( 'handles' );
fhUpdateTraImg = getDataMainGui( 'fhUpdateTraImg' );
fhUpdateSagImg = getDataMainGui( 'fhUpdateSagImg' );
fhUpdateCorImg = getDataMainGui( 'fhUpdateCorImg' );

% functionEvaluation
feval( fhUpdateTraImg, get( hMain.sliderTra, 'Value' ), hMain );
feval( fhUpdateSagImg, get( hMain.sliderSag, 'Value' ), hMain );
feval( fhUpdateCorImg, get( hMain.sliderCor, 'Value' ), hMain );

% set currFigure as the current figure
figure( currFigure );


% --- Executes on button press in applyToImages.
function applyToImages_Callback(hObject, eventdata, handles)
% hObject    handle to applyToImages (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

currFigure  = gcf();
images      = getDataMainGui( 'Images' );
s           = size( images );
numImages   = s( 3 );
mH          = getappdata( handles.enhanceContrast, 'methodHistory' );
mHIndex     = getappdata( handles.enhanceContrast, 'methodHistoryIndex' );

% apply methodHistory to all images
for i = numImages:-1:1
    img           = images(:,:,i);
    img           = applyMethods( img, mH, mHIndex );
    images(:,:,i) = img(:,:);
end

setDataMainGui( 'Images', images );
setappdata(handles.enhanceContrast, 'methodHistory'         , {} );
setappdata(handles.enhanceContrast, 'methodHistoryIndex'    , 0 );

% update hMain
hMain        = getDataMainGui( 'handles' );
fhUpdateTraImg = getDataMainGui( 'fhUpdateTraImg' );
fhUpdateSagImg = getDataMainGui( 'fhUpdateSagImg' );
fhUpdateCorImg = getDataMainGui( 'fhUpdateCorImg' );

% functionEvaluation
feval( fhUpdateTraImg, get( hMain.sliderTra, 'Value' ), hMain );
feval( fhUpdateSagImg, get( hMain.sliderSag, 'Value' ), hMain );
feval( fhUpdateCorImg, get( hMain.sliderCor, 'Value' ), hMain );

% set currFigure as the current figure
figure( currFigure );


% --- Executes on selection change in chooseView.
function chooseView_Callback(hObject, eventdata, handles)
% Hints: contents = cellstr(get(hObject,'String')) returns chooseView contents as cell array
%        contents{get(hObject,'Value')} returns selected item from chooseView

currVal     = get(hObject,'Value'); 


if currVal == 1      % transversal
    currImg       = getDataMainGui( 'currTraImg' );
    setappdata(handles.enhanceContrast, 'currView', 'tra');
elseif currVal == 2  % sagittal
    currImg       = getDataMainGui( 'currSagImg' );
    setappdata(handles.enhanceContrast, 'currView', 'sag');
else                 % coronal
    currImg       = getDataMainGui( 'currCorImg' );
    setappdata(handles.enhanceContrast, 'currView', 'cor');
end

setappdata(handles.enhanceContrast, 'currImg', currImg);
applyToView( handles, 0 );


% --- Executes during object creation, after setting all properties.
function chooseView_CreateFcn(hObject, eventdata, handles)
% hObject    handle to chooseView (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in showHistogram.
function showHistogram_Callback(hObject, eventdata, handles)

figure, imhist( getappdata(handles.enhanceContrast, 'currTestImg' ) );


function updateTestView(view, currImg)
handles     = getDataMainGui( 'henhanceContrast' );
currView    = getappdata(handles.enhanceContrast, 'currView');

if strcmp(currView,'tra') && strcmp(view,'tra')         % transversal
    setappdata(handles.enhanceContrast, 'currTraImg', currImg );
elseif strcmp(currView,'sag') && strcmp(view,'sag')     % sagittal
    setappdata(handles.enhanceContrast, 'currSagImg', currImg );
elseif strcmp(currView,'cor') && strcmp(view,'cor')     % coronal
    setappdata(handles.enhanceContrast, 'currCorImg', currImg );
end

if strcmp(currView,view)
    setappdata(handles.enhanceContrast, 'currImg', currImg );
    
    % due to the sync by the prototype we need to set axes
    axes( handles.testView );

    % save current zoom state
    xZoom = xlim;
    yZoom = ylim;

    applyToView( handles, 0 );

    % undo current zoom state
    xlim(xZoom);
    ylim(yZoom);
end


% --- Executes on button press in undo.
function undo_Callback(hObject, eventdata, handles)

mH      = getappdata(handles.enhanceContrast, 'methodHistory' );
mHIndex = getappdata(handles.enhanceContrast, 'methodHistoryIndex' );

if mHIndex > 0
    mH{ mHIndex } = {};
    mHIndex = mHIndex - 1;

    setappdata(handles.enhanceContrast, 'methodHistory'         , mH );
    setappdata(handles.enhanceContrast, 'methodHistoryIndex'    , mHIndex );
    
else
    warndlg( 'No used method which could be undone.', 'Attention' );
    return;
end


applyToView( handles, 0 );


% --- Executes on selection change in chooseMethod.
function chooseMethod_Callback(hObject, eventdata, handles)
% hObject    handle to chooseMethod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns chooseMethod contents as cell array
%        contents{get(hObject,'Value')} returns selected item from chooseMethod

currVal     = get(hObject,'Value'); 

if currVal == 1      % Distribute intensities
    setappdata(handles.enhanceContrast, 'currMethod', 'imadjust' );
    set( handles.valuePanel , 'visible', 'off' );
    set( handles.infoText   , 'string' , 'Distributes the intensities in the current image.' );
elseif currVal == 2      % Distribute intensities (coherent)
    setappdata(handles.enhanceContrast, 'currMethod', 'imadjust_coherent' );
    set( handles.valuePanel , 'visible', 'off' );
    set( handles.infoText   , 'string' , 'Distributes the intensities in this image, seen in the "Test view". The image is then used as a "scheme" for any other image to get a coherent result of contrast improvement, at the same intensity-level.' );
elseif currVal == 3  % Weighted distribute intensities
    setappdata(handles.enhanceContrast, 'currMethod', 'gamma' );
    set( handles.valuePanel , 'visible', 'on' );
    set( handles.textVal1   , 'string' , 'Gamma');
    set( handles.val1       , 'string' , '1');
    set( handles.textVal2   , 'visible', 'off' );
    set( handles.val2       , 'visible', 'off' );
    set( handles.infoText   , 'string' , 'Distributes the given intensities over the hole spectrum of possible ones - weighted towards the brighter (gamma < 1) or the darker(gamma > 1) end.' );
elseif currVal == 4  % Adaptive histogram equalization
    setappdata(handles.enhanceContrast, 'currMethod', 'adapthisteq' );
    set( handles.valuePanel , 'visible', 'on' );
    set( handles.textVal1   , 'string' , 'M');
    set( handles.val1       , 'string' , '8');
    
    set( handles.textVal2   , 'visible', 'on' );
    set( handles.textVal2   , 'string' , 'N');
    set( handles.val2       , 'visible', 'on' );
    set( handles.val2       , 'string' , '8');

    set( handles.infoText   , 'string' , 'Adaptive histogram equalization enhances the contrast of the image by using the ''histogram equalization''-method but only on small regions in the image, so called ''tiles''. These tiles are of size M * N pixels. M and N take values greater or equal ''2''.' );
elseif currVal == 5  % Complement 
    setappdata(handles.enhanceContrast, 'currMethod', 'imcomplement' );
    set( handles.valuePanel , 'visible', 'off' );
    set( handles.infoText   , 'string' , 'This method complements the current image.' );
elseif currVal == 6  % Logarithmic transformation
    setappdata(handles.enhanceContrast, 'currMethod', 'log' );
    set( handles.valuePanel , 'visible', 'on' );
    set( handles.textVal1   , 'string' , 'c');
    set( handles.val1       , 'string' , '1.4');
    set( handles.textVal2   , 'visible', 'off' );
    set( handles.val2       , 'visible', 'off' );
    set( handles.infoText   , 'string' , 'To enhance the contrast of bright pixels COMPLEMENT the image first, because applying the logarithmic transformation will expand values of dark pixels in an image while compressing the bright pixels. Method: c*(log(1 + image))' );
elseif currVal == 7  % Contrast-stretching transformation
    setappdata(handles.enhanceContrast, 'currMethod', 'stretch' );
    set( handles.valuePanel , 'visible', 'on' );
    set( handles.textVal1   , 'string' , 'E');
    set( handles.val1       , 'string' , '4');
    
    set( handles.textVal2   , 'visible', 'on' );
    set( handles.textVal2   , 'string' , 'm or pixelToM');
    set( handles.textVal2   , 'tooltipString', 'if m is between [0 - 1] it will take the number as ''m''. Otherwise it will take the number as a pixelvalue to compute ''m'' (m=pixelvalue/65535).');
    
    set( handles.val2       , 'visible', 'on' );
    set( handles.val2       , 'string' , 'see tooltip');
    set( handles.val2       , 'tooltipString', 'if m is between [0 - 1] it will take the number as ''m''. Otherwise it will take the number as a pixelvalue to compute ''m'' (m=pixelvalue/65535).');
    set( handles.infoText   , 'string' , '(CLICK on this text to get more help) Contrast-stretching transformations increase the contrast at a certain level(m) by transforming everything dark a lot darker and everything bright a lot brighter, with only a few levels of gray around the point of interest. E controls the slope of the function and m is the mid-line where it switches from dark values to light values.' );
end


% --- Executes during object creation, after setting all properties.
function chooseMethod_CreateFcn(hObject, eventdata, handles)
% hObject    handle to chooseMethod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over infoText.
function infoText_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to infoText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if strcmp(get( hObject, 'string' ), '(CLICK on this text to get more help) Contrast-stretching transformations increase the contrast at a certain level(m) by transforming everything dark a lot darker and everything bright a lot brighter, with only a few levels of gray around the point of interest. E controls the slope of the function and m is the mid-line where it switches from dark values to light values.')
    contrastStretchHelp
end


% --- Executes when enhanceContrast is resized.
function enhanceContrast_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to enhanceContrast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% uipanel2 and testView have the property "units" set to "normalized"

oldUnits        = get(hObject,'Units');
set(hObject,'Units','pixels');
figPos          = get(hObject,'Position');

% set infoText
set(handles.infoText,'Units','pixels');
infoTextPos     = get(handles.infoText,'Position');
% upos          = left, bottom, widht, height
% new bottom    = heightFigure-hightInfo-7pxDefaultSpace(the space between infoText and upper border of the figure)
% 7pxDefaultSpace = figPos(4) - infoTextPos(2) - infoTextPos(4)
newBottom       = figPos(4) - infoTextPos(4) - 7;
upos            = [infoTextPos(1), newBottom, infoTextPos(3), infoTextPos(4)];
set(handles.infoText,'Position',upos);

% set methodPanel
set(handles.methodPanel,'Units','pixels');
methodPanelPos      = get(handles.methodPanel,'Position');
newBottom           = figPos(4) - methodPanelPos(4) - 49;
oldUnitsUIPanel2    = get(handles.uipanel2,'Units');
set(handles.uipanel2,'Units','pixels');
UIPanel2Pos         = get(handles.uipanel2,'Position');
%methodPanelPos(1)-(UIPanel2Pos(1)+UIPanel2Pos(3)) = 32 % space between
%uipanel2 and methodPanel
newLeft             = UIPanel2Pos(1) + UIPanel2Pos(3) + 32;
%newLeft         = figPos(3) - methodPanelPos(3) - 21; % keep method Panel
%on the right edge
upos                = [newLeft, newBottom, methodPanelPos(3), methodPanelPos(4)];
set(handles.methodPanel,'Position',upos);
set(handles.uipanel2,'Units',oldUnitsUIPanel2);

set(hObject,'Units',oldUnits);


% --- Executes on button press in up.
function up_Callback(hObject, eventdata, handles)
% hObject    handle to up (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fhUpDown = getDataMainGui( 'fhUpDown' );
feval( fhUpDown, handles, true );


% --- Executes on button press in up.
function down_Callback(hObject, eventdata, handles)
% hObject    handle to up (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fhUpDown = getDataMainGui( 'fhUpDown' );
feval( fhUpDown, handles, false );
