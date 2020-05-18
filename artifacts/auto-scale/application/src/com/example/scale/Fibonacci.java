package com.example.scale;

import java.util.logging.Level;
import java.util.logging.Logger;

public class Fibonacci {
	
	public void startApplicationLoad(int cycles) {
		Logger.getLogger(this.getClass().getName()).log(Level.INFO, "Number of cycles - "+cycles);
		for (int i = 0; i < cycles; i++) {
			(new FibonacciThread()).start();
		}
		final String podStr = System.getenv("HOSTNAME"); // identify the pod processing the request
		final String logStr = podStr + " processed /calculate request";
		Logger.getLogger(this.getClass().getName()).log(Level.INFO, logStr);
	}
	
}


























// OperatingSystemMXBean operatingSystemMXBean = ManagementFactory.getOperatingSystemMXBean();

//for (Method method : operatingSystemMXBean.getClass().getDeclaredMethods()) {
//method.setAccessible(true);
//if (method.getName().startsWith("get") && Modifier.isPublic(method.getModifiers())) {
//	Object value;
//	try {
//		value = method.invoke(operatingSystemMXBean);
//	} catch (Exception e) {
//		value = e;
//	} // try
//	System.out.println(method.getName() + " = " + value);
//} // if
//}