function [ E ] = tirage(n, M)

    E = zeros(n, 4);
    Rand_vec = randi([0,100], n, 1 );
    for i=1:n
        E(i,:) = M(randi(i),:);
    end
end

