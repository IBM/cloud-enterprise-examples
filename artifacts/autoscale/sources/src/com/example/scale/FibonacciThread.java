package com.example.scale;

public class FibonacciThread extends Thread {

	public void run() {
		int n, a = 0, b = 0, c = 1;
       
		n = 1000000000;

		for (int i = 1; i <= n; i++)

		{
			a = b;

			b = c;

			c = a + b;

			if (i == n) {

				//System.out.print(startTime + " " + a + " ");
				//System.out.println(startTime + " Completed!" + startTime);
			}

		}
	}

}
