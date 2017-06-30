package com.aurospaces.neighbourhood.db.basemodel;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;



import java.util.Date;
import java.math.BigDecimal;


/**
 *
 * @author autogenerated
 */



public class BaseVendorTimeSlots 
{

@Id
@GeneratedValue(strategy=GenerationType.AUTO)
		 /** Field mapping. **/
@Column(name= "id")
protected int id   = 0;

/** Field mapping. **/
@Column(name= "created_time")
protected Date createdTime ;

/** Field mapping. **/
@Column(name= "updated_time")
protected Date updatedTime ;

/** Field mapping. **/
@Column(name= "time_slot_id")
protected int timeSlotId ;

/** Field mapping. **/
@Column(name= "vendor_id")
protected int vendorId ;

public int getId()
{
  return id;
}
public void setId(final int id)
{
  this.id = id;
}
public Date getCreatedTime()
{
  return createdTime;
}
public void setCreatedTime(final Date createdTime)
{
  this.createdTime = createdTime;
}
public Date getUpdatedTime()
{
  return updatedTime;
}
public void setUpdatedTime(final Date updatedTime)
{
  this.updatedTime = updatedTime;
}
public int getTimeSlotId()
{
  return timeSlotId;
}
public void setTimeSlotId(final int timeSlotId)
{
  this.timeSlotId = timeSlotId;
}
public int getVendorId()
{
  return vendorId;
}
public void setVendorId(final int vendorId)
{
  this.vendorId = vendorId;
}

}