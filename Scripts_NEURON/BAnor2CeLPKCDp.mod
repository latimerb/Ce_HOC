:Pyramidal Cells to Pyramidal Cells AMPA+NMDA with local Ca2+ pool

NEURON {
	POINT_PROCESS banor2CeLPKCDp
	USEION ca READ eca	
	NONSPECIFIC_CURRENT inmda, iampa
	RANGE initW
	RANGE Cdur_nmda, AlphaTmax_nmda, Beta_nmda, Erev_nmda, gbar_nmda, W_nmda, on_nmda, g_nmda
	RANGE Cdur_ampa, AlphaTmax_ampa, Beta_ampa, Erev_ampa, gbar_ampa, W, on_ampa, g_ampa
	RANGE eca, ICa, P0, fCa, tauCa, iCatotal
	RANGE Cainf, pooldiam, z
	RANGE lambda1, lambda2, threshold1, threshold2
	RANGE fmax, fmin, Wmax, Wmin, maxChange, normW, scaleW, srcid, destid, limitW
	RANGE pregid,postgid, thr_rp
	RANGE F, f, tauF, D1, d1, tauD1, D2, d2, tauD2
	RANGE facfactor
	RANGE neuroM
}

UNITS { 
	(mV) = (millivolt)
        (nA) = (nanoamp)
	(uS) = (microsiemens)
	FARADAY = 96485 (coul)
	pi = 3.141592 (1)
}

PARAMETER {

	srcid = -1 (1)
	destid = -1 (1)
	
	Cdur_nmda = 16.7650 (ms)
	AlphaTmax_nmda = .2659 (/ms)
	Beta_nmda = 0.008 (/ms)
	Erev_nmda = 0 (mV)
	gbar_nmda = .5e-3 (uS)

	Cdur_ampa = 1.4210 (ms)
	AlphaTmax_ampa = 3.8142 (/ms)
	Beta_ampa = 0.1429 (/ms)
	Erev_ampa = 0 (mV)
	gbar_ampa = 1e-3 (uS)

	eca = 120

	Cainf = 50e-6 (mM)
	pooldiam =  1.8172 (micrometer)
	z = 2

	tauCa = 50 (ms)
	P0 = .015
	fCa = .024
	neuroM = 0
	lambda1 = 80 : 60 : 12 :80: 20 : 15 :8 :5: 2.5
	lambda2 = .03
	threshold1 = 2.4  :0.1  :0.2 :  0.45 : 0.35 :0.35:0.2 :0.50 (uM)
	threshold2 = 2.6  :0.15 : 0.50 : 0.40 :0.4 :0.3 :0.60 (uM)

	initW = 1 :  0.9 : 2 : 0.7 : 2 : 3 : 4 : 2: 4 : 1 : 0.3: 2 :1.5
	fmax = 2
	fmin = .8
	
	DAstart1 = 400000
	DAstop1 = 420000


	DA_t1 = 1.2 : 1
	DA_t2 = 1.4

	Beta1 = 0.001  (/ms) : 1/decay time for neuromodulators
	Beta2 = 0.0001  (/ms)
	
	GAPstart1 = 600000
	GAPstop1 = 720000	

	thr_rp = 1 : .7
	
	facfactor = 1
	: the (1) is needed for the range limits to be effective
        f = 1.2 (1) < 0, 1e9 >    : facilitation
        tauF = 20 (ms) < 1e-9, 1e9 >
        d1 = 0.95 (1) < 0, 1 >     : fast depression
        tauD1 = 40 (ms) < 1e-9, 1e9 >
        d2 = 0.9 (1) < 0, 1 >     : slow depression
        tauD2 = 70 (ms) < 1e-9, 1e9 >		
}

