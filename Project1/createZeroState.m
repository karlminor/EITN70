function [zeroState, stateBin] = createZeroState(transition)
for states = 1:8
        for idx = 1:3
            stateBin(states,idx) = bitget(states-1,idx);
        end
end
for sc = 1:8
    counter = 0;
    for state = 1:8
        s = sc;
        for i = 1:3
            s = transition(s, stateBin(state,i)+1);
        end
        
        if s == 1
            counter = counter + 1;
            workingState(sc,counter) = state;
        end
    end
end
zeroState = workingState;

