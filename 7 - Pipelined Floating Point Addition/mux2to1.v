module m21(input D0, input D1, input S, output Y);

    wire T1, T2, Sbar;

    and (T1, D1, S), (T2, D0, Sbar);
    not (Sbar, S);
    or (Y, T1, T2);

endmodule
