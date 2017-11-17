: High Volatage activating channel (Pyramid) Ihva

NEURON {
    SUFFIX hva
	:USEION hva READ ehva WRITE ihva VALENCE 1
	USEION ca WRITE ica
	RANGE ghvabar, ghva, ehva
	RANGE uinf, zinf, utau, ztau 
}

UNITS {
    (mA) = (milliamp)
	(mV) = (millivolt)
}

PARAMETER {
	ghvabar = 0.0001 (mho/cm2) <0,1e9>
	ehva = 120 (mV)
}

STATE { u z }

ASSIGNED {
	v (mV)
	:ehva (mV)
	:ihva (mA/cm2)
	ica (mA/cm2)
	uinf
	zinf 
	utau (ms)
	ztau (ms)
	ghva (mho/cm2)
}

BREAKPOINT { 
	SOLVE states METHOD cnexp
	ghva = ghvabar*u*u*z
   :	ihva = ghva*(v-ehva)
    ica = ghva*(v-ehva)
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
	uinf = 1/(1+(exp(-(v+24.6)/11.3)))
	utau = 1.25*2/((exp(-0.031*(v+37.1)))+(exp(0.031*(v+37.1))))

	zinf = 1/(1+(exp((v+12.6)/18.9)))
	ztau = 420	
	UNITSON	
}
