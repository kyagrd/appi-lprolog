% vim: ts=2: sw=2: expandtab: ai: syntax=lprolog

module appi.

liftv (x\vr x) (z\z).
liftv (x\nm Y) (z\nm Y).
liftv (x\pr (M x) (N x)) (z\pr (M1 z) (N1 z)) :- liftv M M1, liftv N N1.
liftv (x\fst (M x)) (z\fst (M1 z)) :- liftv M M1.
liftv (x\snd (M x)) (z\snd (M1 z)) :- liftv M M1.
liftv (x\enc (M x) (K x)) (z\enc (M1 z) (K1 z)) :- liftv M M1, liftv K K1.
liftv (x\dec (M x) (K x)) (z\dec (M1 z) (K1 z)) :- liftv M M1, liftv K K1.

liftv' (x\zero) (z\zero).
liftv' (x\par (A x) (B x)) (z\par (A1 z) (B1 z)) :- liftv' A A1, liftv' B B1.
liftv' (x\bang (A x)) (z\bang (A1 z)) :- liftv' A A1.
liftv' (x\nu y\ A y x) (z\nu y\ A1 y z) :- pi w\ liftv' (A w) (A1 w).
liftv' (x\if (N x) (M x) (P x) (Q x)) (z\if (N1 z) (M1 z) (P1 z) (Q1 z)) :-
  liftv N N1, liftv M M1, liftv' P P1, liftv' Q Q1.
liftv' (x\in (N x) (y\P y x)) (z\in (N1 z) (y\P1 y z)) :-
  liftv N N1, pi w\ liftv' (P w) (P1 w).
liftv' (x\out (N x) (M x) (P x)) (z\out (N1 z) (M1 z) (P1 z)) :-
  liftv N N1, liftv M M1, liftv' P P1.
liftv' (x\new y\ A y x) (z\new y\ A1 y z) :- pi w\ liftv' (A w) (A1 w).
liftv' (x\sub Y (M x)) (z\sub Y (M1 z)) :- liftv M M1.

subst V N (M V) (M1 N) :- liftv M M1.
subst' V N (P V) (P1 N) :- liftv' P P1.

/*
red (fst (pr M N)) M.
red (snd (pr M N)) N.
red (dec (enc M K) K) M.
red (pr M N) (pr M' N) :- red M M'.
red (pr M N) (pr M N') :- red N N'.
red (fst M) (fst N) :- red M N.
red (snd M) (snd N) :- red M N.
red (enc M K) (enc M K') :- red K K'.
red (enc M K) (enc M' K) :- red M M'.
red (dec M K) (dec M K') :- red K K'.
red (dec M K) (dec M' K) :- red M M'.

eq (vr X) (vr X).
eq (nm X) (nm X).
eq (pr M1 M2) (pr N1 N2) :- eq M1 N1, eq M2 N2.
eq (fst M) (fst N) :- eq M N.
eq (snd M) (snd N) :- eq M N.
eq (enc M K1) (enc N K2) :- eq K1 K2, eq M N.
eq (dec M K1) (dec N K2) :- eq K1 K2, eq M N.
eq M N :- red M M1, eq M1 N.
eq M N :- red N N1, eq M N1.

gr (nm X).
gr (pr M N) :- gr M, gr N.
gr (fst M) :- gr M.
gr (snd M) :- gr M.
gr (enc M K) :- gr M, gr K.
gr (dec M K) :- gr M, gr K.

pp zero.
pp (par P Q) :- pp P, pp Q.
pp (bang P) :- pp P.
pp (nu P) :- pi n\ pp (P n).
pp (if M N P Q) :- pp P, pp Q.
pp (in N P) :- pi x\ pp (P x).
pp (out N M P) :- pp P.

ep zero.
ep (par A B) :- ep A, ep B.
ep (bang P) :- pp P.
ep (nu P) :- pi n\ ep (P n).
ep (if M N P Q) :- pp P, pp Q.
ep (in N P) :- pi x\ pp (P x).
ep (out N M P) :- pp P.
ep (new P) :- pi x\ ep (P x).
ep (sub X M).

dom (par A B) X :- dom A X.
dom (par A B) X :- dom B X.
dom (nu P) X :- pi w\ dom (P w) X.
dom (new P) X :- pi w\ dom (P w) X.
dom (sub X M) X.

fv (vr X) X.
fv (pr M N) X :- fv M X.
fv (pr M N) X :- fv N X.
fv (fst M) X :- fv M X.
fv (snd M) X :- fv M X.
fv (enc M K) X :- fv M X.
fv (enc M K) X :- fv K X.
fv (dec M K) X :- fv M X.
fv (dec M K) X :- fv K X.

fn (nm X) X. 
fn (pr M N) X :- fn M X.
fn (pr M N) X :- fn N X.
fn (fst M) X :- fn M X.
fn (snd M) X :- fn M X.
fn (enc M K) X :- fn M X.
fn (enc M K) X :- fn K X.
fn (dec M K) X :- fn M X.
fn (dec M K) X :- fn K X.

fv' (par A B) X :- fv' A X.
fv' (par A B) X :- fv' B X.
fv' (bang P) X :- fv' P X.
fv' (nu A) X :- pi w\ fv' (A w) X.
fv' (if M N P Q) X :- fv M X.
fv' (if M N P Q) X :- fv N X.
fv' (if M N P Q) X :- fv' P X.
fv' (if M N P Q) X :- fv' Q X.
fv' (in N P) X :- fv N X.
fv' (in N P) X :- pi w\ fv' (P w) X.
fv' (out N M P) X :- fv M X.
fv' (out N M P) X :- fv N X.
fv' (out N M P) X :- fv' P X.
fv' (new A) X :- pi w\ fv' (A w) X.
fv' (sub Y M) X :- fv M X.
fv' (sub X M) X.

fn' (par A B) X :- fn' A X.
fn' (par A B) X :- fn' B X.
fn' (bang P) X :- fn' P X.
fn' (nu A) X :- pi w\ fn' (A w) X.
fn' (if M N P Q) X :- fn M X.
fn' (if M N P Q) X :- fn N X.
fn' (if M N P Q) X :- fn' P X.
fn' (if M N P Q) X :- fn' Q X.
fn' (in N P) X :- fn N X.
fn' (in N P) X :- pi w\ fn' (P w) X.
fn' (out N M P) X :- fn M X.
fn' (out N M P) X :- fn N X.
fn' (out N M P) X :- fn' P X.
fn' (new A) X :- pi w\ fn' (A w) X.
fn' (sub Y M) X :- fn M X.


of (pr M N) data :- of M T, of M S.
of (fst M) T :- of M data.
of (snd M) T :- of M data.
of (enc M K) data :- of M T, of K data.
of (dec M K) T :- of M data, of K data.

of' zero.
of' (par P Q) :- of' P, of' Q.
of' (bang P) :- of' P.
of' (nu P) :- pi n\ of (nm n) T => of' (P n).
of' (if M N P Q) :- of M T, of N T, of' P, of' Q.
of' (in N P) :- of N chan, pi x\ of' (P x). 
of' (out N M P) :- of N chan, of M T, of' P.
of' (new P) :- pi x\ of (vr x) T => of' (P x).
of' (sub V M) :- of (vr V) T, of M T.
*/
