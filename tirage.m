function [ E ] = tirage(n, Data)

    E = zeros(n, 4);
    Rand_vec = randi([0,100], n, 1 );
    for i=1:n
        E(i,:) = Data(Rand_vec(i),:);
    end
end

