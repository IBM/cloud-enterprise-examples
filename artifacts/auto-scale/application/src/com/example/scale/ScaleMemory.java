package com.example.scale;

import java.io.File;
import java.util.HashMap;
import java.util.Scanner;

public class ScaleMemory {

	public static HashMap mp = new HashMap();

	public static void main(String args[]) {
		System.out.println("Increase memory usage....");
		File f1 = new File("sample.java");
		StringBuffer buf = new StringBuffer();
		Scanner myReader;
		try {
			myReader = new Scanner(f1);
			while (myReader.hasNextLine()) {
				buf.append(myReader.nextLine());
			}
			myReader.close();
			while (true) {
				//Thread.sleep(1000);
				mp.put(System.currentTimeMillis(), buf);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