ASSIGNED {
	v (mV)

	inmda (nA)
	g_nmda (uS)
	on_nmda
	W_nmda

	iampa (nA)
	g_ampa (uS)
	on_ampa
	limitW

	t0 (ms)

	ICa (mA)
	Afactor	(mM/ms/nA)
	iCatotal (mA)

	dW_ampa
	Wmax
	Wmin
	maxChange
	normW
	scaleW
	
	pregid
	postgid

	rp
	tsyn
	
	fa
	F
	D1
	D2
}

STATE { r_nmda r_ampa capoolcon W }

INITIAL {
	on_nmda = 0
	r_nmda = 0
	W_nmda = initW

	on_ampa = 0
	r_ampa = 0
	W = initW

	t0 = -1
	limitW = 1
	Wmax = fmax*initW
	Wmin = fmin*initW
	maxChange = (Wmax-Wmin)/10
	dW_ampa = 0

	capoolcon = Cainf
	Afactor	= 1/(z*FARADAY*4/3*pi*(pooldiam/2)^3)*(1e6)

	fa =0
	F = 1
	D1 = 1
	D2 = 1
}

BREAKPOINT {

if ((eta(capoolcon)*(lambda1*omega(capoolcon, threshold1, threshold2)-lambda2*W))>0&&W>=Wmax) {
        limitW=1e-12
	} else if ((eta(capoolcon)*(lambda1*omega(capoolcon, threshold1, threshold2)-lambda2*W))<0&&W<=Wmin) {
        limitW=1e-12
	} else {
	limitW=1e-12 }
	SOLVE release METHOD cnexp
	
	if (t0>0) {
		if (rp < thr_rp) {
			if (t-t0 < Cdur_ampa) {
				on_ampa = 1
			} else {
				on_ampa = 0
			}
		} else {
			on_ampa = 0
		}
	}
	
		if (neuroM==1) {
	g_nmda = gbar_nmda*r_nmda*facfactor*DA1(DAstart1,DAstop1)        : Dopamine effect on NMDA to reduce NMDA current amplitude
		} else {
		g_nmda = gbar_nmda*r_nmda*facfactor
		}
		
	inmda = W_nmda*g_nmda*(v - Erev_nmda)*sfunc(v)

	g_ampa = gbar_ampa*r_ampa*facfactor
	iampa = W*g_ampa*(v - Erev_ampa)

	ICa = P0*g_nmda*(v - eca)*sfunc(v)
}

DERIVATIVE release {
		
	W' = limitW*eta(capoolcon)*(lambda1*omega(capoolcon, threshold1, threshold2)-lambda2*W)
	r_nmda' = AlphaTmax_nmda*on_nmda*(1-r_nmda)-Beta_nmda*r_nmda
	r_ampa' = AlphaTmax_ampa*on_ampa*(1-r_ampa)-Beta_ampa*r_ampa
	capoolcon'= -fCa*Afactor*ICa + (Cainf-capoolcon)/tauCa
}

NET_RECEIVE(dummy_weight) {
	if (flag==0) {           :a spike arrived, start onset state if not already on
         if ((!on_nmda)){       :this synpase joins the set of synapses in onset state
           t0=t
	      on_nmda=1		
	      net_send(Cdur_nmda,1)  
         } else if (on_nmda==1) {             :already in onset state, so move offset time
          net_move(t+Cdur_nmda)
		  t0=t
	      }
         }		  
	if (flag == 1) { : turn off transmitter, i.e. this synapse enters the offset state	
	on_nmda=0
    }
	if (flag == 0) { 
	F  = 1 + (F-1)* exp(-(t - tsyn)/tauF)
	:D1 = 1 - (1-D1)*exp(-(t - tsyn)/tauD1)
	:D2 = 1 - (1-D2)*exp(-(t - tsyn)/tauD2)
 :printf("%g\t%g\t%g\t%g\t%g\t%g\n", t, t-tsyn, F, D1, D2, facfactor)
	::printf("%g\t%g\t%g\t%g\n", F, D1, D2, facfactor)
	tsyn = t
	
	facfactor = F * D1 * D2

	F =F * f
	
	if (F > 3) { 
	F=3	}
	if (facfactor < 0.5) { 
	facfactor=0.5
	}	
	:D1 = D1 * d1
	:D2 = D2 * d2
:printf("\t%g\t%g\t%g\n", F, D1, D2)
}
}

