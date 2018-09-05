import java.io.*;
import java.util.Random;

public class Fig3A13

/* This Java program runs and outputs the simulation depicted in Figure 3A, panels 1-3, of Smolen et al. 2018.  To compile and run this, 1) Unzip the file, 2) Rename the file Fig3A13.java .  3) Install a standard Java compiler.  I used Java Development Kit from Oracle.  4)  Should compile and run with no errors. */

{  public static void main (String args[]) throws IOException {

    PrintWriter out1 = new PrintWriter(new FileWriter("bas.txt"));
    PrintWriter out2 = new PrintWriter(new FileWriter("ep1.txt"));
    PrintWriter out3 = new PrintWriter(new FileWriter("ed.txt"));
    PrintWriter out4 = new PrintWriter(new FileWriter("lp.txt"));
    PrintWriter out5 = new PrintWriter(new FileWriter("np.txt"));
    PrintWriter out6 = new PrintWriter(new FileWriter("pp.txt"));
    PrintWriter out7 = new PrintWriter(new FileWriter("wsyn.txt"));
    PrintWriter out8 = new PrintWriter(new FileWriter("ups.txt"));
    PrintWriter out9 = new PrintWriter(new FileWriter("psi.txt"));
    PrintWriter out10 = new PrintWriter(new FileWriter("stim.txt"));
    PrintWriter out11 = new PrintWriter(new FileWriter("ep2.txt"));
    PrintWriter out12 = new PrintWriter(new FileWriter("stab.txt"));
    PrintWriter out13 = new PrintWriter(new FileWriter("lac.txt"));


    double dt=0.0002; // high-res timestep (min) 

    double delta=0.1; // low-res timestep (min)

	double tequil=10000.0; // time for variables to equilibrate before stimulus

    double recstart=tequil+0.01; // Time to start writing data

	double tstim=50.0+tequil; // time of stimulus

	double tofflac=15000000.0+tstim; /* time to optionally turn off LAC early.  Here just set to a very large value to model irreversible LAC inhibition */

   double recend=349.99 + tequil; // Time to end simulation and stop writing data

	double ofset=0.0; // offset of LAC inhibition start after PSI start.  Zero in canonical case

// Parameters

	double c1=5.0;
	double c2=8.0;
	double c3=4.0;
	double c4=8.0;
	double kb3=0.02;
	double kf5=0.0005;
	double kdeg2=0.01;
	double kdeg1=0.005;
	double stdur=20.0;
	double kact=0.2;
	double kdeact=0.0143;
	double kactbas=0.00214;
	double psiamp=0.0; // 1.0 total inhibition, 0.0 no inhibition, 0.95 is canonical inhibition
	double kb1=0.005;
	double kb2=0.0007;
	double stimamp=1.0;
	double lac;
	double lacamp=0.95; // 1.0 total inhibition, 0.0 no inhibition, 0.95 is canonical inhibition
	double kf1=0.1;
	double kf1bas=0.001;
	double kb4=0.001;
	double kf2=0.02;	
	double kf4=0.02;
	double ksyn1=1.0;
	double ksyn2=2.0;
	double ksyn1bas=0.0035;
	double ksyn2bas=0.0014;
	double kdeg2bas=0.002;
	double ksyn3=1.0;
	double kdeg3=0.02;
	double ksyn3bas=0.008;
	double kf3=0.01;

// Variables

	double bas;
	double ep1;
	double ep2;
	double ed;
	double lp;
	double np;
	double pp;
	double stab;
	double wsyn;
	double stim;
	double ups;
	double psi;

    	double dv1dt=0.0;
    	double dv2dt=0.0;
    	double dv3dt=0.0;
    	double dv4dt=0.0;
	double dv5dt=0.0;
	double dv6dt=0.0;
    	double dv7dt=0.0;
    	double dv8dt=0.0;
    	double dv9dt=0.0;
    	double dv10dt=0.0;

    double time; // time (minutes)

	time = 0.0;

	double twrite; // written time

    int i, k, j, l, m; // counters

	double[] values = new double[12];

/* set initial conditions so that all synaptic states add up to 1.0.  other initial conditions just set to small numbers, will equilibrate prior to stimulus */
	values[1]=0.96; 
	values[2]=0.01;
	values[3]=0.01;
	values[4]=0.01;
	values[5]=0.01; 
	values[6]=0.01;
	values[7]=1.0;
	values[8]=0.01;
	values[9]=0.01;
	values[10]=0.001;


        k=1;
        do {  

            j=1;
            do {

	bas=values[1];
	ep1=values[2];
	ed=values[3];
	lp=values[4];
	np=values[5];
	pp=values[6];
	ep2=values[8];
	stab=values[9];
	ups=values[10];

       wsyn = bas + c1*ep1+c2*ep2 + c3*ed + c4*lp;

	stim = 0.0;
	psi = 0.0;
	lac = 0.0;
	kf1bas = 0.001;

	if ((time > tstim) && (time < (tstim+stdur)))
	{
		stim = stimamp;
		kf1bas = 0.0;
	}
	if (time > (tstim-40.0))
	{
		psi = psiamp;
	}

	if (time > (tstim-40.0+ofset))
	{
		lac = lacamp;
	}


	if (time > tofflac)
	{
		lac = 0.0;
	}


		dv1dt = kb3*ed-kf1*bas*stim-kf1bas*bas+kb4*lp+kb2*ep2*np+kb1*ep1;

		dv2dt = kf1*bas*stim+kf1bas*bas-kf2*ep1*ups*(1.0-lac)-kb1*ep1-kf3*stab*ep1;

		dv3dt = kf2*ep1*ups*(1.0-lac)+kf4*ep2*ups*(1.0-lac)-kb3*ed-kf5*pp*pp*ed;

		dv4dt = kf5*pp*pp*ed-kb4*lp;

		dv5dt = ksyn2*(1.0-psi)*stim-kdeg2*np*ups*(1.0-lac)-kdeg2bas*np+ksyn2bas*(1.0-psi);

		dv6dt = ksyn1*(1.0-psi)*stim-kdeg1*pp+ksyn1bas*(1.0-psi);

		dv8dt = kf3*stab*ep1-kf4*ep2*ups*(1.0-lac)-kb2*ep2*np;

		dv9dt = ksyn3*stim-kdeg3*stab+ksyn3bas;

	/*	dv9dt = 0.0; // apply if weak stimulus that can only give early LTP  */

		dv10dt = kact*stim-kdeact*ups+kactbas;

		values[1]+=dt*dv1dt;
		values[2]+=dt*dv2dt;
		values[3]+=dt*dv3dt;
		values[4]+=dt*dv4dt;
		values[5]+=dt*dv5dt;
		values[6]+=dt*dv6dt;
		values[7] = wsyn;
		values[8]+=dt*dv8dt;
		values[9]+=dt*dv9dt;
		values[10]+=dt*dv10dt;

                time=time+dt;

                j++;
               } while (j <= delta/dt);

/* Note scaling factors in write statements below can vary depending on simulation parameters */

            if ((time > recstart) && (time < recend))
           {
			twrite=time-tstim;
               out1.println(twrite + "\t" + 1.0*bas);
               out2.println(twrite + "\t" + 2.0*ep1);
               out3.println(twrite + "\t" + 10.0*ed);
               out4.println(twrite + "\t" + 10.0*lp);
               out5.println(twrite + "\t" + 1.0*np);
               out6.println(twrite + "\t" + 1.0*pp);
               out7.println(twrite + "\t" + 1.0*wsyn);
               out8.println(twrite + "\t" + 1.0*ups);
               out9.println(twrite + "\t" + 1.0*psi);
               out10.println(twrite + "\t" + 1.0*stim);
               out11.println(twrite + "\t" + 2.0*ep2);
               out12.println(twrite + "\t" + 1.0*stab);
               out13.println(twrite + "\t" + 1.0*lac);

	     }

            k++;
           } while (k <= recend/delta);

      out1.close();
      out2.close();
      out3.close();
      out4.close();
      out5.close();
      out6.close();
      out7.close();
      out8.close();
      out9.close();
      out10.close();
      out11.close();
      out12.close();
      out13.close();

       }
}
