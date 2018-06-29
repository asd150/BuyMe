
package com.cs336.BuyMe;

import java.sql.Date;

public class Awards {
	
	int PID, BuyerId, SellerId, BidId, Rating; 
	Float Amount, StartBid, ReservePrice;

	Date StartDate, EndDate, SoldAt;
	String Photo, BuyerName, SellerName, ProductName;
	
	Boolean IsElect;
	
	public Awards (int PID, int BuyerId, int SellerId, 
			int BidId, int Rating, String BuyerName, String SellerName, Float StartBid, Float ReservePrice, 
			Float Amount, Date StartDate, Date EndDate, Date SoldAt, String Photo, String ProductName, Boolean IsElect) {
		this.PID = PID;
		this.BuyerId = BuyerId;
		this.SellerId = SellerId;
		this.BidId = BidId;
		this.Rating = Rating;
		this.BuyerName = BuyerName;
		this.SellerName = SellerName;
		this.StartBid = StartBid;
		this.ReservePrice = ReservePrice;
		this.Amount = Amount;
		this.StartDate = StartDate;
		this.EndDate = EndDate;
		this.SoldAt = SoldAt;
		this.Photo = Photo;
		this.ProductName = ProductName;
		this.IsElect = IsElect;
	}

	public Boolean getIsElect() {
		return IsElect;
	}

	public void setIsElect(Boolean	IsElect) {
		this.IsElect = IsElect;
	}

	public String getProductName() {
		return ProductName;
	}

	public void setProductName(String productName) {
		ProductName = productName;
	}

	public int getPID() {
		return PID;
	}

	public void setPID(int pID) {
		PID = pID;
	}

	public int getBuyerId() {
		return BuyerId;
	}

	public void setBuyerId(int buyerId) {
		BuyerId = buyerId;
	}

	public int getSellerId() {
		return SellerId;
	}

	public void setSellerId(int sellerId) {
		SellerId = sellerId;
	}

	public int getBidId() {
		return BidId;
	}

	public void setBidId(int bidId) {
		BidId = bidId;
	}

	public int getRating() {
		return Rating;
	}

	public void setRating(int rating) {
		Rating = rating;
	}

	public Float getAmount() {
		return Amount;
	}

	public void setAmount(Float amount) {
		Amount = amount;
	}

	public Float getStartBid() {
		return StartBid;
	}

	public void setStartBid(Float startBid) {
		StartBid = startBid;
	}

	public Float getReservePrice() {
		return ReservePrice;
	}

	public void setReservePrice(Float reservePrice) {
		ReservePrice = reservePrice;
	}

	public Date getStartDate() {
		return StartDate;
	}

	public void setStartDate(Date startDate) {
		StartDate = startDate;
	}

	public Date getEndDate() {
		return EndDate;
	}

	public void setEndDate(Date endDate) {
		EndDate = endDate;
	}

	public Date getSoldAt() {
		return SoldAt;
	}

	public void setSoldAt(Date soldAt) {
		SoldAt = soldAt;
	}

	public String getPhoto() {
		return Photo;
	}

	public void setPhoto(String photo) {
		Photo = photo;
	}

	public String getBuyerName() {
		return BuyerName;
	}

	public void setBuyerName(String buyerName) {
		BuyerName = buyerName;
	}

	public String getSellerName() {
		return SellerName;
	}

	public void setSellerName(String sellerName) {
		SellerName = sellerName;
	}
	
	
}
