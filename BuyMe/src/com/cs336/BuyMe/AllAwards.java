//Ritul Patel
package com.cs336.BuyMe;

import java.util.ArrayList;

public class AllAwards {
	ArrayList<Awards> awards;
	
	public AllAwards( ArrayList<Awards> awards) {
		this.awards = awards;
	}
	
	//Total earnings
	//Earnigs per : User, Item, Item-type
	//Best sellings items
	
	public Float GetTotalEarnings() {
		Float total = (float) 0.00;
		for(Awards award : awards)
		{
			total += award.Amount;
		}
		
		return total;
	}
	
	public Float GetTotalByTypeEarnings(Boolean IsElect) {
		Float total = (float) 0.00;
		for(Awards award : awards)
		{
			if(award.getIsElect() == IsElect)
				total += award.Amount;
		}
		
		return total;
	}
	
	// If ratings >3
	public ArrayList<Awards> BestSellings() {
		ArrayList<Awards> bestSellings = new ArrayList<Awards>();
		for(Awards award : awards)
		{
			if(award.Rating >= 3)
				bestSellings.add(award);
		}
		return bestSellings;
	}
}
