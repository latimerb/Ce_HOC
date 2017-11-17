: potassium delayed rectifier channel (Pyramid)

NEURON {
	SUFFIX kdr
	USEION k READ ek WRITE ik
	RANGE gkdrbar, gkdr
	RANGE inf, tau
}

UNITS {
	(mA) = (milliamp)
	(mV) = (millivolt)
}

PARAMETER {
	gkdrbar = 0.010 (siemens/cm2) <0,1e9>
}

ASSIGNED {
	v (mV)
	ek (mV)
	ik (mA/cm2)
	gkdr (siemens/cm2)
	inf
	tau (ms)
}

STATE {
	n
}

BREAKPOINT {
	SOLVE states METHOD cnexp
	gkdr = gkdrbar*n*n*n*n
	ik = gkdr*(v-ek)
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

	ma = -0.018*(v-13)/((exp(-(v-13)/25))-1)
	mb = 0.0054*(v-23)/((exp((v-23)/12))-1)


	inf = ma/(ma+mb)
	tau = 1/(ma+mb)


	UNITSON
}