function A = ParTraceTable(table)
    
    B = table2array(table);
    A = zeros(size(B,1), 3);
    for i = 1:size(B,1)
        A(i,:) = parTrace(B(i,1), B(i,2), B(i,3), B(i,4), B(i,5));
    end
    A = array2table(A, 'VariableNames', {'Induct', 'Capac', 'Impede'});
end