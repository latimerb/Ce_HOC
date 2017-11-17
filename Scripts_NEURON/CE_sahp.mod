:  iC   fast Ca2+/V-dependent K+ channel

NEURON {
	SUFFIX sAHP
	USEION k READ ek WRITE ik
	:USEION cas READ casi VALENCE 2 
    USEION ca READ cai  
	RANGE ik, gk, gsAHPbar
}

UNITS {
        (mM) = (milli/liter)
	(mA) = (milliamp)
	(mV) = (millivolt)
}

PARAMETER {
	gsAHPbar= 0.0015	(mho/cm2)
}

ASSIGNED {
	v (mV)
	ek (mV)
	:casi (mM)
	cai (mM)
	ik (mA/cm2)
	cinf 
	ctau (ms)
	gk (mho/cm2)
}

STATE {
	c
}

BREAKPOINT {
	SOLVE states METHOD cnexp
	gk = gsAHPbar*c       
	ik = gk*(v-ek)
}



INITIAL {
	:rate(v,casi)
	rate(v,cai)
	c = cinf
}

DERIVATIVE states {
    :    rate(v,casi)
	rate(v,cai)
	c' = (cinf-c)/ctau
}


PROCEDURE rate(v (mV), cai (mM)) {LOCAL  csum, ca, cb
	UNITSOFF
	ca = 0.0048/(exp(-5*log10(1e3*cai)+17.5))
	cb = 0.012/(exp(2*log10(1e3*cai)+20))
	csum = ca+cb
	cinf = ca/csum
	ctau = 48
	UNITSON
}
