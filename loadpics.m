% Load all pictures

combs = de2bi(0:(2^4)-1,'left-msb');
combs(combs == 1) = 'A';
combs(combs == 0) = 'B';
combs = char(combs);

for i=1:16, eval(['load(''', combs(i,:), '.mat'');']); end