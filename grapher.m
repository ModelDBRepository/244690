% grapher.m
% Plots Smolen et al 2018

arrays = {'bas', 'ep2', 'np', 'ups', 'ed', 'lac', 'pp', 'stab', 'wsyn', 'ep1', 'lp', 'psi', 'stim'};

for i=1:length(arrays)
  cmd=['global ' arrays{i} ';'];
  eval(cmd)
  cmd=['load ' arrays{i} '.txt;'];
  eval(cmd)
end

figure
%%%%%%%%%%%
subplot(3,1,1) % Fig 3 A1
hold on 
title('Fig 1 A1')

names = {'ep2', 'bas', 'ep1', 'lac', 'stim'};
nameplotter(names, arrays)

%%%%%%%%%%%
subplot(3,1,2) % Fig 3 A2
hold on 
title('Fig 1 A2')

names = {'pp', 'np'};
nameplotter(names, arrays)

%%%%%%%%%%%
subplot(3,1,3) % Fig 3 A3
hold on 
title('Fig 1 A3')

names = {'ed', 'wsyn', 'lp'};
nameplotter(names, arrays)
