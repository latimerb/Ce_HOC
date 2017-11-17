: spike-generating sodium channel (Pyramid)

NEURON {
	SUFFIX na
	USEION na READ ena WRITE ina
	RANGE gnabar, gna
	RANGE minf, hinf, mtau, htau
}

UNITS {
	(mA) = (milliamp)
	(mV) = (millivolt)
}

PARAMETER {
	gnabar = 0.12 (siemens/cm2) <0,1e9>
	
}

ASSIGNED {
	v (mV)
	ena (mV)
	ina (mA/cm2)
	minf
	hinf
	mtau (ms)
	htau (ms)
	gna (siemens/cm2)
}

STATE {
	m h
}

BREAKPOINT {
	SOLVE states METHOD cnexp
	gna = gnabar*m*m*m*h
	ina = gna*(v-ena)
}

INITIAL {
	rate(v)
	m = minf
	h = hinf
}

DERIVATIVE states {
	rate(v)
	m' = (minf-m)/mtau
	h' = (hinf-h)/htau
}


PROCEDURE rate(v (mV)) {
	LOCAL ma, mb, ha, hb
	UNITSOFF

	ma = -0.2816*(v+23)/(exp(-(v+23)/9.3)-1)
	mb = 0.2464*(v-4)/((exp((v-4)/6))-1)

	ha = 0.098*(exp(-(v+38.1)/20))
	hb = 1.4/((exp(-(v+8.1)/10))+1)


	minf = ma/(ma+mb)
	mtau = 1/(ma+mb)
	
	hinf = ha/(ha+hb)
	htau = 1/(ha+hb)

	UNITSON
}