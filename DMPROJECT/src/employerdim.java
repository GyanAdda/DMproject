
import 
@Entity

public class employerdim {
	int employerID;
	String CompanyName;
	String Address;
	String SectorOfEmployment;
	public int getEmployerID() {
		return employerID;
	}
	public void setEmployerID(int employerID) {
		this.employerID = employerID;
	}
	public String getCompanyName() {
		return CompanyName;
	}
	public void setCompanyName(String companyName) {
		CompanyName = companyName;
	}
	public String getAddress() {
		return Address;
	}
	public void setAddress(String address) {
		Address = address;
	}
	public String getSectorOfEmployment() {
		return SectorOfEmployment;
	}
	public void setSectorOfEmployment(String sectorOfEmployment) {
		SectorOfEmployment = sectorOfEmployment;
	}
}
