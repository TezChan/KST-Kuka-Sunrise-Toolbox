%% Example
% Drawing a sequare with a pen using the KUKA iiwa robot

% An example script, it is used to show how to use the different
% functions of the KUKA Sunrise matlab toolbox

% First start the server on the KUKA iiwa controller
% Then run the following script in Matlab

% Mohammad SAFEEA, 3rd of May 2017

% be careful when runnning the script, be sure that no human, nor obstacles
% are around the robot

close all,clear all;clc

ip='172.31.1.147'; % The IP of the controller
% start a connection with the server
t=net_establishConnection( ip );

if ~exist('t','var') || isempty(t)
  warning('Connection could not be establised, script aborted');
  return;
else
    
%% move to some initial position
    pinit={0,pi*20/180,0,-pi*70/180,0,pi*90/180,0}; % initial confuguration
    relVel=0.15; % relative velocity
    movePTPJointSpace( t , pinit, relVel); % point to point motion in joint space

%% Get position roientation of end effector
      fprintf('\nCartesian position/orientaion of end-effector \n')
      Pos=getEEFPos( t )
      z_1=Pos{3}; % save initial hight level
    
      %setBlueOn(t); % turn on blue light
    
      z0=448+3; % go to writing position
      
      relVel=50; % velocity of the end effector, mm/sec
      
      
      %% insert Pen at box level
      
      Pos{3}=z0; %% first point
      
       movePTPLineEEF( t , Pos, relVel) 
       
       disp=50*2;
       
       %% move in x positive direction
       Pos{1}=Pos{1}+disp; 
      
       movePTPLineEEF( t , Pos, relVel)
       
       %% move in y negative direction
       Pos{2}=Pos{2}-disp; 
      
       movePTPLineEEF( t , Pos, relVel)
       
       %% move in x negative direction
       Pos{1}=Pos{1}-disp; 
      
       movePTPLineEEF( t , Pos, relVel)
       
       %% move in y positive direction
       Pos{2}=Pos{2}+disp; 
      
       movePTPLineEEF( t , Pos, relVel)

       %% Go back to initial position
       Pos{3}=z_1;
       movePTPLineEEF( t , Pos, relVel) 
       
       %setBlueOff(t); 
      %% turn off the server
       net_turnOffServer( t );


       fclose(t);
end

