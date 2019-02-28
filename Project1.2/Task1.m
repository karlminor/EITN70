clear

states = [0 1 2 3 4 5 6 7]
u = [0 1]

for si = 1:numel(states)
        for i = 1:3
            preStates(si,i) = bitget(states(si),i);
        end
        [v state] = encoder(u(1), states(si));
        for i = 1:3
            postStates0(si,i) = bitget(state,i);
        end
        V0(si,:) = v;
        
        [v state] = encoder(u(2), states(si));
        for i = 1:3
            postStates1(si,i) = bitget(state,i);
        end
        V1(si,:) = v;
end
varNamesV = {'Prestate', 'zero', 'one'};
varNamesS = {'Prestate', 'zero', 'one'};
TV = table(preStates, V0, V1, 'VariableNames', varNamesV);
TS = table(preStates, postStates0, postStates1, 'VariableNames', varNamesS);
