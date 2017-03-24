# appi-lprolog
A little taste of Applied Pi-Calculus specification in lambda-Prolog.

This repositoy demonstrates that the Abella prover (version 2.0.5-dev) is
very much slower in executing lambda-Prolog specifications in comparison to
the Teyjus lambda-Prolog compiler (version 2.0-b2).

The appi module (`appi.sig` and `appi.mod` files) defines the syntax and
substitution predicates for an instance of Applied Pi-Calculs, which is
comparable to the spi calculs, in lambda-Prolog code. The substitiution
predicates are defined by higher-order mathcing, enjoing the advantages
of higher-order logic programming style possible in lambda-Prolog.

With the Teyjus compiler, we can pleasently test small examples quries
of substitituions within a blink of an eye. For example, the following
quries of small substitution examples work as expected.

```
kyagrd@kyagrd:~/Dropbox/Saves/abellawalk/appi$ ~/github/teyjus/teyjus/tjcc appi.mod
kyagrd@kyagrd:~/Dropbox/Saves/abellawalk/appi$ rlwrap ~/github/teyjus/teyjus/tjlink appi
kyagrd@kyagrd:~/Dropbox/Saves/abellawalk/appi$ rlwrap ~/github/teyjus/teyjus/tjsim appi
Welcome to Teyjus
Copyright (C) 2008 A. Gacek, S. Holte, G. Nadathur, X. Qi, Z. Snow
Teyjus comes with ABSOLUTELY NO WARRANTY
This is free software, and you are welcome to redistribute it
under certain conditions. Please view the accompanying file
COPYING for more information
[appi] ?- pi x\ pi m\ subst' x m (if (vr x) (vr x) zero zero) (if m m zero (par zero zero)).

no (more) solutions

[appi] ?- pi x\ pi m\ subst' x m (if (vr x) (vr x) zero zero) (if m m zero zero).

yes

[appi] ?- subst' X M (if (vr X) (vr X) zero zero) N.

The answer substitution:
N = if M M zero zero
M = M
X = X

More solutions (y/n)? y

no (more) solutions
```

However, the Abella prover is incredibily slow to run quires like above (`appi.thm` file contains the quries comparable to above). It takes more than 1 hour and I gave up wating for the result, even with CPU power of the HP Z440 workstation powered by Intel's Zeon processor with a lot of cores. I'm quite sure that it is not going into an infinite loop because when I cut down the syntax of the applied pi-calculus process, say leaving only `zero` and `if` processes, then it comes back in about 10 miniutes. Below is the console output of runing `appi.thm` with Abella.

```
kyagrd@kyagrd:~/github/kyagrd/appi-lprolog$ abella appi.thm
Welcome to Abella 2.0.5-dev
Abella < Specification "appi".
Reading specification "/home/kyagrd/github/kyagrd/appi-lprolog/./appi" (from "/home/kyagrd/github/kyagrd/appi-lprolog/.")

Abella < Theorem test_subst : 
forall x M, {subst x M (vr x) M}.


============================
 forall x M, {subst x M (vr x) M}

test_subst < intros.

Variables: x M
============================
 {subst x M (vr x) M}

test_subst < search.
Proof completed.
Abella < Theorem test_subst'_degenerate : 
forall x M, {subst' x M zero zero}.


============================
 forall x M, {subst' x M zero zero}

test_subst'_degenerate < intros.

Variables: x M
============================
 {subst' x M zero zero}

test_subst'_degenerate < search.
Proof completed.
Abella < Theorem test_subst' : 
forall x M, {subst' x M (if (vr x) (vr x) zero zero) (if M M zero zero)}.


============================
 forall x M, {subst' x M (if (vr x) (vr x) zero zero) (if M M zero zero)}

test_subst' < intros.

Variables: x M
============================
 {subst' x M (if (vr x) (vr x) zero zero) (if M M zero zero)}

test_subst' < search.
^CError: Interrupted (use Ctrl-D to quit)
```
