% nameplotter.m
% pass a cell array of names of variables to add to current subplot


function nameplotter(names, arrays)

for i=1:length(arrays)
  cmd=['global ' arrays{i} ';'];
  eval(cmd)
end
for i=1:length(names)
    cmd=['plot(' names{i} '(:,1),' names{i} '(:,2));'];
    eval(cmd)
end

