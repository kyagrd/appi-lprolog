% vim: ts=2: sw=2: expandtab: ai: syntax=lprolog

sig appi.

kind vr  type.
kind nm   type.

kind tm  type.
type vr   vr -> tm.
type nm   nm -> tm.
type pr   tm -> tm -> tm.
type fst  tm -> tm.
type snd  tm -> tm.
type enc  tm -> tm -> tm.
type dec  tm -> tm -> tm.

kind p  type.
type zero  p.
type par   p -> p -> p.       % parallel comp.
type bang  p -> p.            % repicatoin
type nu    (nm -> p) -> p.    % name restriction
type if    tm -> tm -> p -> p -> p.
type in    tm -> (tm -> p) -> p. 
type out   tm -> tm -> p -> p.
type new   (vr -> p) -> p.
type sub    vr -> tm -> p.

type liftv  (vr -> tm) -> (tm -> tm) -> o.
type liftv'  (vr -> p) -> (tm -> p) -> o.
type subst  vr -> tm -> tm -> tm -> o.
type subst'  vr -> tm -> p -> p -> o.

/*
type red  tm -> tm -> o. % term reduction
type eq   tm -> tm -> o. % term equality
type gr   tm -> o.       % ground term

% well-formed processes
type pp  p -> o.  % plain process
type ep  p -> o.  % extended process

type dom  p -> vr -> o.
type fv'  p -> vr -> o.
type fn'  p -> nm -> o.
type fv   tm -> vr -> o.
type fn   tm -> nm -> o.

kind sort type.
type chan sort.
type data sort.

type of  tm -> sort -> o.  % |- M : T
type of' p -> o.           % |- P
*/
