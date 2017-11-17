: Hyperpolarization-activated channel 

NEURON {
	SUFFIX ihyper
	:USEION h READ eh WRITE ih VALENCE 1
	NONSPECIFIC_CURRENT i
	RANGE ghbar, gh, eh
	RANGE inf, tau
}

UNITS {
	(mA) = (milliamp)
	(mV) = (millivolt)
}

PARAMETER {
	ghbar = 0.00003 (siemens/cm2) <0,1e9>
	eh = -43 (mV)
}

ASSIGNED {
    i (mA/cm2)
	v (mV)
	:eh (mV)
	:ih (mA/cm2)
	inf
	tau (ms)
	gh (siemens/cm2)
}

STATE {
	n
}

BREAKPOINT {
	SOLVE states METHOD cnexp
	gh = ghbar*n
	:ih = gh*(v-eh)
	i = gh*(v-eh)
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
	UNITSOFF
	inf = 1/(1+(exp((v+89.2)/9.5)))
	tau = 1727*(exp(v*0.019))
	UNITSON	
}
