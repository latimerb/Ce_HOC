:High-voltage activated Ca2+ channel

NEURON {
    SUFFIX cat
	:USEION ca READ eca WRITE ica
	USEION ca WRITE ica
	RANGE gcabar, gca
	RANGE uinf, zinf, utau, ztau 
}

UNITS {
    (mA) = (milliamp)
	(mV) = (millivolt)
}

PARAMETER {
	gcabar = 0.0001 (mho/cm2) <0,1e9>
	ecat = 120 (mV)
}

STATE { u z }

ASSIGNED {
	v (mV)
	eca (mV)
	ica (mA/cm2)
	uinf
	zinf 
	utau (ms)
	ztau (ms)
	gca (mho/cm2)
}

BREAKPOINT { 
	SOLVE states METHOD cnexp
	gca = gcabar*u*u*z
	ica = gca*(v-ecat)
}

INITIAL {
	rate(v)
	u = uinf
	z = zinf
}

DERIVATIVE states {
	rate(v)
	u' = (uinf-u)/utau
	z' = (zinf-z)/ztau
}

PROCEDURE rate(v(mV)) {
	UNITSOFF
	uinf = 1/(1+(exp(-(v+59)/5.5)))
	utau = 1.5+3.5/((exp(-(v+45)/15))+(exp((v+45)/15)))
	zinf = 1/(1+(exp((v+80)/4)))
	ztau = 10+40/((exp(-(v+60)/15))+(exp((v+60)/15)))	
	UNITSON	
}