:::::::::::: FUNCTIONs and PROCEDUREs ::::::::::::

FUNCTION sfunc (v (mV)) {
	UNITSOFF
	sfunc = 1/(1+0.33*exp(-0.06*v))
	UNITSON
}

FUNCTION eta(Cani (mM)) {
	LOCAL taulearn, P1, P2, P4, Cacon
	P1 = 0.1
	P2 = P1*1e-4
	P4 = 1
	Cacon = Cani*1e3
	taulearn = P1/(P2+Cacon*Cacon*Cacon)+P4
	eta = 1/taulearn*0.001
}

FUNCTION omega(Cani (mM), threshold1 (uM), threshold2 (uM)) {
	LOCAL r, mid, Cacon
	Cacon = Cani*1e3
	r = (threshold2-threshold1)/2
	mid = (threshold1+threshold2)/2
	if (Cacon <= threshold1) { omega = 0}
	else if (Cacon >= threshold2) {	omega = 1/(1+50*exp(-50*(Cacon-threshold2)))}
	else {omega = -sqrt(r*r-(Cacon-mid)*(Cacon-mid))}
}
FUNCTION DA1(DAstart1 (ms), DAstop1 (ms)) {
	LOCAL DAtemp1, DAtemp2, DAtemp3, DAtemp4, DAtemp5, DAtemp6, s
	DAtemp1 = DAstart1+60000
	DAtemp2 = DAtemp1+60000
	DAtemp3 = DAtemp2+60000
	DAtemp4 = DAtemp3+60000 + 120000   : 120sec Gap
	DAtemp5 = DAtemp4+60000
	DAtemp6 = DAtemp5+60000
	


if (t <= DAstart1) { DA1 = 1.0}
	else if (t >= DAstart1 && t <= DAstop1) {DA1 = DA_t1}					: 2nd tone in conditioning
		else if (t > DAstop1 && t < DAtemp1) {DA1 = 1.0 + (DA_t1-1)*exp(-Beta1*(t-DAstop1))}  			: Basal level

	
	else if (t >= DAtemp1 && t <= DAtemp1+20000) {DA1=DA_t2}					: 3rd tone   - Second Step
		else if (t > DAtemp1+20000 && t < DAtemp2) {DA1 = 1.0 + (DA_t2-1)*exp(-Beta2*(t-(DAtemp1+20000)))}			
	else if (t >= DAtemp2 && t <= DAtemp2+20000) {DA1=DA_t2}					: 4th tone
		else if (t > DAtemp2+20000 && t < DAtemp3) {DA1 = 1.0 + (DA_t2-1)*exp(-Beta2*(t-(DAtemp2+20000)))}	
	else if (t >= DAtemp3 && t <= DAtemp3+20000) {DA1=DA_t2}					: 5th tone
		else if (t > DAtemp3+20000 && t < DAtemp4) {DA1 = 1.0 + (DA_t2-1)*exp(-Beta2*(t-(DAtemp3+20000)))}	
	
	else if (t >= DAtemp4 && t <= DAtemp4+20000) {DA1=DA_t2}					: 1st tone in Extinction
		else if (t > DAtemp4+20000 && t < DAtemp5) {DA1 = 1.0 + (DA_t2-1)*exp(-Beta2*(t-(DAtemp4+20000)))}	
	else if (t >= DAtemp5 && t <= DAtemp5+20000) {DA1=DA_t2}					: 2nd tone
		else  {	DA1 = 1.0}
}

FUNCTION unirand() {    : uniform random numbers between 0 and 1
        unirand = scop_random()
}