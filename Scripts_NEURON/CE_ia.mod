: potassium delayed rectifier channel (Pyramid)

NEURON {
	SUFFIX a
	USEION k READ ek WRITE ik
	RANGE gabar, ga
	RANGE inf, tau
}

UNITS {
	(mA) = (milliamp)
	(mV) = (millivolt)
}

PARAMETER {
	gabar = 0.0057 (siemens/cm2) <0,1e9>
}

ASSIGNED {
	v (mV)
	ek (mV)
	ik (mA/cm2)
	ga (siemens/cm2)
	minf
	mtau (ms)
	ninf
	ntau  (ms)
}

STATE {
	m n
}

BREAKPOINT {
	SOLVE states METHOD cnexp
	ga = gabar*m*n
	ik = ga*(v-ek)
}

INITIAL {
	rate(v)
	m = minf
	n = ninf
}

DERIVATIVE states {
	rate(v)
	m' = (minf-m)/mtau
	n' = (ninf-n)/ntau
}

PROCEDURE rate(v (mV)) {
	LOCAL ma, mb, na, nb
	UNITSOFF

	ma = -0.05*(v+20)/((exp(-(v+20)/15))-1)
	mb = 0.1*(v+10)/((exp((v+10)/8))-1)
	
	na = .00012/(exp((v-2)/15))
	nb = .048/((exp(-(v+53)/12))+1)

	minf = ma/(ma+mb)
	mtau = 1/(ma+mb)
	
	ninf = na/(na+nb)
	ntau = 1/(na+nb)

	UNITSON
}