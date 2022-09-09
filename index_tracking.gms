Option MINLP = BARON;
Option reslim = 10;

set i
    t;
    
$GDXIN %gdxincname%
$LOAD i,t
$GDXIN



parameter

    C
    lower
    upper
    r(i,t)
    rprime(t);
    
    
$GDXIN %gdxincname%
$LOAD C,lower,upper, r, rprime
$GDXIN

binary variable delta(i);

variable z;

positive variable x(i);


equation obj,const1,const2,const3,const4;

obj..
    z =e= sum(t,(sum(i,r(i,t)*x(i)) - rprime(t))*(sum(i,r(i,t)*x(i)) - rprime(t)));

const1..
    sum(i,delta(i)) =e= C;

const2..
    sum(i,x(i)) =e= 1;

const3(i)..
    lower*delta(i) =l= x(i);

const4(i)..
    upper*delta(i) =g= x(i);


model indexTracking /all/;
solve indexTracking using MINLP minimizing z;
display z.l, delta.l,x.l,lower,upper,r,rprime;





parameter
    stat;
stat = indexTracking.modelStat;
display stat