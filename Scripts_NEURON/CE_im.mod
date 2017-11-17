: voltage-gated persistent muscarinic channel

NEURON {
	SUFFIX im
	USEION k READ ek WRITE ik
	RANGE gmbar, gm
	RANGE inf, tau
}

UNITS {
	(mA) = (milliamp)
	(mV) = (millivolt)
}

PARAMETER {
	gmbar = 0.0001 (siemens/cm2) <0,1e9>
}

ASSIGNED {
	v (mV)
	ek (mV)
	ik (mA/cm2)
	inf
	tau (ms)
	gm (siemens/cm2)
}

STATE {
	n
}

BREAKPOINT {
	SOLVE states METHOD cnexp
	gm = gmbar*n*n
	ik = gm*(v-ek)
}

INITIAL {
	rate(v)
	n = inf
}

DERIVATIVE states {
	rate(v)
	n' = (inf-n)/tau
}

PROCEDURE rate(v (mV)) {
	LOCAL ma, mb
	UNITSOFF

	ma = 0.016/(exp(-(v+52.7)/23))
	mb = 0.016/(exp((v+52.7)/18.8))

	
	inf = ma/(ma+mb)
	tau = 1/(ma+mb)


	UNITSON
}