/**/
:- [fields].
:- [listHelper].

/*
 * Defining Vectors and their Properties.
 * */

% vector(Entries, Field, Dimension) - succeeds if the vector with given Entries
%                                     is of the correct Dimension and Field.
vector(Entries, Field, Dimension) :-
  len(Entries, Dimension),
  in_field(Entries, Field).

% vdot(Vector, Vdot) - succeeds if Vdot is the dot product of the vector Vector,
%                      and if Vector is in fact a valid Vector.
vdot(vector(Entries, Field, Dimension), Vdot) :-
  vector(Entries, Field, Dimension),
  sum_entries(Entries, Vdot),
  in_field(Entries, Field).

% vsum(V1, V2, Res) - succeeds if V1, V2, Res are valid vectors and V1+V2=Res.
vsum(vector(E1, F0, D),
     vector(E2, F1, D),
     vector(R, F, D)) :-
  vector(E1, F0, D),
  vector(E2, F1, D),
  add_scalars(E1, E2, R),
  extension_field(F0, F1, F).

% scalar_product(C, V0, V) - succeeds if V0, V1 are valid vectors and C*V0=V1.
scalar_product(Scalar,
               vector(E0, F0, D),
               vector(E1, F1, D)) :-
  vector(E0, F0, D),
  mult_scalars(Scalar, E0, E1),
  field(Scalar, Fs),
  extension_field(Fs, F0, F1).

% norm2(Vector, N) - succeeds if N is the square of the norm of a valid Vector.
norm2(vector([H|T], F, D), Norm) :-
  pow2(H, H2),
  D1 is D-1,
  norm2(vector(T, F, D1), Norm1),
  pow2(Norm1, N1Sqr),
  add_scalar(H2, N1Sqr, Norm).
norm2(vector([H], _, 1), Norm) :- pow2(H, Norm).
  
% vector_proj(V, W, Res) - succeeds if Res is the projection of V