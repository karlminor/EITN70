clear

u = load('uGroup3.txt');
u(21:23) = [0 1 0];
state = 0;

for idx = 1:max(size(u))
    [v state] = encoder(u(idx), state);
    V(:,idx) = v;
end