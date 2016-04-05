package serverplus;
import lombok.Getter;
import lombok.Setter;
import java.util.Date;

/**
 *
 * @author ratheeshkv
 * This class is used for holding information about an experiment.
 * 
 */
public class ApSettings{
	//@Getter @Setter int ID=-1;
	@Getter @Setter String Name="";
	@Getter @Setter String Location="IIT Bombay";
	@Getter @Setter String Description="";
	@Getter @Setter String User="";
	@Getter @Setter String FileName="";
	@Getter @Setter int ReceivedFiles=0;
	@Getter @Setter Date StartTime;
	/**
	* constructor
	*/
	public ApSettings(String a, String b, String c, String d, String e){
		Name=a;Location=b; Description=c;User=d;FileName=e;
	}

	public int RFIncrement(){
		ReceivedFiles++;
		return ReceivedFiles;
	}
	
	/**
	* prints the experiment information
	*/
	public void print(){
		System.out.println("printing AP Settings details....");
	//	System.out.println("expID: " +ID);
		System.out.println("Name: " +Name);
		System.out.println("Location: " +Location);
		System.out.println("Description: " +Description);
		System.out.println("User: " +User);
		System.out.println("FileName: " +FileName);
	}
	
	/*
	* Initialize the start time of the experiment
	*/
	void InitializeStartTime(){
		StartTime = new Date();
	}
}
