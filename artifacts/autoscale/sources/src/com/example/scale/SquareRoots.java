package com.example.scale;

import java.util.logging.Level;
import java.util.logging.Logger;

public class SquareRoots {
	
	public void startApplicationLoad(int cycles) {
		Logger.getLogger(this.getClass().getName()).log(Level.INFO, "Number of cycles - "+cycles);
		for (int i = 0; i < cycles; i++) {
			(new SquareRootThread()).start();
		}
		final String podStr = System.getenv("HOSTNAME"); // identify the pod processing the request
		final String logStr = podStr + " processed /calculate request";
		Logger.getLogger(this.getClass().getName()).log(Level.INFO, logStr);
	}

}
