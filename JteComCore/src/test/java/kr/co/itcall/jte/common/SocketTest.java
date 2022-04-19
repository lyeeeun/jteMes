package kr.co.itcall.jte.common;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;

import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

/**
 * Unit test for simple App.
 */
public class SocketTest extends TestCase
{
	
	final static String SERVER_IP = "http://192.168.1.19"; 
	final static int SERVER_PORT = 3308; 
	final static String MESSAGE_TO_SERVER = "Hi, Server"; 

    /**
     * Create the test case
     *
     * @param testName name of the test case
     */
    public SocketTest( String testName )
    {
        //BRANCH-zzzzdfdf
        //MASTER - TEST
    	//GGGDFDF
        super( testName );
        
        SocketTest();
    }

    /**
     * @return the suite of tests being tested
     */
    public static Test suite()
    {
        return new TestSuite( SocketTest.class );
    }

    /**
     * Rigourous Test :-)
     */
    public void testApp()
    {
        assertTrue( true );
    }
    
	public void SocketTest() {
		try {
	        String hostName = "192.168.1.19";
	        int portNumber = 3308;
	        Socket firstSocket = new Socket(hostName, portNumber);
	        PrintWriter out = new PrintWriter(firstSocket.getOutputStream(), true);
	        BufferedReader in = new BufferedReader(new InputStreamReader(firstSocket.getInputStream()));
	        BufferedReader stdIn = new BufferedReader(new InputStreamReader(System.in));
	        String userInput;
	        while ((userInput = stdIn.readLine()) != null) 
	        {
	            out.println(userInput);
	            System.out.println("received: " + in.readLine());
	        }
	        in.close();
	        stdIn.close();
	        firstSocket.close();
		}catch(Exception e) {
			
		}
	}
}
